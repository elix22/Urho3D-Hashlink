package urho3d;

import haxe.io.Bytes;

typedef HL_URHO3D_STRINGHASH = hl.Abstract<"hl_urho3d_stringhash">;

@:hlNative("Urho3D")
abstract StringHash(HL_URHO3D_STRINGHASH) {

  
    public inline function new(s:String) {
        this = Create(s);

    }

    @:from
    public static inline function fromString(s:String):StringHash
    {
        return new StringHash(s);
    }

    @:to
	public inline function toString():String {
		return "StringHash :"+GetString();
	}

    public function GetString() @:privateAccess {
		return String.fromUTF8( _getString(this) );
	}

    @:hlNative("Urho3D", "_create_stringhash")
	private static function Create(String):HL_URHO3D_STRINGHASH {
		return null;
    }

    @:hlNative("Urho3D", "_get_stringhash_string")
	private static function _getString(StringHash):hl.Bytes {
		return null;
    }
}