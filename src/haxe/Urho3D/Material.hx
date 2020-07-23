package urho3d;


typedef HL_URHO3D_MATERIAL = hl.Abstract<"hl_urho3d_graphics_material">;

@:hlNative("Urho3D")
abstract Material(HL_URHO3D_MATERIAL) {

  
    public inline function new(name:String) {
        this = Create(Context.context,name);
    }

    @:hlNative("Urho3D", "_graphics_material_create")
	private static function Create(context:Context ,name:String):HL_URHO3D_MATERIAL {
		return null;
    }

}