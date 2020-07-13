package urho3d;


typedef HL_URHO3D_TEXTURE2D = hl.Abstract<"hl_urho3d_texture2d">;

@:hlNative("Urho3D")
abstract Texture2D(HL_URHO3D_TEXTURE2D) {

  
    public inline function new(name:String) {
        this = Create(Context.context,name);
    }

   

    @:hlNative("Urho3D", "_create_texture2d")
	private static function Create(context:hl.Abstract<"urho3d_context"> ,name:String):HL_URHO3D_TEXTURE2D {
		return null;
    }


}