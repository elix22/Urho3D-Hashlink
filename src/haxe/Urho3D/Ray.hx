package urho3d;

typedef HL_URHO3D_RAY = hl.Abstract<"hl_urho3d_math_ray">;

@:hlNative("Urho3D")
abstract Ray(HL_URHO3D_RAY) {
	public inline function new(origin:TVector3, direction:TVector3) {
		this = Create(origin, direction);
	}

	// HL_PRIM hl_urho3d_graphics_viewport *HL_NAME(_graphics_viewport_create)(urho3d_context *context,hl_urho3d_scene_scene * scene ,hl_urho3d_graphics_camera * camera)

	@:hlNative("Urho3D", "_math_ray_create")
	private static function Create(o:TVector3, d:TVector3):HL_URHO3D_RAY {
		return null;
	}
}
