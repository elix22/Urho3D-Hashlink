package urho3d;

import urho3d.Camera.AbstractCamera;
import urho3d.Scene.AbstractScene;

typedef HL_URHO3D_VIEWPORT = hl.Abstract<"hl_urho3d_graphics_viewport">;

@:hlNative("Urho3D")
abstract Viewport(HL_URHO3D_VIEWPORT) {
	public inline function new(scene:Scene, camera:Camera, ?rect:IntRect) {
		if (rect != null) {
			this = CreateR(Context.context, scene.abstractScene, camera._abstract, rect);
		} else {
			this = Create(Context.context, scene.abstractScene, camera._abstract);
		}
	}

	public var renderPath(get, set):RenderPath;

	function set_renderPath(r) {
		SetRenderPath(Context.context, cast this, r);
		return r;
	}

	function get_renderPath() {
		return GetRenderPath(Context.context, cast this);
	}

	public function ScreenToWorldPoint(x:Int, y:Int, depth:Float) {
		return _ScreenToWorldPoint(Context.context, cast this, x, y, depth);
	}

	@:hlNative("Urho3D", "_graphics_viewport_create")
	private static function Create(context:Context, scene:AbstractScene, camera:AbstractCamera):HL_URHO3D_VIEWPORT {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_viewport_create_r")
	private static function CreateR(context:Context, scene:AbstractScene, camera:AbstractCamera, rect:IntRect):HL_URHO3D_VIEWPORT {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_viewport_set_render_path")
	private static function SetRenderPath(context:Context, v:Viewport, r:RenderPath):Void {}

	@:hlNative("Urho3D", "_graphics_viewport_get_render_path")
	private static function GetRenderPath(context:Context, v:Viewport):RenderPath {
		return null;
	}

	// ScreenToWorldPoint(int x, int y, float depth)
	// DEFINE_PRIM(HL_URHO3D_TVECTOR3, _graphics_viewport_screen_to_world_point, URHO3D_CONTEXT HL_URHO3D_VIEWPORT _I32 _I32 _F32);//

	@:hlNative("Urho3D", "_graphics_viewport_screen_to_world_point")
	private static function _ScreenToWorldPoint(context:Context, v:Viewport, x:Int, y:Int, depth:Single):TVector3 {
		return null;
	}
}
