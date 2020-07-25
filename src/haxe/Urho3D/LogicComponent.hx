package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_LOGIC_COMPONENT = hl.Abstract<"hl_urho3d_scene_logic_component">;

class LogicComponent extends Component {
	private var abstractLogicComponent:AbstractLogicComponent = null;

	public inline function new() {
		abstractLogicComponent = new AbstractLogicComponent(this);
		super(AbstractLogicComponent.CastToComponent(Context.context, abstractLogicComponent));
	}

	@:keep
	public function Start():Void {
		// trace("Start");
	}

	@:keep
	public function DelayedStart():Void {
		//	 trace(" DelayedStart  ");
	}

	@:keep
	public function Stop():Void {
		//	 trace("  Stop  ");
	}

	@:keep
	public function Update(timeStep:Float):Void {
		//	 trace("Update " + timeStep);
	}

	@:keep
	public function PostUpdate(timeStep:Float):Void {
		//  trace("PostUpdate " + timeStep);
	}

	@:keep
	public function FixedUpdate(timeStep:Float):Void {
		// trace("FixedUpdate " + timeStep);
	}

	@:keep
	public function FixedPostUpdate(timeStep:Float):Void {
		// trace("FixedPostUpdate " + timeStep);
	}

     /* reflection doesnlt work on iOS
	@:keep
	public function CallMethod(f:String, args:Array<Dynamic>) {
		try {
			var fn = Reflect.field(this, f);
			if (fn != null) {
				Reflect.callMethod(this, fn, args);
			}
		} catch (e) {}
	}

   
	@:keep
	public function CallObjectMethod(dyn:Dynamic, f:String, args:Array<Dynamic>) {
		try {
			var fn = Reflect.field(dyn, f);
			if (fn != null) {
				Reflect.callMethod(dyn, fn, args);
			}
		} catch (e) {}
	}
*/
	@:keep
	public function Random(?min:Null<Float>, ?max:Null<Float>):Float {
		var rand = Std.random(100000) / 100000.0;
		if (min == null)
			return rand;
		else if (min != null && max == null) {
			return rand * min;
		} else {
			return rand * (max - min) + min;
		}
    }
    
}

@:hlNative("Urho3D")
abstract AbstractLogicComponent(HL_URHO3D_LOGIC_COMPONENT) {
	public inline function new(d:Dynamic) {
		this = Create(Context.context, d);
	}

	@:hlNative("Urho3D", "_scene_logic_component_create")
	private static function Create(c:Context, d:Dynamic):HL_URHO3D_LOGIC_COMPONENT {
		return null;
	}

	@:hlNative("Urho3D", "_scene_logic_component_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractLogicComponent {
		return null;
	}

	@:hlNative("Urho3D", "_scene_logic_component_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractLogicComponent):AbstractComponent {
		return null;
	}
}
