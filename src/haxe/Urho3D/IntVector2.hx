package urho3d;

import haxe.macro.Compiler.IncludePosition;

typedef HL_URHO3D_INTVECTOR2 = hl.Abstract<"hl_urho3d_intvector2">;

typedef StructIntVector2 = { x : Int, y : Int }

@:hlNative("Urho3D")
abstract IntVector2(HL_URHO3D_INTVECTOR2) {

    public inline function new(x_:Int = 0 , y_:Int=0) {
        this = Create(x_,y_);        
    }


	@:hlNative("Urho3D", "_create_intvector2")
	private static function Create(x:Int,y:Int):HL_URHO3D_INTVECTOR2 {
		return null;
    }

    // calling trace(Vector2) , will show x:y
    @:to
    public inline function toString():String
    {
        var s:String = "IntVector2("+x+":"+y+")";
        return s;
    }

    @:from
    public static inline function fromStructVector2(m:StructIntVector2):IntVector2
    {
        trace("fromStructVector2");
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
    public  inline function addTo(rhs:IntVector2):IntVector2 {

        x += rhs.x;
        y += rhs.y;

        return cast this;
    }

    @:op(A - B)
    public inline function sub(rhs:IntVector2):IntVector2 {

        var x1:Int = x - rhs.x;
        var y1:Int = y - rhs.y;

        return new IntVector2(x1,y1);
    }

    @:op(A -= B)
    public inline function subFrom(rhs:IntVector2):IntVector2 {

        x -= rhs.x;
        y -= rhs.y;

        return cast this;
    }

    @:op(A * B)
    public inline function mul(rhs:Int):IntVector2 {

        var x1:Int = x * rhs;
        var y1:Int = y * rhs;

        return new IntVector2(x1,y1);
    }

    @:op(A *= B)
    public inline function mulWith(rhs:Int):IntVector2 {

        x *= rhs;
        y *= rhs;

        return cast this;
    }

	@:op(A * B)
	public inline function mulVector2(rhs:IntVector2):IntVector2 {
		var x1:Int = x * rhs.x;
		var y1:Int = y * rhs.y;

		return new IntVector2(x1, y1);
	}

	@:op(A *= B)
	public inline function mulWithVector2(rhs:IntVector2):IntVector2 {
		x *= rhs.x;
		y *= rhs.y;

		return cast this;
	}    


    @:op(A / B)
	public inline function div(rhs:Float):IntVector2 {
		var x1 = x / rhs;
		var y1 = y / rhs;

		return new IntVector2(cast(x1,Int), cast(y1,Int));
	}

	@:op(A /= B)
	public inline function divWith(rhs:Float):IntVector2 {
        var x1 = x / rhs;
        var y1 = y / rhs;
        
		x = cast(x1,Int);
		y = cast(y1,Int);

		return cast this;
	}

	@:op(A / B)
	public inline function divVector2(rhs:IntVector2):IntVector2 {
		var x1 = x / rhs.x;
		var y1 = y / rhs.y;

		return new IntVector2(cast(x1,Int), cast(y1,Int));
	}

	@:op(A /= B)
	public inline function divWithVector2(rhs:IntVector2):IntVector2 {
        var x1 = x / rhs.x;
        var y1 = y / rhs.y;
        
		x = cast(x1,Int);
		y = cast(y1,Int);

		return cast this;
	}

    @:op(-A) 
    public inline function neg():IntVector2 {
        x = -x;
        y = -y;
        return cast this;
    }

    @:op(--A) 
    public inline function preneg():IntVector2 {
        x = --x;
        y = --y;
        return cast this;
    }

    @:op(A--) public inline function postneg():IntVector2 {
        x = x--;
        y = y--;
        return cast this;
    }

    @:op(++A) public inline function preadd():IntVector2 {
        x = ++x;
        y = ++y;
        return cast this;
    }

    @:op(A++) public inline function postadd():IntVector2 {
        x = x++;
        y = y++;
        return cast this;
    }

  
    

    public var x(get, set):Int;
    public var y(get, set):Int;

	inline function get_x() {
		return _get_x(cast this);
	}
	@:hlNative("Urho3D", "_intvector2_get_x")
	private static function _get_x(vec2:IntVector2):Int {
		return 0;
    }
    
	inline function set_x(x) {
		return _set_x(cast this, x);
	}
	@:hlNative("Urho3D", "_intvector2_set_x")
	private static function _set_x(vec2:IntVector2, x:Int):Int {
		return 0;
    }
    

    inline function get_y() {
		return _get_y(cast this);
	}
	@:hlNative("Urho3D", "_intvector2_get_y")
	private static function _get_y(vec2:IntVector2):Int {
		return 0;
    }
    
	inline function set_y(y) {
		return _set_y(cast this, y);
	}
	@:hlNative("Urho3D", "_intvector2_set_y")
	private static function _set_y(vec2:IntVector2, y:Int):Int {
		return 0;
	}
}
