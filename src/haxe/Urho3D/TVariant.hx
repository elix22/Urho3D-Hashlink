package urho3d;

import urho3d.Component.AbstractComponent;

typedef URHO3D_TVARIANT = hl.Abstract<"hl_urho3d_tvariant">;

@:hlNative("Urho3D")
abstract TVariant(URHO3D_TVARIANT) {
	public inline function new() {
		this = CreateTVariant();
	}

	@:hlNative("Urho3D", "_create_tvariant")
	private static function CreateTVariant():URHO3D_TVARIANT {
		return null;
	}

	public var int(get, never):Int;
	public var float(get, never):Float;
	public var single(get, never):Float;
	public var variant(get, never):Variant;
	public var vector2(get, never):Vector2;
	public var tvector2(get, never):TVector2;
	public var tintvector2(get, never):TIntVector2;
	public var object(get, never):Object;
	public var component(get, never):AbstractComponent;

	// public var component(get, never):Object;

	function get_int() {
		return GetInt();
	}

	function get_float() {
		return GetFloat();
	}

	function get_single() {
		return GetSingle();
	}

	function get_variant() {
		return ToVariant();
	}

	function get_vector2() {
		return GetVector2();
	}

	function get_tvector2() {
		return GetTVector2();
	}

	function get_tintvector2() {
		return GetTIntVector2();
	}

	function get_object() {
		return GetObject();
	}

	function get_component() {
		return TVariant._getObject(cast this).toComponent();
	}

	/////////////////////////////////////////////////////////////////

	@:to
	public inline function GetRigidBody():RigidBody {
		return TVariant._getObject(cast this).toComponent();
	}

	@:to
	public inline function GetComponent():AbstractComponent {
		return TVariant._getObject(cast this).toComponent();
	}

	@:to
	public inline function GetObject():Object {
		return TVariant._getObject(cast this);
	}

	@:hlNative("Urho3D", "_tvariant_get_object")
	private static function _getObject(variant:TVariant):Object {
		return null;
	}

	@:to
	public inline function ToVariant():Variant {
		return _CastToVariant(cast this);
	}

	@:hlNative("Urho3D", "_math_tvariant_cast_to_variant")
	private static function _CastToVariant(v:TVariant):Variant {
		return null;
	}

	@:to
	public inline function GetSingle():Float {
		return TVariant._getSingle(cast this);
	}

	@:to
	public inline function GetFloat():Float {
		return TVariant._getSingle(cast this);
	}

	@:hlNative("Urho3D", "_tvariant_get_float")
	private static function _getSingle(variant:TVariant):Single {
		return 0;
	}

	@:to
	public inline function GetInt():Int {
		return TVariant._getInt(cast this);
	}

	@:hlNative("Urho3D", "_tvariant_get_int")
	private static function _getInt(variant:TVariant):Int {
		return 0;
	}

	@:to
	public inline function GetVector2():Vector2 {
		return _getVector2(cast this);
	}

	@:hlNative("Urho3D", "_tvariant_get_vector2")
	private static function _getVector2(variant:TVariant):Vector2 {
		return null;
	}

	@:to
	public inline function GetTVector2():TVector2 {
		return _getTVector2(cast this);
	}

	@:hlNative("Urho3D", "_tvariant_get_tvector2")
	private static function _getTVector2(variant:TVariant):TVector2 {
		return null;
	}

	@:to
	public inline function GetTIntVector2():TIntVector2 {
		return _getTIntVector2(cast this);
	}

	@:hlNative("Urho3D", "_tvariant_get_tintvector2")
	private static function _getTIntVector2(variant:TVariant):TIntVector2 {
		return null;
	}


	@:to
	public inline function GetTIntVectorBuffer():TVectorBuffer {
		return _getTVectorBuffer(cast this);
	}

	@:hlNative("Urho3D", "_t_variant_get_vector_buffer")
	private static function _getTVectorBuffer(variant:TVariant):TVectorBuffer {
		return null;
	}
	/////////////////////////////////////////////////////////////////


	@:from
	public static inline function fromTVectorBuffer(m:TVectorBuffer):TVariant {
		// trace("variant from Vector2");
		var v = new TVariant();
		TVariant._setTVectorBuffer(v, m);
		return v;
	}

	@:hlNative("Urho3D", "_t_variant_set_vector_buffer")
	private static function _setTVectorBuffer(variant:TVariant, t:TVectorBuffer):Void {}


	@:from
	public static inline function fromObject(m:Object):TVariant {
		// trace("variant from Vector2");
		var v = new TVariant();
		TVariant._setObject(v, m);
		return v;
	}

	@:hlNative("Urho3D", "_tvariant_set_object")
	private static function _setObject(variant:TVariant, o:Object):Void {}

	@:from
	public static inline function FromVariant(v:Variant):TVariant {
		return _CastFromVariant(v);
	}

	@:hlNative("Urho3D", "_math_tvariant_cast_from_variant")
	private static function _CastFromVariant(v:Variant):TVariant {
		return null;
	}

	@:from
	public static inline function FromTIntVector2(m:TIntVector2):TVariant {
		// trace("variant from Vector2");
		var v = new TVariant();
		TVariant._setTIntVector(v, m);
		return v;
	}

	@:hlNative("Urho3D", "_tvariant_set_tintvector2")
	private static function _setTIntVector(variant:TVariant, vector2:TIntVector2):Void {}

	@:from
	public static inline function FromTVector2(m:TVector2):TVariant {
		// trace("variant from Vector2");
		var v = new TVariant();
		TVariant._setTVector(v, m);
		return v;
	}

	@:hlNative("Urho3D", "_tvariant_set_tvector2")
	private static function _setTVector(variant:TVariant, vector2:TVector2):Void {}

	@:from
	public static inline function FromVector2(m:Vector2):TVariant {
		// trace("variant from Vector2");
		var v = new TVariant();
		TVariant._setVector(v, m);
		return v;
	}

	@:hlNative("Urho3D", "_tvariant_set_vector2")
	private static function _setVector(variant:TVariant, vector2:Vector2):Void {}

	@:from
	public static inline function FromInt(m:Int):TVariant {
		// trace("from int " + m);
		//   trace("variant from int");
		var v = new TVariant();
		TVariant._setInt(v, m);
		return v;
	}

	@:hlNative("Urho3D", "_tvariant_set_int")
	private static function _setInt(variant:TVariant, v:Int):Void {}

	@:from
	public static inline function FromFloat(m:Float):TVariant {
		// trace("from single " + m);
		var v = new TVariant();
		TVariant._setSingle(v, m);
		return v;
	}

	@:hlNative("Urho3D", "_tvariant_set_float")
	private static function _setSingle(variant:TVariant, v:Single):Void {}
}
