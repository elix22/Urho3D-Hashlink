package urho3d;

class UI {
	public static var root(get, never):UIElement;
	public static var cursorPosition(get, never):TIntVector2;

	private static function get_root():UIElement {
		return getRoot(Context.context);
	}

	private static function get_cursorPosition() {
		return _GetCursorPosition(Context.context);
	}

	@:hlNative("Urho3D", "_ui_get_root")
	private static function getRoot(context:Context):UIElement {
		return null;
	}

	@:hlNative("Urho3D", "_ui_get_cursor_position")
	private static function _GetCursorPosition(context:Context):TIntVector2 {
		return null;
	}
}
