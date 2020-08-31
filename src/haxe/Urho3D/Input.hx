package urho3d;

import urho3d.IntVector2.StructIntVector2;
import urho3d.KeyCode;
import urho3d.Math.IntMathDefs;

enum abstract MouseMode(Int) to Int from Int
{
    var MM_ABSOLUTE = 0;
    var MM_RELATIVE = 1;
    var MM_WRAP = 2;
    var MM_FREE = 3;
    var MM_INVALID = 4;
}

enum abstract  MouseButton(Int)  to Int from Int
{
    var MOUSEB_NONE = 0;
    var MOUSEB_LEFT = SDL_BUTTON_LMASK;
    var MOUSEB_MIDDLE = SDL_BUTTON_MMASK;
    var MOUSEB_RIGHT = SDL_BUTTON_RMASK;
    var MOUSEB_X1 = SDL_BUTTON_X1MASK;
    var MOUSEB_X2 = SDL_BUTTON_X2MASK;
    var MOUSEB_ANY = M_MAX_UNSIGNED;
}

@:hlNative("Urho3D")
abstract KeyDown(Int) {

	@:arrayAccess
	public inline function  getKeyDown(index:Int):Bool {
		return _GetKeyDown(Context.context, index);
	}

	@:hlNative("Urho3D", "_input_get_key_down")
	private static function _GetKeyDown(context:Context, index:Int):Bool {
		return false;
	}
}


@:hlNative("Urho3D")
abstract KeyPress(Int) {

	@:arrayAccess
	public inline function  getKeyPress(index:Int):Bool {
		return _GetKeyPress(Context.context, index);
	}

	@:hlNative("Urho3D", "_input_get_key_press")
	private static function _GetKeyPress(context:Context, index:Int):Bool {
		return false;
	}
}

class Input {
	public static var mouseMove(get, never):StructIntVector2;
	public static var mouseMoveX(get, never):Int;
	public static var mouseMoveY(get, never):Int;
	public static var numTouches(get, never):Int;

	public static var keyDown:KeyDown;
	public static var keyPress:KeyPress;

	public static var mousePosition(get,never):TIntVector2;

	static function get_mousePosition() {
		return GetMousePosition(Context.context);
	}

	public static function GetKeyDown(key:KeyCode):Bool{
		return _GetKeyDown(Context.context,key);
	}

	public static function GetKeyPress(key:KeyCode):Bool{
		return _GetKeyPress(Context.context,key);
	}

	private static function get_mouseMove() {
		return {x: GetMouseMoveX(Context.context), y: GetMouseMoveY(Context.context)};
	}

	private static function get_mouseMoveX() {
		return GetMouseMoveX(Context.context);
	}

	private static function get_mouseMoveY() {
		return GetMouseMoveY(Context.context);
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

	public static inline function SetMouseVisible(b:Bool) {
		_SetMouseVisible(Context.context,b);
	}

	public static inline function SetMouseMode(m:MouseMode) {
		_SetMouseMode(Context.context,m);
	}

	public static inline function GetMouseButtonPress(m:MouseButton) {
		return _GetMouseButtonPress(Context.context,m);
	}

	public static inline function GetMouseButtonDown(m:MouseButton) {
		return _GetMouseButtonDown(Context.context,m);
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

	@:hlNative("Urho3D", "_input_get_key_down")
	private static function _GetKeyDown(context:Context, index:Int):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_input_get_key_press")
	private static function _GetKeyPress(context:Context, index:Int):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_input_set_mouse_visible")
	private static function _SetMouseVisible(context:Context, index:Bool):Void {
	}

	@:hlNative("Urho3D", "_input_set_mouse_mode")
	private static function _SetMouseMode(context:Context, m:Int):Void {
	}

	@:hlNative("Urho3D", "_input_get_mouse_button_press")
	private static function _GetMouseButtonPress(context:Context, m:Int):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_input_get_mouse_button_down")
	private static function _GetMouseButtonDown(context:Context, m:Int):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_input_get_mouse_position")
	private static function GetMousePosition(context:Context):TIntVector2 {
		return null;
	}
}
