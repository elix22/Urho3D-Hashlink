package urho3d;

typedef URHO3D_VARIANT = hl.Abstract<"hl_urho3d_variant">;

@:hlNative("Urho3D")
abstract Variant(URHO3D_VARIANT) {

    public inline function new() 
    {
        this = CreateVariant();
    }

    @:hlNative("Urho3D","_create_variant")
    private static function CreateVariant():URHO3D_VARIANT {
        return null;
    }

    /////////////////////////////////////////////////////////////////
    @:to
    public inline function GetSingle():Float
    {
        return Variant._getSingle(cast this);
    }
    @:hlNative("Urho3D", "_variant_get_float")
	private static function _getSingle(variant:Variant):Single {
        return 0;
    }

    @:to
    public inline function GetInt():Int
    {
        return Variant._getInt(cast this);
    }
    @:hlNative("Urho3D", "_variant_get_int")
	private static function _getInt(variant:Variant):Int {
        return 0;
    }

    @:to
    public inline function GetVector2():Vector2
    {
       return _getVector(cast this);
    }
    @:hlNative("Urho3D", "_variant_get_vector2")
	private static function _getVector(variant:Variant):Vector2 {
        return null;
    }


    @:to
    public inline function GetTVector2():TVector2
    {
        return _getTVector(cast this);
    }

    @:hlNative("Urho3D", "_variant_get_tvector2")
	private static function _getTVector(variant:Variant):TVector2 {
        return null;
    }
    


    @:to
    public inline function GetTIntVector2():TIntVector2
    {
        return _getTIntVector(cast this);
    }

    @:hlNative("Urho3D", "_variant_get_tintvector2")
	private static function _getTIntVector(variant:Variant):TIntVector2 {
        return null;
    }

    /////////////////////////////////////////////////////////////////

    @:from
    public static inline function fromTIntVector2(m:TIntVector2):Variant
    {
       // trace("variant from Vector2");
        var v = new Variant();
        Variant._setTIntVector(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_tintvector2")
	private static function _setTIntVector(variant:Variant,vector2:TIntVector2):Void {
    }

    @:from
    public static inline function fromTVector2(m:TVector2):Variant
    {
       // trace("variant from Vector2");
        var v = new Variant();
        Variant._setTVector(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_tvector2")
	private static function _setTVector(variant:Variant,vector2:TVector2):Void {
    }


    @:from
    public static inline function fromVector2(m:Vector2):Variant
    {
       // trace("variant from Vector2");
        var v = new Variant();
        Variant._setVector(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_vector2")
	private static function _setVector(variant:Variant,vector2:Vector2):Void {
    }



    @:from
    public static inline function fromInt(m:Int):Variant
    {
       // trace("from int " + m);
     //   trace("variant from int");
        var v = new Variant();
        Variant._setInt(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_int")
	private static function _setInt(variant:Variant,v:Int):Void {
    }

    @:from
    public static inline function fromFloat(m:Float):Variant
    {
      // trace("from single " + m);
        var v = new Variant();
        Variant._setSingle(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_float")
	private static function _setSingle(variant:Variant,v:Single):Void {
    }





}
