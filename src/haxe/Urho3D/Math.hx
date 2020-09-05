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
	public static final _TWO_PI_ = 3.1415926535897932384626433832795028 * 2;
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

	public static inline function BackIn(time:Float):Float {
		final overshoot = 1.70158;

		return time * time * ((overshoot + 1) * time - overshoot);
	}

	public static inline function BackOut(time:Float):Float {
		final overshoot = 1.70158;

		time = time - 1;
		return time * time * ((overshoot + 1) * time + overshoot) + 1;
	}

	public static inline function BackInOut(time:Float):Float {
		final overshoot = 1.70158 * 1.525;

		time = time * 2;
		if (time < 1) {
			return (time * time * ((overshoot + 1) * time - overshoot)) / 2;
		} else {
			time = time - 2;
			return (time * time * ((overshoot + 1) * time + overshoot)) / 2 + 1;
		}
	}

	public inline static function BounceOut(time:Float):Float {
		var result:Float = 0.0;

		if (time < 1 / 2.75) {
			result = 7.5625 * time * time;
		} else if (time < 2 / 2.75) {
			time -= 1.5 / 2.75;
			result = 7.5625 * time * time + 0.75;
		} else if (time < 2.5 / 2.75) {
			time -= 2.25 / 2.75;
			result = 7.5625 * time * time + 0.9375;
		} else {
			time -= 2.625 / 2.75;
			result = 7.5625 * time * time + 0.984375;
		}

		return result;
	}

	public static inline function BounceIn(time:Float):Float {
		return 1 - BounceOut(1 - time);
	}

	public static inline function BounceInOut(time:Float):Float {
		if (time < 0.5) {
			time = time * 2;
			return (1 - BounceOut(1 - time)) * 0.5;
		}
		return BounceOut(time * 2 - 1) * 0.5 + 0.5;
	}

	public static inline function SineOut(time:Float):Float {
		return std.Math.sin(time * _HALF_PI_);
	}

	public static inline function SineIn(time:Float):Float {
		return -1 * std.Math.cos(time * _HALF_PI_) + 1.0;
	}

	public static inline function SineInOut(time:Float):Float {
		return -0.5 * (std.Math.cos(Math._PI_ * time) - 1.0);
	}

	public static inline function ExponentialOut(time:Float):Float {
		return time == 1.0 ? 1.0 : (-std.Math.pow(2.0, -10.0 * time / 1.0) + 1.0);
	}

	public static inline function ExponentialIn(time:Float):Float {
		return time == 0.0 ? 0.0 : std.Math.pow(2.0, 10.0 * (time / 1.0 - 1.0)) - 1.0 * 0.001;
	}

	public static inline function ExponentialInOut(time:Float):Float {
		time /= 0.5;
		if (time < 1.0) {
			return 0.5 * std.Math.pow(2.0, 10.0 * (time - 1.0));
		} else {
			return 0.5 * (-std.Math.pow(2.0, -10.0 * (time - 1.0)) + 2.0);
		}
	}

	public static inline function ElasticIn(time:Float, period:Float) {
		if (time == 0 || time == 1) {
			return time;
		} else {
			var s:Float = period / 4;
			time = time - 1;
			return -(std.Math.pow(2, 10 * time) * std.Math.sin((time - s) * _PI_ * 2.0 / period));
		}
	}

	public static inline function ElasticOut(time:Float, period:Float) {
		if (time == 0 || time == 1) {
			return time;
		} else {
			var s:Float = period / 4;
			return (std.Math.pow(2, -10 * time) * std.Math.sin((time - s) * _PI_ * 2.0 / period) + 1);
		}
	}

	public static inline function ElasticInOut(time:Float, period:Float) {
		if (time == 0 || time == 1) {
			return time;
		} else {
			time = time * 2;
			if (period == 0) {
				period = 0.3 * 1.5;
			}

			var s:Float = period / 4;

			time = time - 1;
			if (time < 0) {
				return (-0.5 * std.Math.pow(2, 10 * time) * std.Math.sin((time - s) * _TWO_PI_ / period));
			} else {
				return (std.Math.pow(2, -10 * time) * std.Math.sin((time - s) * _TWO_PI_ / period) * 0.5 + 1.0);
			}
		}
	}

	public static inline function   CardinalSplineAt( p0:TVector2,  p1:TVector2,  p2:TVector2,  p3:TVector2,  tension:Float,  t:Float):TVector2
	{
		if (tension < 0)
		{
			tension = 0;
		}
		if (tension > 1)
		{
			tension = 1;
		}
		var t2:Float = t * t;
		var t3:Float = t2 * t;

		/*
		 * Formula: s(-ttt + 2tt - t)P1 + s(-ttt + tt)P2 + (2ttt - 3tt + 1)P2 + s(ttt - 2tt + t)P3 + (-2ttt + 3tt)P3 + s(ttt - tt)P4
		 */
		var s:Float = (1 - tension) / 2;

		var b1:Float = s * ((-t3 + (2 * t2)) - t); // s(-t3 + 2 t2 - t)P1
		var b2:Float = s * (-t3 + t2) + (2 * t3 - 3 * t2 + 1); // s(-t3 + t2)P2 + (2 t3 - 3 t2 + 1)P2
		var b3:Float = s * (t3 - 2 * t2 + t) + (-2 * t3 + 3 * t2); // s(t3 - 2 t2 + t)P3 + (-2 t3 + 3 t2)P3
		var b4:Float = s * (t3 - t2); // s(t3 - t2)P4

		var x:Float = (p0.x * b1 + p1.x * b2 + p2.x * b3 + p3.x * b4);
		var y:Float = (p0.y * b1 + p1.y * b2 + p2.y * b3 + p3.y * b4);

		return new TVector2(x, y);
	}

	public static inline function CubicBezier(a:Float, b:Float, c:Float, d:Float, t:Float) {
		var t1 = 1.0 - t;
		return ((t1 * t1 * t1) * a + 3.0 * t * (t1 * t1) * b + 3.0 * (t * t) * (t1) * c + (t * t * t) * d);
	}

	public static inline function QuadBezier(a:Float, b:Float, c:Float, t:Float) {
		var t1 = 1.0 - t;
		return (t1 * t1) * a + 2.0 * (t1) * t * b + (t * t) * c;
	}
}
