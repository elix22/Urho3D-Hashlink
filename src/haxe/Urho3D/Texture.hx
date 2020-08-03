package urho3d;


typedef HL_URHO3D_TEXTURE = hl.Abstract<"hl_urho3d_graphics_texture">;

@:hlNative("Urho3D")
abstract Texture(HL_URHO3D_TEXTURE) {

  
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

    @:hlNative("Urho3D", "_graphics_texture_create")
	private static function Create(context:Context ,name:String):HL_URHO3D_TEXTURE {
		return null;
    }


    @:hlNative("Urho3D", "_graphics_texture_get_name")
	private static function _getName(Texture):hl.Bytes {
		return null;
    }


}