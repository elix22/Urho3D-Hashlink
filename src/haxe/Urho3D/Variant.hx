package urho3d;

typedef URHO3D_VARIANT = hl.Abstract<"hl_urho3d_variant">;

@:hlNative("Urho3D")
abstract Variant(URHO3D_VARIANT) {

    public function new() 
    {
        this = CreateVariant();
    }

    @:hlNative("Urho3D","_create_variant")
    private static function CreateVariant():URHO3D_VARIANT {
        return null;
    }

    @:from
    public static function fromInt(m:Int):Variant
    {

     //   trace("variant from int");
        var v = new Variant();
        Variant._setInt(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_int")
	private static function _setInt(variant:Variant,v:Int):Void {
    }


    @:to
    public function toInt():Int
    {

        return Variant._getInt(this);
    }
    @:hlNative("Urho3D", "_variant_get_int")
	private static function _getInt(variant:URHO3D_VARIANT):Int {
        return 0;
    }
    
    @:from
    public static function fromVector2(m:Vector2):Variant
    {
       // trace("variant from Vector2");
        var v = new Variant();
        Variant._setVector(v,m);
        return v;
    }
    @:hlNative("Urho3D", "_variant_set_vector2")
	private static function _setVector(variant:Variant,vector2:Vector2):Void {
    }

    @:to
    public function toVector2():Vector2
    {
        var v:Vector2 = new Vector2();
        _getVector(this,v);

        return v;

    }
    @:hlNative("Urho3D", "_variant_get_vector2")
	private static function _getVector(variant:URHO3D_VARIANT,vector2:Vector2):Void {
    }

}
