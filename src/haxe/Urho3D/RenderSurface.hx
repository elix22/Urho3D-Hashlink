package urho3d;

typedef HL_URHO3D_RENDER_SURFACE = hl.Abstract<"hl_urho3d_graphics_render_surface">;

@:hlNative("Urho3D")
abstract RenderSurface(HL_URHO3D_RENDER_SURFACE) {
	public inline function new(texture:Texture) {
		this = Create(Context.context, texture);
	}

	public inline function SetViewport(index:Int, viewport:Viewport) {
		_SetViewport(Context.context, cast this, index, viewport);
	}

	public inline function GetViewport(index:Int):Viewport {
		return _GetViewport(Context.context, cast this, index);
	}

	@:hlNative("Urho3D", "_graphics_render_surface_create")
	private static function Create(context:Context, texture:Texture):HL_URHO3D_RENDER_SURFACE {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_render_surface_set_viewport")
	private static function _SetViewport(context:Context, renderSurface:RenderSurface, index:Int, viewport:Viewport):Void {}

	@:hlNative("Urho3D", "_graphics_render_surface_get_viewport")
	private static function _GetViewport(context:Context, renderSurface:RenderSurface, index:Int):Viewport {
		return null;
	}
}
