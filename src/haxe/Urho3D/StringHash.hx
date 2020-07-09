package urho3d;

import haxe.io.Bytes;

typedef HL_URHO3D_STRINGHASH = hl.Abstract<"hl_urho3d_stringhash">;

@:hlNative("Urho3D")
abstract StringHash(HL_URHO3D_STRINGHASH) {


    public function new(s:String) {
        this = Create(s);

    }

    @:from
    public static function fromString(s:String):StringHash
    {
        return new StringHash(s);
    }

    @:hlNative("Urho3D", "_create_stringhash")
	private static function Create(String):HL_URHO3D_STRINGHASH {
		return null;
    }
}