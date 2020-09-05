package urho3d;

import urho3d.actions.ActionManager;

typedef Long = haxe.Int64;

typedef HLDynEvent = {
	var stringHash:StringHash;
	var testInt:Int;
	var dynStringHash:Dynamic;
}

/// Delay-executed function or method call.
class DelayedCall {
	public function new() {
		period_ = 0.0;
		delay_ = 0.0;
		repeat_ = false;
		obj_ = null;
		declaration_ = "";
		parameters_ = [];
	}

	/// Period for repeating calls.
	public var period_:Float;
	/// Delay time remaining until execution.
	public var delay_:Float;
	/// Repeat flag.
	public var repeat_:Bool;
	// Instance that has the function.
	public var obj_:Dynamic;
	/// Function declaration.
	public var declaration_:String;
	/// Parameters.
	public var parameters_:Array<Dynamic>;
}

class Application {
	public static var application:Application = null;

	public var abstractApplication:AbstractApplication;

	public static var context = null;

	var delayedCalls:Array<DelayedCall> = [];

	public inline function new() {
		context = new urho3d.Context();
		abstractApplication = new AbstractApplication(context, this);
		abstractApplication.RegisterSetupClosure(Setup);
		abstractApplication.RegisterStartClosure(Start);
		abstractApplication.RegisterStopClosure(Stop);
		application = this;

		LogicComponent.RegisterObject();
	}

	public function Run() {
		abstractApplication.Run();
	}

	@:final
	private function PreSetup() {
		var args = Sys.args();
		var is_hl:Bool = false;
		var rpp:String = "";
		for (i in 0...args.length) {
			if (args[i] == "-hl") {
				is_hl = true;
			}
			if (args[i] == "-rpp" && (i + 1) < args.length) {
				rpp = args[i + 1];
			}
		}

		if (is_hl == true) {
			engineParameters[EP_RESOURCE_PREFIX_PATHS] = Sys.getCwd() + "/bin";
		}
		if (rpp != "") {
			engineParameters[EP_RESOURCE_PREFIX_PATHS] = rpp;
		}
	}

	public function Setup():Void {
		// trace("hx Application setup called ");
	}

	public function Start():Void {
		// trace("hx Application start called ");
	}

	public function Stop():Void {
		// trace("hx Application Stop called ");
	}

	@:keep
	@:final
	private function OnTick(timeStep:Float):Void {
		//	trace("OnTick " + timeStep);

		if (ActionManager.IsRunning()) {
			ActionManager.Step(timeStep);
		}

		// Execute delayed calls
		for (call in delayedCalls) {
			var remove:Bool = false;

			call.delay_ -= timeStep;
			if (call.delay_ <= 0.0) {
				if (!call.repeat_)
					remove = true;
				else
					call.delay_ += call.period_;

				InvokeObject(call.obj_, call.declaration_, call.parameters_);
			}

			if (remove)
				delayedCalls.remove(call);
		}
	}

	// private static function SetScreenJoystickPatchString(ptr:HL_URHO3D_APPLICATION, s:String):Void
	public inline function SetScreenJoystickPatchString(s:String) {
		abstractApplication.SetScreenJoystickPatchString(s);
	}

	@:final
	public function SubscribeToEvent(?object:Object, stringHash:StringHash, s:String) {
		if (abstractApplication != null) {
			abstractApplication.SubscribeToEvent(stringHash, this, s);
		}
	}

	@:final
	public var engineParameters(get, never):TVariantMap;

	function get_engineParameters() {
		return abstractApplication.GetEngineParameters();
	}

	@:final
	public inline function Random(?min:Null<Float>, ?max:Null<Float>):Float {
		var rand:Float = Std.random(1000000) / 1000000.0;
		if (min == null)
			return rand;
		else if (min != null && max == null) {
			return rand * min;
		} else {
			return rand * (max - min) + min;
		}
	}

	@:final

	// public function Clamp<T:Int & Single & Float>(value:T, min:T, max:T) {
	public inline function Clamp(value:Float, min:Float, max:Float) {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}

	@:final
	public inline function IClamp(value:Int, min:Int, max:Int) {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}

	@:final
	public inline function IsTouchEnabled():Bool {
		return abstractApplication.IsTouchEnabled();
	}

	@:keep
	@:final
	public function Invoke(f:String, args:Array<Dynamic>) {
		try {
			var fn = Reflect.field(this, f);
			if (fn != null) {
				Reflect.callMethod(this, fn, args);
			}
		} catch (e) {}
	}

	@:keep
	@:final
	public function InvokeObject(obj:Dynamic, f:String, args:Array<Dynamic>) {
		try {
			if (obj != null) {
				var fn = Reflect.field(obj, f);
				if (fn != null) {
					Reflect.callMethod(obj, fn, args);
				}
			}
		} catch (e) {}
	}

	@:keep
	@:final
	public function InvokeDelayed(delay:Float = 0.0, repeat:Bool = false, func:String, args:Array<Dynamic>) {
		InvokeDelayedObject(delay, repeat, this, func, args);
	}

	@:keep
	@:final
	public function InvokeDelayedObject(delay:Float = 0.0, repeat:Bool = false, obj:Dynamic, func:String, args:Array<Dynamic>) {
		if (delay == 0.0) {
			InvokeObject(obj, func, args);
		} else {
			var call:DelayedCall = new DelayedCall();
			call.period_ = call.delay_ = Math.Max(delay, 0.0);
			call.repeat_ = repeat;
			call.declaration_ = func;
			call.parameters_ = args;
			call.obj_ = obj;
			delayedCalls.push(call);
		}
	}

	public function ClearInvokeDelayed(declaration:String = "") {
		for (call in delayedCalls) {
			if (call.declaration_ == declaration && call.obj_ == this) {
				delayedCalls.remove(call);
			} else if (declaration == "" && call.obj_ == this) {
				delayedCalls.remove(call);
			}
		}
	}

	public function ClearInvokeDelayedObject(obj:Dynamic, declaration:String = "") {
		if (obj != null) {
			for (call in delayedCalls) {
				if (call.declaration_ == declaration && call.obj_ == obj) {
					delayedCalls.remove(call);
				} else if (declaration == "" && call.obj_ == obj) {
					delayedCalls.remove(call);
				}
			}
		}
	}

	final EP_AUTOLOAD_PATHS = "AutoloadPaths";
	final EP_BORDERLESS = "Borderless";
	final EP_DUMP_SHADERS = "DumpShaders";
	final EP_EVENT_PROFILER = "EventProfiler";
	final EP_EXTERNAL_WINDOW = "ExternalWindow";
	final EP_FLUSH_GPU = "FlushGPU";
	final EP_FORCE_GL2 = "ForceGL2";
	final EP_FRAME_LIMITER = "FrameLimiter";
	final EP_FULL_SCREEN = "FullScreen";
	final EP_HEADLESS = "Headless";
	final EP_HIGH_DPI = "HighDPI";
	final EP_LOG_LEVEL = "LogLevel";
	final EP_LOG_NAME = "LogName";
	final EP_LOG_QUIET = "LogQuiet";
	final EP_LOW_QUALITY_SHADOWS = "LowQualityShadows";
	final EP_MATERIAL_QUALITY = "MaterialQuality";
	final EP_MONITOR = "Monitor";
	final EP_MULTI_SAMPLE = "MultiSample";
	final EP_ORIENTATIONS = "Orientations";
	final EP_PACKAGE_CACHE_DIR = "PackageCacheDir";
	final EP_RENDER_PATH = "RenderPath";
	final EP_REFRESH_RATE = "RefreshRate";
	final EP_RESOURCE_PACKAGES = "ResourcePackages";
	final EP_RESOURCE_PATHS = "ResourcePaths";
	final EP_RESOURCE_PREFIX_PATHS = "ResourcePrefixPaths";
	final EP_SHADER_CACHE_DIR = "ShaderCacheDir";
	final EP_SHADOWS = "Shadows";
	final EP_SOUND = "Sound";
	final EP_SOUND_BUFFER = "SoundBuffer";
	final EP_SOUND_INTERPOLATION = "SoundInterpolation";
	final EP_SOUND_MIX_RATE = "SoundMixRate";
	final EP_SOUND_STEREO = "SoundStereo";
	final EP_TEXTURE_ANISOTROPY = "TextureAnisotropy";
	final EP_TEXTURE_FILTER_MODE = "TextureFilterMode";
	final EP_TEXTURE_QUALITY = "TextureQuality";
	final EP_TIME_OUT = "TimeOut";
	final EP_TOUCH_EMULATION = "TouchEmulation";
	final EP_TRIPLE_BUFFER = "TripleBuffer";
	final EP_VSYNC = "VSync";
	final EP_WINDOW_HEIGHT = "WindowHeight";
	final EP_WINDOW_ICON = "WindowIcon";
	final EP_WINDOW_POSITION_X = "WindowPositionX";
	final EP_WINDOW_POSITION_Y = "WindowPositionY";
	final EP_WINDOW_RESIZABLE = "WindowResizable";
	final EP_WINDOW_TITLE = "WindowTitle";
	final EP_WINDOW_WIDTH = "WindowWidth";
	final EP_WORKER_THREADS = "WorkerThreads";
}
