package urho3d;

import urho3d.IntVector2.StructIntVector2;


class Input {
	public static var mouseMove(get, never):StructIntVector2;
	public static var numTouches(get, never):Int;

	private static function get_mouseMove() {
		return {x: GetMouseMoveX(Context.context), y: GetMouseMoveY(Context.context)};
	}

	private static function get_numTouches() {
		return GetNumTouches(Context.context);
	}


	public static inline function touchID(index:Int):Int {
		return GetTouchID(Context.context, index);
	}

	public static inline function GetTouch(index:Int):TouchState {
		return _GetTouch(Context.context, index);
	}

	@:hlNative("Urho3D", "_input_get_mousemove")
	private static function GetMouseMove(context:Context):IntVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_input_get_mousemove_x")
	private static function GetMouseMoveX(context:Context):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_mousemove_y")
	private static function GetMouseMoveY(context:Context):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_num_touches")
	private static function GetNumTouches(context:Context):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_touch_id")
	private static function GetTouchID(context:Context, index:Int):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_touch_position_x")
	private static function GetTouchPositionX(context:Context, index:Int):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_touch_position_y")
	private static function GetTouchPositionY(context:Context, index:Int):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_touch_last_position_x")
	private static function GetTouchLastPositionX(context:Context, index:Int):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_touch_last_position_y")
	private static function GetTouchLastPositionY(context:Context, index:Int):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_touch_delta_x")
	private static function GetTouchDeltaX(context:Context, index:Int):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_touch_delta_y")
	private static function GetTouchDeltaY(context:Context, index:Int):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_input_get_touch_pressure")
	private static function GetTouchPressure(context:Context, index:Int):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_input_touch_state_get")
	private static function _GetTouch(context:Context, index:Int):TouchState {
		return null;
	}
}
