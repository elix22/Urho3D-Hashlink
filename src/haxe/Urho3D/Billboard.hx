package urho3d;

typedef HL_URHO3D_BILLBOARD = hl.Abstract<"hl_urho3d_graphics_billboard">;

@:hlNative("Urho3D")
abstract Billboard(HL_URHO3D_BILLBOARD) {

	public inline function new() {
		this = null;
	}

}
