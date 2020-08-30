package urho3d;

import hl.Bytes;

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
	public inline function GetPtr():RefCounted {
		return Variant._GetPtr(cast this);
	}

	@:hlNative("Urho3D", "_variant_get_pointer")
	private static function _GetPtr(variant:Variant):RefCounted {
		return null;
    }
    

    @:to
	public inline function GetNode():Node {
		return Variant._getObject(cast this).toAbstractNode();
    }


    @:to
	public inline function GetRigidBody():RigidBody {
		return Variant._getObject(cast this).toComponent();
    }
    
    @:to
    public inline function GetObject():Object
    {
        return Variant._getObject(cast this);
    }
    @:hlNative("Urho3D", "_variant_get_object")
	private static function _getObject(variant:Variant):Object {
        return null;
    }

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
    public inline function GetBool():Bool
    {
        return Variant._getBool(cast this);
    }
    @:hlNative("Urho3D", "_variant_get_bool")
	private static function _getBool(variant:Variant):Bool {
        return false;
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

    @:to
    @:access(String)
    public inline function GetString():String
    {
        return String.fromUCS2(_getString(cast this));
    }

    @:hlNative("Urho3D", "_variant_get_string")
	private static function _getString(variant:Variant):Bytes {
        return null;
    }
    /////////////////////////////////////////////////////////////////

    @:from
    public static inline function fromString(m:String):Variant
    {
        var v = new Variant();
        Variant._setString(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_string")
	private static function _setString(variant:Variant,s:String):Void {
    }


    @:from
    public static inline function fromObject(m:Object):Variant
    {
       // trace("variant from Vector2");
        var v = new Variant();
        Variant._setObject(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_object")
	private static function _setObject(variant:Variant,o:Object):Void {
    }


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

    ////
    @:from
    public static inline function fromBool(m:Bool):Variant
    {
        var v = new Variant();
        Variant._setBool(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_bool")
	private static function _setBool(variant:Variant,v:Bool):Void {
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
