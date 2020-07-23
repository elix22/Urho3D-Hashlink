package urho3d;

import urho3d.Camera.AbstractCamera;
import urho3d.Scene.AbstractScene;


typedef HL_URHO3D_VIEWPORT = hl.Abstract<"hl_urho3d_graphics_viewport">;

@:hlNative("Urho3D")
abstract Viewport(HL_URHO3D_VIEWPORT) {

  
    public inline function new(scene:Scene, camera:Camera) {
        this = Create(Context.context,scene.abstractScene,camera._abstract);
    }

    //HL_PRIM hl_urho3d_graphics_viewport *HL_NAME(_graphics_viewport_create)(urho3d_context *context,hl_urho3d_scene_scene * scene ,hl_urho3d_graphics_camera * camera)

    @:hlNative("Urho3D", "_graphics_viewport_create")
	private static function Create(context:Context ,scene:AbstractScene , camera:AbstractCamera ):HL_URHO3D_VIEWPORT {
		return null;
    }

}