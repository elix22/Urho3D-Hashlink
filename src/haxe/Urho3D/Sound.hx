package urho3d;


typedef HL_URHO3D_SOUND = hl.Abstract<"hl_urho3d_audio_sound">;


@:hlNative("Urho3D")
abstract Sound(HL_URHO3D_SOUND) {

  
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

    @:hlNative("Urho3D", "_audio_sound_create")
	private static function Create(context:Context ,name:String):HL_URHO3D_SOUND {
		return null;
    }


    @:hlNative("Urho3D", "_audio_sound_get_name")
	private static function _getName(Texture):hl.Bytes {
		return null;
    }


}