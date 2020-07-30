package urho3d;

import urho3d.MathDefs.Mathdefs;

typedef HL_URHO3D_TINTVECTOR2 = hl.Abstract<"hl_urho3d_math_tintvector2">

abstract TIntVector2(HL_URHO3D_TINTVECTOR2) {
	public inline function new(x_:Int = 0, y_:Int = 0) {
		this = Create(x_, y_);
	}

	@:hlNative("Urho3D", "_math_tintvector2_create")
	private static function Create(x:Int, y:Int):HL_URHO3D_TINTVECTOR2 {
		return null;
	}



	@:to
	public inline function toString():String {
		var s:String = "TIntVector2 ("+x + ":" + y+")";
		return s;
	}

	@:to
	public inline function toIntVector2():IntVector2 {
		return _CastToIntVector2(cast this);
	}

	@:from
	public static inline function fromIntVector2(v:IntVector2):TIntVector2 {
		return _CastFromIntVector2(v);
	}


	@:op(A == B)
	public inline function isEqual(rhs:TIntVector2):Bool {
		return (x == rhs.x && y == rhs.y);
	}

	@:op(A != B)
	public inline function isNotEqual(rhs:TIntVector2):Bool {
		return !(x == rhs.x && y == rhs.y);
	}

	@:op(A + B)
	public inline function add(rhs:TIntVector2):TIntVector2 {
		var x1:Int = x + rhs.x;
		var y1:Int = y + rhs.y;

		return new TIntVector2(x1, y1);
	}

	@:op(A += B)
	public inline function addTo(rhs:TIntVector2):TIntVector2 {
		x += rhs.x;
		y += rhs.y;
		return cast this;
	}

	@:op(A - B)
	public inline function sub(rhs:TIntVector2):TIntVector2 {
		var x1:Int = x - rhs.x;
		var y1:Int = y - rhs.y;

		return new TIntVector2(x1, y1);
	}

	@:op(A -= B)
	public inline function subFrom(rhs:TIntVector2):TIntVector2 {
		x -= rhs.x;
		y -= rhs.y;

		return cast this;
	}

	@:op(A * B)
	public inline function mul(rhs:Int):TIntVector2 {
		var x1:Int = x * rhs;
		var y1:Int = y * rhs;

		return new TIntVector2(x1, y1);
	}

	@:op(A *= B)
	public inline function mulWith(rhs:Int):TIntVector2 {
		x *= rhs;
		y *= rhs;

		return cast this;
	}

	@:op(A * B)
	public inline function mulVector2(rhs:TIntVector2):TIntVector2 {
		var x1:Int = x * rhs.x;
		var y1:Int = y * rhs.y;

		return new TIntVector2(x1, y1);
	}

	@:op(A *= B)
	public inline function mulWithVector2(rhs:TIntVector2):TIntVector2 {
		x *= rhs.x;
		y *= rhs.y;

		return cast this;
	}

	@:op(A / B)
	public inline function div(rhs:Float):TIntVector2 {
		var x1:Float = x / rhs;
		var y1:Float = y / rhs;

		return new TIntVector2(cast(x1,Int),cast(y1,Int));
	}

	@:op(A /= B)
	public inline function divWith(rhs:Float):TIntVector2 {
        var x1 = x / rhs;
        var y1 = y / rhs;
        
		x = cast(x1,Int);
		y = cast(y1,Int);

		return cast this;
	}

	@:op(A / B)
	public inline function divVector2(rhs:TIntVector2):TIntVector2 {
		var x1:Float = x / rhs.x;
		var y1:Float = y / rhs.y;

		return new TIntVector2(cast(x1,Int),cast(y1,Int));
	}

	@:op(A /= B)
	public inline function divWithVector2(rhs:TIntVector2):TIntVector2 {

        var x1 = x / rhs.x;
        var y1 = y / rhs.y;
        
		x = cast(x1,Int);
		y = cast(y1,Int);

		return cast this;
	}

	@:op(-A)
	public inline function neg():TIntVector2 {
		x = -x;
		y = -y;
		return cast this;
	}

	@:op(--A)
	public inline function preNeg():TIntVector2 {
		x = --x;
		y = --y;
		return cast this;
	}

	@:op(A--) public inline function postNeg():TIntVector2 {
		x = x--;
		y = y--;
		return cast this;
	}

	@:op(++A) public inline function preAdd():TIntVector2 {
		x = ++x;
		y = ++y;
		return cast this;
	}

	@:op(A++) public inline function postAdd():TIntVector2 {
		x = x++;
		y = y++;
		return cast this;
	}







	public var x(get, set):Int;

	public var y(get, set):Int;

	inline function get_x() {
		return _get_x(cast this);
	}

	@:hlNative("Urho3D", "_math_tintvector2_get_x")
	private static function _get_x(vec2:TIntVector2):Int {
		return 0;
	}

	inline function set_x(x) {
		return _set_x(cast this, x);
	}

	@:hlNative("Urho3D", "_math_tintvector2_set_x")
	private static function _set_x(vec2:TIntVector2, x:Int):Int {
		return 0;
	}

	inline function get_y() {
		return _get_y(cast this);
	}

	@:hlNative("Urho3D", "_math_tintvector2_get_y")
	private static function _get_y(vec2:TIntVector2):Int {
		return 0;
	}

	inline function set_y(y) {
		return _set_y(cast this, y);
	}

	@:hlNative("Urho3D", "_math_tintvector2_set_y")
	private static function _set_y(vec2:TIntVector2, x:Int):Int {
		return 0;
	}


	@:hlNative("Urho3D", "_math_tintvector2_cast_from_intvector2")
	private static function _CastFromIntVector2(vec2:IntVector2):TIntVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_math_tintvector2_cast_to_intvector2")
	private static function _CastToIntVector2(vec2:TIntVector2):IntVector2 {
		return null;
	}
	
}
