package urho3d;

import urho3d.Component.AbstractComponent;

typedef URHO3D_VARIANTMAP = hl.Abstract<"hl_urho3d_variantmap">;

@:hlNative("Urho3D")
abstract VariantMap(URHO3D_VARIANTMAP) {
	public inline function new() {
		this = CreateVariantMap();
	}

	@:hlNative("Urho3D", "_core_variantmap_create")
	private static function CreateVariantMap():URHO3D_VARIANTMAP {
		return null;
	}
/*
	@:arrayAccess
	public inline function SetFloat(key:String, val:Float):Float {
		_SetFloat(this, key, val);
		return val;
	}

	@:hlNative("Urho3D", "_core_variantmap_set_key_string_float")
	private static function _SetFloat(vm:URHO3D_VARIANTMAP, key:String, vr:Single):Void {}

	@:arrayAccess
	public inline function GetFloat(key:String):Float {
		return _GetFloat(this, key);
	}

	@:hlNative("Urho3D", "_core_variantmap_get_key_string_float")
	private static function _GetFloat(vm:URHO3D_VARIANTMAP, key:String):Single {
		return 0.0;
	}

	@:arrayAccess
	public inline function SetInt(key:String, val:Int):Int {
		_SetInt(this, key, val);
		return val;
	}

	@:hlNative("Urho3D", "_core_variantmap_set_key_string_int")
	private static function _SetInt(vm:URHO3D_VARIANTMAP, key:String, vr:Int):Void {}

	@:arrayAccess
	public inline function GetInt(key:String):Int {
		return _GetInt(this, key);
	}

	@:hlNative("Urho3D", "_core_variantmap_get_key_string_int")
	private static function _GetInt(vm:URHO3D_VARIANTMAP, key:String):Int {
		return 0;
	}

	@:arrayAccess
	public inline function GetComponent(key:String):AbstractComponent {
		var tvar = GetKeyStringValue(this, key);
		return tvar.GetComponent();
	}

	*/

	@:arrayAccess
	public inline function setValue(key:String, vr:TVariant):TVariant {
		SetKeyStringValue(this, key, vr);
		return vr;
	}

	@:hlNative("Urho3D", "_core_variantmap_set_key_string_value")
	private static function SetKeyStringValue(vm:URHO3D_VARIANTMAP, key:String, vr:TVariant):Void {}

	@:arrayAccess
	public inline function getValue(key:String):TVariant {
		return GetKeyStringValue(this, key);
	}

	@:hlNative("Urho3D", "_core_variantmap_get_key_string_value")
	private static function GetKeyStringValue(vm:URHO3D_VARIANTMAP, key:String):TVariant {
		return null;
	}

	@:arrayAccess
	public inline function getKeyValue(key:TStringHash):TVariant {
		return GetKeyValue(this, key);
	}

	@:hlNative("Urho3D", "_core_variantmap_get_value")
	private static function GetKeyValue(vm:URHO3D_VARIANTMAP, key:TStringHash):TVariant {
		return null;
	}

	@:arrayAccess
	public inline function setKeyValue(key:TStringHash, vr:TVariant):TVariant {
		return SetKeyValue(this, key, vr);
	}

	@:hlNative("Urho3D", "_core_variantmap_set_key_value")
	private static function SetKeyValue(vm:URHO3D_VARIANTMAP, key:TStringHash, vr:TVariant):TVariant {
		return null;
	}
}
