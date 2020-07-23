package urho3d;

import urho3d.Scene.AbstractScene;
import urho3d.Camera.AbstractCamera;
class Renderer {
	public static function SetViewport(index:Int, viewport:Viewport) {
		_SetViewport(Context.context, index, viewport);
    }

	@:hlNative("Urho3D", "_graphics_renderer_set_viewport")
    private static function _SetViewport(context:Context, index:Int, viewport:Viewport):Void {}
    


}
