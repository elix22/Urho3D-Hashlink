package urho3d;

typedef HL_URHO3D_TANIMATION_STATE = hl.Abstract<"hl_urho3d_graphics_tanimation_state">;

@:hlNative("Urho3D")
abstract AnimationState(HL_URHO3D_TANIMATION_STATE) {

    public var weight(get, set):Float;
	public var time(get, set):Float;
    public var looped(get, set):Bool;
    
    
    public function AddTime(f:Float):Void {
		_AddTime( cast this, f);
	}

	public function AddWeight(w:Float):Void {
		_AddWeight(cast this, w);
	}

	function set_weight(w) {
		_SetWeight( cast this, w);
		return w;
	}

	function get_weight() {
		return _GetWeight( cast this);
	}

	function set_time(w) {
		_SetTime(cast this, w);
		return w;
	}

	function get_time() {
		return _GetTime( cast this);
	}

	function set_looped(w) {
		_SetLooped(cast this, w);
		return w;
	}

	function get_looped() {
		return _GetLooped( cast this);
	}


    @:hlNative("Urho3D", "_graphics_tanimation_state_set_weight")
	private static function _SetWeight( a:AnimationState, w:Single):Void {}

	@:hlNative("Urho3D", "_graphics_tanimation_state_get_weight")
	private static function _GetWeight( a:AnimationState):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_tanimation_state_set_time")
	private static function _SetTime( a:AnimationState, w:Single):Void {}

	@:hlNative("Urho3D", "_graphics_tanimation_state_get_time")
	private static function _GetTime(a:AnimationState):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_tanimation_state_set_looped")
	private static function _SetLooped( a:AnimationState, w:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_tanimation_state_get_looped")
	private static function _GetLooped(a:AnimationState):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_tanimation_state_add_time")
	private static function _AddTime( a:AnimationState, w:Single):Void {}

	@:hlNative("Urho3D", "_graphics_tanimation_state_add_weight")
	private static function _AddWeight( a:AnimationState, w:Single):Void {}

}
