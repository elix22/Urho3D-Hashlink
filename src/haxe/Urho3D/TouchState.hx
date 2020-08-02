package urho3d;

typedef HL_URHO3D_TOUCH_STATE = hl.Abstract<"hl_urho3d_input_touch_state">;

/*
	@:structInit class TouchState {
	public var touchID:Int;
	public var position:StructIntVector2;
	public var lastPosition:StructIntVector2;
	public var delta:StructIntVector2;
	public var pressure:Float;

	}
 */
@:hlNative("Urho3D")
abstract TouchState(HL_URHO3D_TOUCH_STATE) {
	public var touchID(get, never):Int;
	public var position(get, never):TIntVector2;
	public var lastPosition(get, never):TIntVector2;
	public var delta(get, never):TIntVector2;
	public var pressure(get, never):Float;

	public function new() {
		this = null;
	}

	function get_touchID() {
		return GetTouchID(cast this);
	}

	function get_position() {
		return GetTouchPosition(cast this);
    }

    function get_lastPosition() {
		return GetTouchLastPosition(cast this);
    }
    
    function get_delta() {
		return GetTouchDelta(cast this);
    }

    function get_pressure()
        {
            return GetTouchPressure(cast this);
        }

	@:hlNative("Urho3D", "_input_touch_state_get_id")
	private static function GetTouchID(t:TouchState):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_touch_state_get_position")
	private static function GetTouchPosition(t:TouchState):TIntVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_input_touch_state_get_last_position")
	private static function GetTouchLastPosition(t:TouchState):TIntVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_input_touch_state_get_delta")
	private static function GetTouchDelta(t:TouchState):TIntVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_input_touch_state_get_pressure")
	private static function GetTouchPressure(t:TouchState):Single {
		return 0.0;
	}

}
