package urho3d;

typedef URHO3D_TVARIANTMAP = hl.Abstract<"hl_urho3d_tvariantmap">;


@:hlNative("Urho3D")
abstract TVariantMap(URHO3D_TVARIANTMAP) {
	public inline function new() {
		this = CreateTVariantMap();
	}

	@:hlNative("Urho3D", "_core_tvariantmap_create")
	private static function CreateTVariantMap():URHO3D_TVARIANTMAP {
		return null;
	}

	@:arrayAccess
	public inline function getValue(key:TStringHash):TVariant {
		return GetKeyValue(cast this,key);
    }
    @:hlNative("Urho3D", "_core_tvariantmap_get_value")
	private static function GetKeyValue(vm:TVariantMap,key:TStringHash):TVariant {
		return null;
    }
    
    
    @:arrayAccess
	public inline function setKeyValue(key:TStringHash,vr:TVariant):TVariant {

		return SetKeyValue(cast this,key,vr);
    }
    @:hlNative("Urho3D", "_core_tvariantmap_set_key_value")
	private static function SetKeyValue(vm:TVariantMap,key:TStringHash,vr:TVariant):TVariant {
		return null;
    }
    
}
