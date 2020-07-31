package urho3d;

import haxe.io.Bytes;

typedef HL_URHO3D_TSTRINGHASH = hl.Abstract<"hl_urho3d_tstringhash">;

@:hlNative("Urho3D")
abstract TStringHash(HL_URHO3D_TSTRINGHASH) {


    public inline function new(s:String) {
        this = Create(s);

    }

    @:to
	public inline function toStringHash():StringHash {
		return _CastToStringHash(cast this);
	}

	@:from
	public static inline function fromStringHash(v:StringHash):TStringHash {
		return _CastFromStringHash(v);
	}

    @:from
    public static inline function fromString(s:String):TStringHash
    {
        return new TStringHash(s);
    }

    @:to
	public inline function toString():String {
		return "TStringHash :"+GetString();
	}

    public function GetString() @:privateAccess {
		return String.fromUTF8( _getString(cast this) );
	}

    @:hlNative("Urho3D", "_math_tstringhash_create")
	private static function Create(s:String):HL_URHO3D_TSTRINGHASH {
		return null;
    }

    @:hlNative("Urho3D", "_math_tstringhash_get_string")
	private static function _getString(s:TStringHash):hl.Bytes {
		return null;
    }


    @:hlNative("Urho3D", "_math_tstringhash_cast_from_stringhash")
	private static function _CastFromStringHash(s:StringHash):TStringHash {
		return null;
    }

    @:hlNative("Urho3D", "_math_tstringhash_cast_to_stringhash")
	private static function _CastToStringHash(s:TStringHash):StringHash {
		return null;
    }
}