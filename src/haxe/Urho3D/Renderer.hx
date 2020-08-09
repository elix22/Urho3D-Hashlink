package urho3d;

class Renderer {
	public static function SetViewport(index:Int, viewport:Viewport) {
		_SetViewport(Context.context, index, viewport);
	}

	public static var numViewports(get, set):Int;

	static function set_numViewports(c) {
		SetNumViewports(Context.context, c);
		return c;
	}

	static function get_numViewports() {
		return GetNumViewports(Context.context);
	}

	public static function DrawDebugGeometry(drawDebug:Bool):Void {
		_DrawDebugGeometry(Context.context, drawDebug);
	}

	@:hlNative("Urho3D", "_graphics_renderer_set_viewport")
	private static function _SetViewport(context:Context, index:Int, viewport:Viewport):Void {}

	////DrawDebugGeometry
	// DEFINE_PRIM(_VOID, _graphics_renderer_draw_debug_geometry, URHO3D_CONTEXT _BOOL);

	@:hlNative("Urho3D", "_graphics_renderer_draw_debug_geometry")
	private static function _DrawDebugGeometry(context:Context, drawDebug:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_renderer_set_num_viewports")
	private static function SetNumViewports(context:Context, count:Int):Void {}

	@:hlNative("Urho3D", "_graphics_renderer_get_num_viewports")
	private static function GetNumViewports(context:Context):Int {
		return 0;
	}
}
