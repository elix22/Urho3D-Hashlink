package urho3d;

typedef URHO3D_VARIANTMAP = hl.Abstract<"hl_urho3d_variantmap">;


@:hlNative("Urho3D")
abstract VariantMap(URHO3D_VARIANTMAP) {
	public inline function new() {
		this = CreateVariantMap();
	}

	@:hlNative("Urho3D", "_create_variantmap")
	private static function CreateVariantMap():URHO3D_VARIANTMAP {
		return null;
	}

	@:arrayAccess
	public inline function getValue(key:TStringHash):TVariant {
		return GetKeyValue(this,key);
    }
    @:hlNative("Urho3D", "_get_value")
	private static function GetKeyValue(vm:URHO3D_VARIANTMAP,key:TStringHash):TVariant {
		return null;
    }
    
    
    @:arrayAccess
	public inline function setKeyValue(key:TStringHash,vr:TVariant):TVariant {

		return SetKeyValue(this,key,vr);
    }
    @:hlNative("Urho3D", "_set_key_value")
	private static function SetKeyValue(vm:URHO3D_VARIANTMAP,key:TStringHash,vr:TVariant):TVariant {
		return null;
	}
}
