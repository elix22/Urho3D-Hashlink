package urho3d;

import haxe.Constraints.FlatEnum;
import urho3d.AnimatedModel.AbstractAnimatedModel;

typedef HL_URHO3D_ANIMATION_STATE = hl.Abstract<"hl_urho3d_graphics_animation_state">;

@:hlNative("Urho3D")
abstract AnimationState(HL_URHO3D_ANIMATION_STATE) {
	public var weight(get, set):Float;
	public var time(get, set):Float;
	public var looped(get, set):Bool;

	public inline function new(m:AnimatedModel, a:Animation) {
		this = Create(Context.context, m._abstract, a);
	}

	public function AddTime(f:Float):Void {
		_AddTime(Context.context, cast this, f);
	}

	public function AddWeight(w:Float):Void {
		_AddWeight(Context.context, cast this, w);
	}

	function set_weight(w) {
		_SetWeight(Context.context, cast this, w);
		return w;
	}

	function get_weight() {
		return _GetWeight(Context.context, cast this);
	}

	function set_time(w) {
		_SetTime(Context.context, cast this, w);
		return w;
	}

	function get_time() {
		return _GetTime(Context.context, cast this);
	}

	function set_looped(w) {
		_SetLooped(Context.context, cast this, w);
		return w;
	}

	function get_looped() {
		return _GetLooped(Context.context, cast this);
	}

	@:hlNative("Urho3D", "_graphics_animation_state_create")
	private static function Create(context:Context, m:AbstractAnimatedModel, a:Animation):HL_URHO3D_ANIMATION_STATE {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animation_state_set_weight")
	private static function _SetWeight(context:Context, a:AnimationState, w:Single):Void {}

	@:hlNative("Urho3D", "_graphics_animation_state_get_weight")
	private static function _GetWeight(context:Context, a:AnimationState):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_animation_state_set_time")
	private static function _SetTime(context:Context, a:AnimationState, w:Single):Void {}

	@:hlNative("Urho3D", "_graphics_animation_state_get_time")
	private static function _GetTime(context:Context, a:AnimationState):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_animation_state_set_looped")
	private static function _SetLooped(context:Context, a:AnimationState, w:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_animation_state_get_looped")
	private static function _GetLooped(context:Context, a:AnimationState):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_animation_state_add_time")
	private static function _AddTime(context:Context, a:AnimationState, w:Single):Void {}

	@:hlNative("Urho3D", "_graphics_animation_state_add_weight")
	private static function _AddWeight(context:Context, a:AnimationState, w:Single):Void {}
}
