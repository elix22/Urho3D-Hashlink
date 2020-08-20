package urho3d;

import urho3d.AbstractApplication.Dyn;
import urho3d.Scene.AbstractScene;
import urho3d.Node.AbstractNode;
import urho3d.Component.AbstractComponent;
import haxe.ds.ObjectMap;

typedef HL_URHO3D_LOGIC_COMPONENT = hl.Abstract<"hl_urho3d_scene_logic_component">;

enum abstract UpdateEvent(Int) to Int from Int {
	/// Bitmask for not using any events.
	var USE_NO_EVENT = 0x0;
	/// Bitmask for using the scene update event.
	var USE_UPDATE = 0x1;
	/// Bitmask for using the scene post-update event.
	var USE_POSTUPDATE = 0x2;
	/// Bitmask for using the physics update event.
	var USE_FIXEDUPDATE = 0x4;
	/// Bitmask for using the physics post-update event.
	var USE_FIXEDPOSTUPDATE = 0x8;

	@:op(A | B)
	public inline function OpMathOr(rhs:Int):Int {
		return this | rhs;
	}
}

class LogicComponent extends Component {
	private var abstractLogicComponent:AbstractLogicComponent = null;

	@:keep
	public static function CreateFactory(name:HString, ?rhs:AbstractLogicComponent):Dynamic {
		return Type.createInstance(Type.resolveClass(name), [rhs]);
	}

	@:keep
	public inline function new(?rhs:AbstractLogicComponent) {
		if (rhs != null) {
			abstractLogicComponent = rhs;
		} else {
			abstractLogicComponent = new AbstractLogicComponent(this, Std.string(this));
		}

		super(AbstractLogicComponent.CastToComponent(Context.context, abstractLogicComponent));
	}

	
	@:keep public function GetFields() {
		return Reflect.fields(this);
	}

	
	@:keep public inline function GetField(name:HString):Dynamic {
		return Reflect.field(this, name);
	}

	@:keep public inline function GetFieldType(name:HString):HString {
		var objField = GetField(name);
		return Std.string(objField);
	}

	public var updateEventMask(get, set):UpdateEvent;

	function set_updateEventMask(m) {
		AbstractLogicComponent.SetUpdateEventMask(Context.context, abstractLogicComponent, m);
		return m;
	}

	function get_updateEventMask() {
		return AbstractLogicComponent.GetUpdateEventMask(Context.context, abstractLogicComponent);
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

	@:keep
	private function _OnNodeSet(node:AbstractNode):Void {
		OnNodeSet(node);
	}

	@:keep
	public function OnNodeSet(node:Node):Void {}

	@:keep
	private function _OnSceneSet(scene:AbstractScene):Void {
		OnSceneSet(scene);
	}

	@:keep
	public function OnSceneSet(scene:Scene):Void {}

	@:keep
	private function _OnMarkedDirty(node:AbstractNode):Void {
		OnMarkedDirty(node);
	}

	@:keep
	public function OnMarkedDirty(node:Node):Void {}

	@:keep
	private function _OnNodeSetEnabled(node:AbstractNode) {
		OnNodeSetEnabled(node);
	}

	@:keep
	public function OnNodeSetEnabled(node:Node) {}

	@:keep
	public function CallMethod(f:String, args:Array<Dynamic>) {
		try {
			var fn = Reflect.field(this, f);
			if (fn != null) {
				Reflect.callMethod(this, fn, args);
			}
		} catch (e) {}
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

	public static function RegisterObject():Void {
		AbstractLogicComponent.RegisterObject(Context.context);
	}
}

@:hlNative("Urho3D")
abstract AbstractLogicComponent(HL_URHO3D_LOGIC_COMPONENT) {
	public inline function new(d:Dynamic, className:String) {
		this = Create(Context.context, d, className);
	}

	@:hlNative("Urho3D", "_scene_logic_component_create")
	private static function Create(c:Context, d:Dynamic, className:String):HL_URHO3D_LOGIC_COMPONENT {
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

	/*
		DEFINE_PRIM(_VOID, _scene_logic_component_set_update_event_mask, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT _I32);
		DEFINE_PRIM(_I32, _scene_logic_component_get_update_event_mask, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT );
	 */
	@:hlNative("Urho3D", "_scene_logic_component_set_update_event_mask")
	public static function SetUpdateEventMask(c:Context, s:AbstractLogicComponent, m:Int):Void {}

	@:hlNative("Urho3D", "_scene_logic_component_get_update_event_mask")
	public static function GetUpdateEventMask(c:Context, s:AbstractLogicComponent):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_scene_logic_component_register_object")
	public static function RegisterObject(c:Context):Void {}
}
