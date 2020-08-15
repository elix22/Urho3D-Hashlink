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
	public inline function setValue(key:String, vr:TVariant):TVariant {
		SetKeyStringValue(this, key, vr);
		return vr;
	}

	@:hlNative("Urho3D", "_set_key_string_value")
	private static function SetKeyStringValue(vm:URHO3D_VARIANTMAP, key:String, vr:TVariant):Void {}

	@:arrayAccess
	public inline function getValue(key:String):TVariant {
		return GetKeyStringValue(this, key);
	}

	@:hlNative("Urho3D", "_get_key_string_value")
	private static function GetKeyStringValue(vm:URHO3D_VARIANTMAP, key:String):TVariant {
		return null;
	}


	@:arrayAccess
	public inline function getKeyValue(key:TStringHash):TVariant {
		return GetKeyValue(this, key);
	}

	@:hlNative("Urho3D", "_get_value")
	private static function GetKeyValue(vm:URHO3D_VARIANTMAP, key:TStringHash):TVariant {
		return null;
	}

	@:arrayAccess
	public inline function setKeyValue(key:TStringHash, vr:TVariant):TVariant {
		return SetKeyValue(this, key, vr);
	}

	@:hlNative("Urho3D", "_set_key_value")
	private static function SetKeyValue(vm:URHO3D_VARIANTMAP, key:TStringHash, vr:TVariant):TVariant {
		return null;
	}


	
}
