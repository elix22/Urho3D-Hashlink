package urho3d;

typedef HL_URHO3D_TECHNIQUE = hl.Abstract<"hl_urho3d_graphics_technique">;

@:hlNative("Urho3D")
abstract Technique(HL_URHO3D_TECHNIQUE) {

  
    public inline function new(name:String) {
        this = Create(Context.context,name);
    }

    public  var name(get, never):String;
    function get_name():String
    {
        return  GetName();
    }

    public function GetName() @:privateAccess {
		return String.fromUTF8( _getName(this) );
	}

    @:hlNative("Urho3D", "_graphics_technique_create")
	private static function Create(context:Context ,name:String):HL_URHO3D_TECHNIQUE {
		return null;
    }


    @:hlNative("Urho3D", "_graphics_technique_get_name")
	private static function _getName(Texture):hl.Bytes {
		return null;
    }


}