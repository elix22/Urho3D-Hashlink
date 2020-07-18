package urho3d;


typedef HL_URHO3D_TEXTURE2D = hl.Abstract<"hl_urho3d_texture2d">;

@:hlNative("Urho3D")
abstract Texture2D(HL_URHO3D_TEXTURE2D) {

  
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

    @:hlNative("Urho3D", "_create_texture2d")
	private static function Create(context:Context ,name:String):HL_URHO3D_TEXTURE2D {
		return null;
    }


    @:hlNative("Urho3D", "_get_texture2d_get_name")
	private static function _getName(Texture2D):hl.Bytes {
		return null;
    }


}