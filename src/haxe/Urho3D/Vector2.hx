package urho3d;

typedef HL_URHO3D_VECTOR2 = hl.Abstract<"hl_urho3d_vector2">;

typedef StructVector2 = { x : Single, y : Single }

@:hlNative("Urho3D")
abstract Vector2(HL_URHO3D_VECTOR2) {

    public inline function new(x_:Single = 0.0 , y_:Single=0.0) {
        this = Create(x_,y_);
    }


	@:hlNative("Urho3D", "_create_vector2")
	private static function Create(x:Single,y:Single):HL_URHO3D_VECTOR2 {
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
    public static inline function fromStructVector2(m:StructVector2):Vector2
    {
        return new Vector2(m.x,m.y);
    }

    @:to
    public inline function toStructVector2():StructVector2
    {
        return {x:x,y:y};
    }

    @:op(A == B)
    public inline function isequal(rhs:Vector2):Bool {

        return (x == rhs.x && y == rhs.y);
    }

    @:op(A != B)
    public inline function isnotequal(rhs:Vector2):Bool {

        return !(x == rhs.x && y == rhs.y);
    }

    @:op(A + B)
    public inline function add(rhs:Vector2):Vector2 {

        var x1:Single = x + rhs.x;
        var y1:Single = y + rhs.y;

        return new Vector2(x1,y1);
    }

    @:op(A += B)
    public  inline function addTo(rhs:Vector2):Vector2 {

        x += rhs.x;
        y += rhs.y;
        return cast this;
    }


    @:op(A - B)
    public inline function sub(rhs:Vector2):Vector2 {

        var x1:Single = x - rhs.x;
        var y1:Single = y - rhs.y;

        return new Vector2(x1,y1);
    }

    @:op(A -= B)
    public inline function subFrom(rhs:Vector2):Vector2 {

        x -= rhs.x;
        y -= rhs.y;

        return cast this;
    }

    @:op(A * B)
    public inline function mul(rhs:Single):Vector2 {

        var x1:Single = x * rhs;
        var y1:Single = y * rhs;

        return new Vector2(x1,y1);
    }

    @:op(A *= B)
    public inline function mulWith(rhs:Single):Vector2 {

        x *= rhs;
        y *= rhs;

        return cast this;
    }

    @:op(-A) 
    public inline function neg():Vector2 {
        x = -x;
        y = -y;
        return cast this;
    }

    @:op(--A) 
    public inline function preneg():Vector2 {
        x = --x;
        y = --y;
        return cast this;
    }

    @:op(A--) public inline function postneg():Vector2 {
        x = x--;
        y = y--;
        return cast this;
    }

    @:op(++A) public inline function preadd():Vector2 {
        x = ++x;
        y = ++y;
        return cast this;
    }

    @:op(A++) public inline function postadd():Vector2 {
        x = x++;
        y = y++;
        return cast this;
    }

  
    

    public var x(get, set):Single;
    public var y(get, set):Single;

	inline function get_x() {
		return _get_x(cast this);
	}
	@:hlNative("Urho3D", "_vector2_get_x")
	private static function _get_x(vec2:Vector2):Single {
		return 0.0;
    }
    
	inline function set_x(x) {
		return _set_x(cast this, x);
	}
	@:hlNative("Urho3D", "_vector2_set_x")
	private static function _set_x(vec2:Vector2, x:Single):Single {
		return 0.0;
    }
    

    inline function get_y() {
		return _get_y(cast this);
	}
	@:hlNative("Urho3D", "_vector2_get_y")
	private static function _get_y(vec2:Vector2):Single {
		return 0.0;
    }
    
	inline function set_y(y) {
		return _set_y(cast this, y);
	}
	@:hlNative("Urho3D", "_vector2_set_y")
	private static function _set_y(vec2:Vector2, x:Single):Single {
		return 0.0;
	}
}
