package urho3d;

import urho3d.Vector3.StructVector3;

typedef HL_URHO3D_TVECTOR3 = hl.Abstract<"hl_urho3d_math_tvector3">

abstract TVector3(HL_URHO3D_TVECTOR3) {
	public inline function new(x_:Float = 0.0, y_:Float = 0.0, z_:Float = 0.0) {
		this = Create(x_, y_,z_);
	}

	@:hlNative("Urho3D", "_math_tvector3_create")
	private static function Create(x:Single, y:Single, z:Single):HL_URHO3D_TVECTOR3 {
		return null;
	}



	@:to
	public inline function toString():String {
		var s:String = "TVector3 ("+x + ":" + y + ":" + z+")";
		return s;
	}

	@:to
	public inline function toVector3():Vector3 {
		return _CastToVector3(cast this);
	}

	@:from
	public static inline function fromVector3(v:Vector3):TVector3 {
		return _CastFromVector3(v);
    }

    @:from
	public static inline function fromStructVector3(m:StructVector3):TVector3 {
		return new TVector3(m.x, m.y, m.z);
	}

	@:from
	public static inline function fromFloat(m:Float):TVector3 {
		return new TVector3(m, m, m);
	}

	@:from
	public static inline function fromSingle(m:Single):TVector3 {
		return new TVector3(m, m, m);
	}

	@:to
	public inline function toStructVector3():StructVector3 {
		return {x: x, y: y, z: z};
	}

	@:op(A == B)
	public inline function isEqual(rhs:TVector3):Bool {
		return (x == rhs.x && y == rhs.y && z == rhs.z);
	}

	@:op(A != B)
	public inline function isNotEqual(rhs:TVector3):Bool {
		return !(x == rhs.x && y == rhs.y && z == rhs.z);
	}

	@:op(A + B)
	public inline function add(rhs:TVector3):TVector3 {
		var x1:Single = x + rhs.x;
		var y1:Single = y + rhs.y;
		var z1:Single = z + rhs.z;

		return new TVector3(x1, y1, z1);
	}

	@:op(A += B)
	public inline function addTo(rhs:TVector3):TVector3 {
		x += rhs.x;
		y += rhs.y;
		z += rhs.z;
		return cast this;
	}

	@:op(A - B)
	public inline function sub(rhs:TVector3):TVector3 {
		var x1:Single = x - rhs.x;
		var y1:Single = y - rhs.y;
		var z1:Single = z - rhs.z;

		return new TVector3(x1, y1,z1);
	}

	@:op(A -= B)
	public inline function subFrom(rhs:TVector3):TVector3 {
		x -= rhs.x;
		y -= rhs.y;
		z -= rhs.z;
		return cast this;
	}

	@:op(A * B)
	public inline function mul(rhs:Single):TVector3 {
		var x1:Single = x * rhs;
		var y1:Single = y * rhs;
		var z1:Single = z * rhs;
		return new TVector3(x1, y1, z1);
	}

	@:op(A *= B)
	public inline function mulWith(rhs:Single):TVector3 {
		x *= rhs;
		y *= rhs;
		z *= rhs;
		return cast this;
	}

	@:op(A * B)
	public inline function mulVector2(rhs:TVector3):TVector3 {
		var x1:Single = x * rhs.x;
		var y1:Single = y * rhs.y;
		var z1:Single = z * rhs.z;
		return new TVector3(x1, y1, z1);
	}

	@:op(A *= B)
	public inline function mulWithVector2(rhs:TVector3):TVector3 {
		x *= rhs.x;
		y *= rhs.y;
		z *= rhs.z;
		return cast this;
	}

	@:op(A / B)
	public inline function div(rhs:Single):TVector3 {
		var x1:Single = x / rhs;
		var y1:Single = y / rhs;
		var z1:Single = z / rhs;
		return new TVector3(x1, y1, z1);
	}

	@:op(A /= B)
	public inline function divWith(rhs:Single):TVector3 {
		x /= rhs;
		y /= rhs;
		z /= rhs;

		return cast this;
	}

	@:op(A / B)
	public inline function divVector2(rhs:TVector3):TVector3 {
		var x1:Single = x / rhs.x;
		var y1:Single = y / rhs.y;
		var z1:Single = z / rhs.z;

		return new TVector3(x1, y1);
	}

	@:op(A /= B)
	public inline function divWithVector2(rhs:TVector3):TVector3 {
		x /= rhs.x;
		y /= rhs.y;
		z /= rhs.z;
		return cast this;
	}

	@:op(-A)
	public inline function neg():TVector3 {
		x = -x;
		y = -y;
		z = -z;
		return cast this;
	}

	@:op(--A)
	public inline function preNeg():TVector3 {
		x = --x;
		y = --y;
		z = --z;
		return cast this;
	}

	@:op(A--) public inline function postNeg():TVector3 {
		x = x--;
		y = y--;
		z = z--;
		return cast this;
	}

	@:op(++A) public inline function preAdd():TVector3 {
		x = ++x;
		y = ++y;
		z = ++z;
		return cast this;
	}

	@:op(A++) public inline function postAdd():TVector3 {
		x = x++;
		y = y++;
		z = z++;
		return cast this;
	}

    
    public var x(get, set):Float;
    public var y(get, set):Float;
    public var z(get, set):Float;

	inline function get_x() {
		return _get_x(cast this);
	}

	@:hlNative("Urho3D", "_math_tvector3_get_x")
	private static function _get_x(v:TVector3):Single {
		return 0.0;
	}

	inline function set_x(x) {
		return _set_x(cast this, x);
	}

	@:hlNative("Urho3D", "_math_tvector3_set_x")
	private static function _set_x(v:TVector3, x:Single):Single {
		return 0.0;
	}

	inline function get_y() {
		return _get_y(cast this);
	}

	@:hlNative("Urho3D", "_math_tvector3_get_y")
	private static function _get_y(v:TVector3):Single {
		return 0.0;
	}

	inline function set_y(y) {
		return _set_y(cast this, y);
	}

	@:hlNative("Urho3D", "_math_tvector3_set_y")
	private static function _set_y(v:TVector3, x:Single):Single {
		return 0.0;
	}



    inline function get_z() {
		return _get_z(cast this);
	}

	@:hlNative("Urho3D", "_math_tvector3_get_z")
	private static function _get_z(v:TVector3):Single {
		return 0.0;
	}

	inline function set_z(y) {
		return _set_z(cast this, y);
	}

	@:hlNative("Urho3D", "_math_tvector3_set_z")
	private static function _set_z(v:TVector3, x:Single):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_math_tvector3_cast_from_vector3")
	private static function _CastFromVector3(vec2:Vector3):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_math_tvector3_cast_to_vector3")
	private static function _CastToVector3(vec2:TVector3):Vector3 {
        return null;
    }
}