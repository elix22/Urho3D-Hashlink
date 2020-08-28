package urho3d;


enum abstract Mathdefs(Float) to Float from Float {
	var M_PI = 3.1415926535897932384626433832795028;
	var M_HALF_PI = 3.1415926535897932384626433832795028 * 0.5;
	var M_EPSILON = 0.000001;
	var M_LARGE_EPSILON = 0.00005;
	var M_MIN_NEARCLIP = 0.01;
	var M_MAX_FOV = 160.0;
	var M_LARGE_VALUE = 100000000.0;
	var M_INFINITY = 1e10;
	var M_DEGTORAD = 3.1415926535897932384626433832795028 / 180.0;
	var M_DEGTORAD_2 = 3.1415926535897932384626433832795028 / 360.0; // M_DEGTORAD / 2.f
	var M_RADTODEG = 1.0 / (3.1415926535897932384626433832795028 / 180.0);
}




enum abstract IntMathDefs(Int) to Int from Int {
	var M_MIN_INT = 0x80000000;
	var M_MAX_INT = 0x7fffffff;
	var M_MIN_UNSIGNED = 0x00000000;
	var M_MAX_UNSIGNED = 0xffffffff;
}

class Math {
	public static final _PI_ = 3.1415926535897932384626433832795028;
	public static final _HALF_PI_ = 3.1415926535897932384626433832795028 * 0.5;
	public static final _EPSILON_ = 0.000001;
	public static final _LARGE_EPSILON_ = 0.00005;
	public static final _MIN_NEARCLIP_ = 0.01;
	public static final _MAX_FOV_ = 160.0;
	public static final _LARGE_VALUE_ = 100000000.0;
	public static final _INFINITY_ = 1e10;
	public static final _DEGTORAD_ = 3.1415926535897932384626433832795028 / 180.0;
	public static final _DEGTORAD_2_ = 3.1415926535897932384626433832795028 / 360.0; // DEGTORAD / 2.f
	public static final _RADTODEG_ = 1.0 / (3.1415926535897932384626433832795028 / 180.0);

	public static final _MIN_INT_ = 0x80000000;
	public static final _MAX_INT_ = 0x7fffffff;
	public static final _MIN_UNSIGNED_ = 0x00000000;
	public static final _MAX_UNSIGNED_ = 0xffffffff;

	public static inline function ToRadians(v:Float):Float {
		return v * _DEGTORAD_;
	}

	public static inline function ToDegrees(v:Float):Float {
		return _RADTODEG_ * v;
	}

	public static inline function Sin(angle:Float) { return std.Math.sin(angle * _DEGTORAD_); }
	public static inline function Tan(angle:Float) { return std.Math.tan(angle * _DEGTORAD_); }

	public static inline function  Max(a:Float, b:Float) { return return a < b || std.Math.isNaN(b) ? b : a; }
	public static inline function  Min(a:Float, b:Float) { return a < b || std.Math.isNaN(a) ? a : b; }
}
