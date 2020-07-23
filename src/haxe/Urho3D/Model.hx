package urho3d;


typedef HL_URHO3D_MODEL = hl.Abstract<"hl_urho3d_graphics_model">;

@:hlNative("Urho3D")
abstract Model(HL_URHO3D_MODEL) {

  
    public inline function new(name:String) {
        this = Create(Context.context,name);
    }

    @:hlNative("Urho3D", "_graphics_model_create")
	private static function Create(context:Context ,name:String):HL_URHO3D_MODEL {
		return null;
    }

}