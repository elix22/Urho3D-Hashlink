package urho3d;

/// Blending mode.
import urho3d.GraphicsDefs;

enum abstract BlendMode(Int) to Int from Int {
	var BLEND_REPLACE = 0;
	var BLEND_ADD = 1;
	var BLEND_MULTIPLY = 2;
	var BLEND_ALPHA = 3;
	var BLEND_ADDALPHA = 4;
	var BLEND_PREMULALPHA = 5;
	var BLEND_INVDESTALPHA = 6;
	var BLEND_SUBTRACT = 7;
	var BLEND_SUBTRACTALPHA = 8;
	var MAX_BLENDMODES;
}

class Graphics {
	public static var width(get, never):Int;
	public static var height(get, never):Int;

	public static var gl3Support = false;

	public static function GetAlphaFormat() {
		#if !GL_ES_VERSION_2_0
		// Alpha format is deprecated on OpenGL 3+
		if (gl3Support)
			return GL_R8;
		#end
		return GL_ALPHA;
	}

	public static function GetLuminanceFormat() {
		#if !GL_ES_VERSION_2_0
		// Luminance format is deprecated on OpenGL 3+
		if (gl3Support)
			return GL_R8;
		#end
		return GL_LUMINANCE;
	}

	public static function GetLuminanceAlphaFormat() {
		#if !GL_ES_VERSION_2_0
		// Luminance alpha format is deprecated on OpenGL 3+
		if (gl3Support)
			return GL_RG8;
		#end
		return GL_LUMINANCE_ALPHA;
	}

	public static function GetRGBFormat() {
		return GL_RGB;
	}

	public static function GetRGBAFormat() {
		return GL_RGBA;
	}

	public static function GetRGBA16Format() {
		#if GL_ES_VERSION_3_0
		return GL_RGBA16UI;
		#elseif !(GL_ES_VERSION_2_0)
		return GL_RGBA16;
		#else
		return GL_RGBA;
		#end
	}

	public static function GetRGBAFloat16Format() {
		#if GL_ES_VERSION_3_0
		return GL_RGBA16F;
		#elseif !(GL_ES_VERSION_2_0)
		return GL_RGBA16F_ARB;
		#else
		return GL_RGBA;
		#end
	}

	public static function GetRGBAFloat32Format() {
		#if !GL_ES_VERSION_2_0
		return GL_RGBA32F_ARB;
		#elseif URHO3D_GLES3
		return GL_RGBA32F;
		#else
		return GL_RGBA;
		#end
	}

	public static function GetRG16Format() {
		#if !GL_ES_VERSION_2_0
		return GL_RG16;
		#elseif URHO3D_GLES3
		return GL_RG16UI;
		#else
		return GL_RGBA;
		#end
	}

	public static function GetRGFloat16Format() {
		#if !URHO3D_GLES2
		return GL_RG16F;
		#else
		return GL_RGBA;
		#end
	}

	public static function GetRGFloat32Format() {
		#if !URHO3D_GLES2
		return GL_RG32F;
		#else
		return GL_RGBA;
		#end
	}

	public static function GetFloat16Format() {
		#if !URHO3D_GLES2
		return GL_R16F;
		#else
		return GL_LUMINANCE;
		#end
	}

	public static function GetFloat32Format() {
		#if !URHO3D_GLES2
		return GL_R32F;
		#else
		return GL_LUMINANCE;
		#end
	}

	public static function GetLinearDepthFormat() {
		#if !GL_ES_VERSION_2_0
		// OpenGL 3 can use different color attachment formats
		if (gl3Support)
			return GL_R32F;
		else
		#end
		#if GL_ES_VERSION_3_0
		return GL_R16F;
		#else
		// OpenGL 2 requires color attachments to have the same format, therefore encode deferred depth to RGBA manually
		// if not using a readable hardware depth texture
		return GL_RGBA;
		#end
	}

	public static function GetDepthStencilFormat() {
		#if !GL_ES_VERSION_2_0
		return GL_DEPTH24_STENCIL8_EXT;
		#elseif (GL_ES_VERSION_3_0)
		return GL_DEPTH24_STENCIL8;
		#else
		return glesDepthStencilFormat;
		#end
	}

	public static function GetReadableDepthFormat() {
		#if !GL_ES_VERSION_2_0
		return GL_DEPTH_COMPONENT24;
		#elseif (GL_ES_VERSION_3_0)
		return GL_DEPTH_COMPONENT16;
		#else
		return glesReadableDepthFormat;
		#end
	}

	private static function get_width():Int {
		return getWidth(Context.context);
	}

	private static function get_height():Int {
		return getHeight(Context.context);
	}

	@:hlNative("Urho3D", "_graphics_get_width")
	private static function getWidth(context:Context):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_graphics_get_height")
	private static function getHeight(context:Context):Int {
		return 0;
	}
}
