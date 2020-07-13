package urho3d;

typedef HL_URHO3D_INTVECTOR2 = hl.Abstract<"hl_urho3d_intvector2">;

typedef StructIntVector2 = { x : Int, y : Int }

@:hlNative("Urho3D")
abstract IntVector2(HL_URHO3D_INTVECTOR2) {

    public inline function new(?x_:Int = 0 , ?y_:Int=0) {
        this = Create();
        if(x_ != null)
        {
            x=x_;
        }
        if(y_ != null)
        {
            y=y_;
        }
    }


	@:hlNative("Urho3D", "_create_intvector2")
	private static function Create():HL_URHO3D_INTVECTOR2 {
		return null;
    }

    // calling trace(Vector2) , will show x:y
    @:to
    public inline function toString():String
    {
        var s:String = x+":"+y;
        return s;
    }

    @:from
    public static inline function fromStructVector2(m:StructIntVector2):IntVector2
    {
        return new IntVector2(m.x,m.y);
    }

    @:op(A == B)
    public inline function isequal(rhs:IntVector2):Bool {

        return (x == rhs.x && y == rhs.y);
    }

    @:op(A != B)
    public inline function isnotequal(rhs:IntVector2):Bool {

        return !(x == rhs.x && y == rhs.y);
    }

    @:op(A + B)
    public inline function add(rhs:IntVector2):IntVector2 {

        var x1:Int = x + rhs.x;
        var y1:Int = y + rhs.y;

        return new IntVector2(x1,y1);
    }

    @:op(A += B)
    public  inline function add2(rhs:IntVector2):HL_URHO3D_INTVECTOR2 {

        x += rhs.x;
        y += rhs.y;

        return this;
    }

    @:op(A - B)
    public inline function sub(rhs:IntVector2):IntVector2 {

        var x1:Int = x - rhs.x;
        var y1:Int = y - rhs.y;

        return new IntVector2(x1,y1);
    }

    @:op(A -= B)
    public inline function sub2(rhs:IntVector2):HL_URHO3D_INTVECTOR2 {

        x -= rhs.x;
        y -= rhs.y;

        return this;
    }

    @:op(-A) 
    public inline function neg():HL_URHO3D_INTVECTOR2 {
        x = -x;
        y = -y;
        return this;
    }

    @:op(--A) 
    public inline function preneg():HL_URHO3D_INTVECTOR2 {
        x = --x;
        y = --y;
        return this;
    }

    @:op(A--) public inline function postneg():HL_URHO3D_INTVECTOR2 {
        x = x--;
        y = y--;
        return this;
    }

    @:op(++A) public inline function preadd():HL_URHO3D_INTVECTOR2 {
        x = ++x;
        y = ++y;
        return this;
    }

    @:op(A++) public inline function postadd():HL_URHO3D_INTVECTOR2 {
        x = x++;
        y = y++;
        return this;
    }

  
    

    public var x(get, set):Int;
    public var y(get, set):Int;

	inline function get_x() {
		return _get_x(this);
	}
	@:hlNative("Urho3D", "_intvector2_get_x")
	private static function _get_x(vec2:HL_URHO3D_INTVECTOR2):Int {
		return 0;
    }
    
	inline function set_x(x) {
		return _set_x(this, x);
	}
	@:hlNative("Urho3D", "_intvector2_set_x")
	private static function _set_x(vec2:HL_URHO3D_INTVECTOR2, x:Int):Int {
		return 0;
    }
    

    inline function get_y() {
		return _get_y(this);
	}
	@:hlNative("Urho3D", "_intvector2_get_y")
	private static function _get_y(vec2:HL_URHO3D_INTVECTOR2):Int {
		return 0;
    }
    
	inline function set_y(y) {
		return _set_y(this, y);
	}
	@:hlNative("Urho3D", "_intvector2_set_y")
	private static function _set_y(vec2:HL_URHO3D_INTVECTOR2, y:Int):Int {
		return 0;
	}
}
