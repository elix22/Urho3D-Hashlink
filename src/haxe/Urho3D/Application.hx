package urho3d;

typedef Long = haxe.Int64;

typedef HLDynEvent = {
	var stringHash:StringHash;
	var testInt:Int;
	var dynStringHash:Dynamic;
}

class Application {
	public static var application:Application = null;

	public var abstractApplication:AbstractApplication;

	public static var context = null;

	public inline function new() {
		context = new urho3d.Context();
		abstractApplication = new AbstractApplication(context);
		abstractApplication.RegisterSetupClosure(Setup);
		abstractApplication.RegisterStartClosure(Start);
		abstractApplication.RegisterStopClosure(Stop);
		application = this;

		LogicComponent.RegisterObject();
	}

	public function Run() {
		abstractApplication.Run();
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

	// private static function SetScreenJoystickPatchString(ptr:HL_URHO3D_APPLICATION, s:String):Void
	public inline function SetScreenJoystickPatchString(s:String) {
		abstractApplication.SetScreenJoystickPatchString(s);
	}

	public function SubscribeToEvent(?object:Object, stringHash:StringHash, s:String) {
		if (abstractApplication != null) {
			abstractApplication.SubscribeToEvent(stringHash, this, s);
		}
	}

	public var engineParameters(get, never):TVariantMap;

	function get_engineParameters() {
		return abstractApplication.GetEngineParameters();
	}

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

	// public function Clamp<T:Int & Single & Float>(value:T, min:T, max:T) {
	public inline function Clamp(value:Float, min:Float, max:Float) {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}

	public inline function IClamp(value:Int, min:Int, max:Int) {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}

	public inline function IsTouchEnabled():Bool {
		return abstractApplication.IsTouchEnabled();
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
