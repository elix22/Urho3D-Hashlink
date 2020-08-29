package urho3d;

import haxe.Int64;

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

	public static inline function Lerp(lhs:Float, rhs:Float, t:Float) {
		return lhs * (1.0 - t) + rhs * t;
	}

	public static inline function InverseLerp(lhs:Float, rhs:Float, x:Float) {
		return (x - lhs) / (rhs - lhs);
	}

	public static inline function Max(a:Float, b:Float) {
		return return a < b || std.Math.isNaN(b) ? b : a;
	}

	public static inline function Min(a:Float, b:Float) {
		return a < b || std.Math.isNaN(a) ? a : b;
	}

	public static inline function Abs(value:Float) {
		return value >= 0.0 ? value : -value;
	}

	public static inline function Sign(value:Float) {
		return value > 0.0 ? 1.0 : (value < 0.0 ? -1.0 : 0.0);
	}

	public static inline function ToRadians(v:Float):Float {
		return v * _DEGTORAD_;
	}

	public static inline function ToDegrees(v:Float):Float {
		return _RADTODEG_ * v;
	}

	public static inline function IsNaN(value:Float) {
		return std.Math.isNaN(value);
	}

	public static inline function IsInf(value:Float) {
		return !std.Math.isFinite(value);
	}

	public static inline function Clamp(value:Float, min:Float, max:Float) {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}

	public static inline function SmoothStep(lhs:Float, rhs:Float, t:Float) {
		t = Clamp((t - lhs) / (rhs - lhs), 0.0, 1.0); // Saturate t
		return t * t * (3.0 - 2.0 * t);
	}

	public static inline function Sin(angle:Float) {
		return std.Math.sin(angle * _DEGTORAD_);
	}

	public static inline function Cos(angle:Float) {
		return std.Math.cos(angle * _DEGTORAD_);
	}

	public static inline function Tan(angle:Float) {
		return std.Math.tan(angle * _DEGTORAD_);
	}

	public static inline function Asin(x:Float) {
		return _RADTODEG_ * std.Math.asin(Clamp(x, (-1.0), (1.0)));
	}

	/// Return arc cosine in degrees.
	public static inline function Acos(x:Float) {
		return _RADTODEG_ * std.Math.acos(Clamp(x, (-1.0), (1.0)));
	}

	/// Return arc tangent in degrees.
	public static inline function Atan(x:Float) {
		return _RADTODEG_ * std.Math.atan(x);
	}

	/// Return arc tangent of y/x in degrees.
	public static inline function Atan2(y:Float, x:Float) {
		return _RADTODEG_ * std.Math.atan2(y, x);
	}

	/// Return X in power Y.
	public static inline function Pow(x:Float, y:Float) {
		return std.Math.pow(x, y);
	}

	/// Return natural logarithm of X.
	public static inline function Ln(x:Float) {
		return std.Math.log(x);
	}

	/// Return square root of X.
	public static inline function Sqrt(x:Float) {
		return std.Math.sqrt(x);
	}

	public static inline function Mod(x:Float, y:Float) {
		return x % y;
	}

	public static inline function AbsMod(x:Float, y:Float) {
		var result = x % y;
		return result < 0 ? result + y : result;
	}

	public static inline function Fract(value:Float) {
		return value - std.Math.floor(value);
	}

	public static inline function Floor(x:Float) {
		return std.Math.floor(x);
	}

	public static inline function FloorToInt(x:Float):Int {
		return std.Math.floor(x);
	}

	public static inline function Round(x:Float) {
		return std.Math.round(x);
	}

	public static inline function RoundToInt(x:Float):Int {
		return std.Math.round(x);
	}

	public static inline function RoundToNearestMultiple(x:Float, multiple:Float) {
		var mag = Abs(x);
		multiple = Abs(multiple);
		var remainder = Mod(mag, multiple);
		if (remainder >= multiple / 2)
			return (FloorToInt(mag / multiple) * multiple + multiple) * Sign(x);
		else
			return (FloorToInt(mag / multiple) * multiple) * Sign(x);
	}

	public static inline function Ceil(x:Float) {
		return std.Math.ceil(x);
	}

	public static inline function CeilToInt(x:Float):Int {
		return std.Math.ceil(x);
	}

	public static inline function IsPowerOfTwo(value:Int64) {
		return (value & (value - 1)) == 0;
	}

	public static inline function NextPowerOfTwo(value:Int64):Int64 {
		// http://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2
		--value;
		value |= value >> 1;
		value |= value >> 2;
		value |= value >> 4;
		value |= value >> 8;
		value |= value >> 16;
		return ++value;
	}

	public static inline function ClosestPowerOfTwo(value:Int64):Int64 {
		var next = NextPowerOfTwo(value);
		var prev = next >> 1;
		return (value - prev) > (next - value) ? next : prev;
	}

	public static inline function LogBaseTwo(value:Int64) {
		// http://graphics.stanford.edu/~seander/bithacks.html#IntegerLogObvious
		var ret:Int64 = 0;
		while ((value >>= 1) != 0) // Unroll for more speed...
			++ret;
		return ret;
	}

	public static inline function CountSetBits(value:Int64) {
		// Brian Kernighan's method
		var count:Int = 0;
		while (value != 0) {
			value &= value - 1;
			count++;
		}
		return count;
	}

	public static inline function SDBMHash(hash:Int64, c:Int) {
		return c + (hash << 6) + (hash << 16) - hash;
	}

	public static inline function Random(?min:Null<Float>, ?max:Null<Float>):Float {
		if (min == null)
			return std.Math.random();
		else if (min != null && max == null) {
			return std.Math.random() * min;
		} else {
			return std.Math.random() * (max - min) + min;
		}
	}

	public static inline function RandStandardNormal() {
		var val:Float = 0.0;
		for (i in 0...12)
			val += std.Math.random();
		val -= 6.0;

		// Now val is approximatly standard normal distributed
		return val;
	}

	public static inline function RandomNormal(meanValue:Float, variance:Float) {
		return RandStandardNormal() * std.Math.sqrt(variance) + meanValue;
	}

	public static inline function ExponentialOut(time:Float):Float {
		return time == 1.0 ? 1.0 : (-std.Math.pow(2.0, -10.0 * time / 1.0) + 1.0);
	}
}
