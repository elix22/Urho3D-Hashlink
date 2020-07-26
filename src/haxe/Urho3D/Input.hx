package urho3d;

import urho3d.IntVector2.StructIntVector2;

class Input {
	public static var mouseMove(get, never):StructIntVector2;

	private static function get_mouseMove() {
		//return GetMouseMove(Context.context);
		return {x:GetMouseMoveX(Context.context),y:GetMouseMoveY(Context.context)};
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
}
