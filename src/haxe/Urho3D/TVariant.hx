package urho3d;

typedef URHO3D_TVARIANT = hl.Abstract<"hl_urho3d_tvariant">;

@:hlNative("Urho3D")
abstract TVariant(URHO3D_TVARIANT) {

    public inline function new() 
    {
        this = CreateTVariant();
    }

    @:hlNative("Urho3D","_create_tvariant")
    private static function CreateTVariant():URHO3D_TVARIANT {
        return null;
    }



    /////////////////////////////////////////////////////////////////

    @:to
	public inline function toVariant():Variant {
		return _CastToVariant(cast this);
    }
    @:hlNative("Urho3D", "_math_tvariant_cast_to_variant")
	private static function _CastToVariant(v:TVariant):Variant {
		return null;
    }

    @:to
    public inline function GetSingle():Float
    {
        return TVariant._getSingle(cast this);
    }
    @:hlNative("Urho3D", "_tvariant_get_float")
	private static function _getSingle(variant:TVariant):Single {
        return 0;
    }

    @:to
    public inline function GetInt():Int
    {
        return TVariant._getInt(cast this);
    }
    @:hlNative("Urho3D", "_tvariant_get_int")
	private static function _getInt(variant:TVariant):Int {
        return 0;
    }

    @:to
    public inline function GetVector2():Vector2
    {
       return _getVector(cast this);
    }
    @:hlNative("Urho3D", "_tvariant_get_vector2")
	private static function _getVector(variant:TVariant):Vector2 {
        return null;
    }


    @:to
    public inline function GetTVector2():TVector2
    {
        return _getTVector(cast this);
    }

    @:hlNative("Urho3D", "_tvariant_get_tvector2")
	private static function _getTVector(variant:TVariant):TVector2 {
        return null;
    }
    


    @:to
    public inline function GetTIntVector2():TIntVector2
    {
        return _getTIntVector(cast this);
    }

    @:hlNative("Urho3D", "_tvariant_get_tintvector2")
	private static function _getTIntVector(variant:TVariant):TIntVector2 {
        return null;
    }

    /////////////////////////////////////////////////////////////////

    @:from
	public static inline function fromVariant(v:Variant):TVariant {
		return _CastFromVariant(v);
    }
    @:hlNative("Urho3D", "_math_tvariant_cast_from_variant")
	private static function _CastFromVariant(v:Variant):TVariant {
		return null;
    }
    
    @:from
    public static inline function fromTIntVector2(m:TIntVector2):TVariant
    {
       // trace("variant from Vector2");
        var v = new TVariant();
        TVariant._setTIntVector(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_tvariant_set_tintvector2")
	private static function _setTIntVector(variant:TVariant,vector2:TIntVector2):Void {
    }

    @:from
    public static inline function fromTVector2(m:TVector2):TVariant
    {
       // trace("variant from Vector2");
        var v = new TVariant();
        TVariant._setTVector(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_tvariant_set_tvector2")
	private static function _setTVector(variant:TVariant,vector2:TVector2):Void {
    }


    @:from
    public static inline function fromVector2(m:Vector2):TVariant
    {
       // trace("variant from Vector2");
        var v = new TVariant();
        TVariant._setVector(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_tvariant_set_vector2")
	private static function _setVector(variant:TVariant,vector2:Vector2):Void {
    }



    @:from
    public static inline function fromInt(m:Int):TVariant
    {
       // trace("from int " + m);
     //   trace("variant from int");
        var v = new TVariant();
        TVariant._setInt(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_tvariant_set_int")
	private static function _setInt(variant:TVariant,v:Int):Void {
    }

    @:from
    public static inline function fromFloat(m:Float):TVariant
    {
      // trace("from single " + m);
        var v = new TVariant();
        TVariant._setSingle(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_tvariant_set_float")
	private static function _setSingle(variant:TVariant,v:Single):Void {
    }


}
