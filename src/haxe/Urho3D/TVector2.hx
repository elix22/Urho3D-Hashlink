package urho3d;

import urho3d.MathDefs.Mathdefs;

typedef HL_URHO3D_TVECTOR2 = hl.Abstract<"hl_urho3d_math_tvector2">

abstract TVector2(HL_URHO3D_TVECTOR2) {
	public inline function new(x_:Float = 0.0, y_:Float = 0.0) {
		this = Create(x_, y_);
	}

	@:hlNative("Urho3D", "_math_tvector2_create")
	private static function Create(x:Single, y:Single):HL_URHO3D_TVECTOR2 {
		return null;
	}



	@:to
	public inline function toString():String {
		var s:String = "TVector2 ("+x + ":" + y+")";
		return s;
	}

	@:to
	public inline function toVector2():Vector2 {
		return _CastToVector2(cast this);
	}

	@:from
	public static inline function fromVector2(v:Vector2):TVector2 {
		return _CastFromVector2(v);
	}


	@:op(A == B)
	public inline function isEqual(rhs:TVector2):Bool {
		return (x == rhs.x && y == rhs.y);
	}

	@:op(A != B)
	public inline function isNotEqual(rhs:TVector2):Bool {
		return !(x == rhs.x && y == rhs.y);
	}

	@:op(A + B)
	public inline function add(rhs:TVector2):TVector2 {
		var x1:Single = x + rhs.x;
		var y1:Single = y + rhs.y;

		return new TVector2(x1, y1);
	}

	@:op(A += B)
	public inline function addTo(rhs:TVector2):TVector2 {
		x += rhs.x;
		y += rhs.y;
		return cast this;
	}

	@:op(A - B)
	public inline function sub(rhs:TVector2):TVector2 {
		var x1:Single = x - rhs.x;
		var y1:Single = y - rhs.y;

		return new TVector2(x1, y1);
	}

	@:op(A -= B)
	public inline function subFrom(rhs:TVector2):TVector2 {
		x -= rhs.x;
		y -= rhs.y;

		return cast this;
	}

	@:op(A * B)
	public inline function mul(rhs:Single):TVector2 {
		var x1:Single = x * rhs;
		var y1:Single = y * rhs;

		return new TVector2(x1, y1);
	}

	@:op(A *= B)
	public inline function mulWith(rhs:Single):TVector2 {
		x *= rhs;
		y *= rhs;

		return cast this;
	}

	@:op(A * B)
	public inline function mulVector2(rhs:TVector2):TVector2 {
		var x1:Single = x * rhs.x;
		var y1:Single = y * rhs.y;

		return new TVector2(x1, y1);
	}

	@:op(A *= B)
	public inline function mulWithVector2(rhs:TVector2):TVector2 {
		x *= rhs.x;
		y *= rhs.y;

		return cast this;
	}

	@:op(A / B)
	public inline function div(rhs:Single):TVector2 {
		var x1:Single = x / rhs;
		var y1:Single = y / rhs;

		return new TVector2(x1, y1);
	}

	@:op(A /= B)
	public inline function divWith(rhs:Single):TVector2 {
		x /= rhs;
		y /= rhs;

		return cast this;
	}

	@:op(A / B)
	public inline function divVector2(rhs:TVector2):TVector2 {
		var x1:Single = x / rhs.x;
		var y1:Single = y / rhs.y;

		return new TVector2(x1, y1);
	}

	@:op(A /= B)
	public inline function divWithVector2(rhs:TVector2):TVector2 {
		x /= rhs.x;
		y /= rhs.y;

		return cast this;
	}

	@:op(-A)
	public inline function neg():TVector2 {
		x = -x;
		y = -y;
		return cast this;
	}

	@:op(--A)
	public inline function preNeg():TVector2 {
		x = --x;
		y = --y;
		return cast this;
	}

	@:op(A--) public inline function postNeg():TVector2 {
		x = x--;
		y = y--;
		return cast this;
	}

	@:op(++A) public inline function preAdd():TVector2 {
		x = ++x;
		y = ++y;
		return cast this;
	}

	@:op(A++) public inline function postAdd():TVector2 {
		x = x++;
		y = y++;
		return cast this;
	}







	public var x(get, set):Float;

	public var y(get, set):Float;

	inline function get_x() {
		return _get_x(cast this);
	}

	@:hlNative("Urho3D", "_math_tvector2_get_x")
	private static function _get_x(vec2:TVector2):Single {
		return 0.0;
	}

	inline function set_x(x) {
		return _set_x(cast this, x);
	}

	@:hlNative("Urho3D", "_math_tvector2_set_x")
	private static function _set_x(vec2:TVector2, x:Single):Single {
		return 0.0;
	}

	inline function get_y() {
		return _get_y(cast this);
	}

	@:hlNative("Urho3D", "_math_tvector2_get_y")
	private static function _get_y(vec2:TVector2):Single {
		return 0.0;
	}

	inline function set_y(y) {
		return _set_y(cast this, y);
	}

	@:hlNative("Urho3D", "_math_tvector2_set_y")
	private static function _set_y(vec2:TVector2, x:Single):Single {
		return 0.0;
	}


	@:hlNative("Urho3D", "_math_tvector2_cast_from_vector2")
	private static function _CastFromVector2(vec2:Vector2):TVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_math_tvector2_cast_to_vector2")
	private static function _CastToVector2(vec2:TVector2):Vector2 {
		return null;
	}
	
}
