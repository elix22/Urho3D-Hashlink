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
    
    @:to
	public inline function toTexture():Texture {
		return _CastToTexture(Context.context, cast this);
    }
    
    @:from
	public static inline function fromTexture(t:Texture):Texture2D {
		return _CastFromTexture(Context.context,t);
	}

    @:hlNative("Urho3D", "_graphics_texture2d_create")
	private static function Create(context:Context ,name:String):HL_URHO3D_TEXTURE2D {
		return null;
    }


    @:hlNative("Urho3D", "_graphics_texture2d_get_name")
	private static function _getName(Texture2D):hl.Bytes {
		return null;
    }


    @:hlNative("Urho3D", "_graphics_texture2d_cast_to_texture")
	private static function _CastToTexture(context:Context ,t:Texture2D):Texture {
		return null;
    }

    @:hlNative("Urho3D", "_graphics_texture2d_cast_from_texture")
	private static function _CastFromTexture(context:Context ,t:Texture):Texture2D {
		return null;
    }

}