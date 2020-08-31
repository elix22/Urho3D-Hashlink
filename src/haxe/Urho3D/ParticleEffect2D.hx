package urho3d;


typedef HL_URHO3D_PARTICLE_EFFECT_2D = hl.Abstract<"hl_urho3d_urho2d_particle_effect2d">;


@:hlNative("Urho3D")
abstract ParticleEffect2D(HL_URHO3D_PARTICLE_EFFECT_2D) {

  
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

    @:hlNative("Urho3D", "_urho2d_particle_effect2d_create")
	private static function Create(context:Context ,name:String):HL_URHO3D_PARTICLE_EFFECT_2D {
		return null;
    }


    @:hlNative("Urho3D", "_urho2d_particle_effect2d_get_name")
	private static function _getName(Texture):hl.Bytes {
		return null;
    }


}