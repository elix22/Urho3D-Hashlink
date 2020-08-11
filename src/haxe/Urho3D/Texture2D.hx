package urho3d;

import urho3d.GraphicsDefs;

typedef HL_URHO3D_TEXTURE2D = hl.Abstract<"hl_urho3d_texture2d">;

@:hlNative("Urho3D")
abstract Texture2D(HL_URHO3D_TEXTURE2D) {
	public inline function new(?name:String) {
		if (name == null) {
			this = CreateEmpty(Context.context);
		} else {
			this = Create(Context.context, name);
		}
	}

	public inline function SetSize(width:Int, height:Int, format:Int, usage:TextureUsage = TEXTURE_STATIC, multiSample:Int = 1, autoResolve:Bool = true):Bool {
		return _SetSize(Context.context, cast this, width, height, format, usage, multiSample, autoResolve);
	}

	public var name(get, never):String;

	function get_name():String {
		return GetName();
	}

	public function GetName() @:privateAccess {
		return String.fromUTF8(_getName(this));
	}

	public var filterMode(get, set):TextureFilterMode;

	function set_filterMode(m) {
		_SetFilterMode(Context.context, cast this, m);
		return m;
	}

	function get_filterMode() {
		return _GetFilterMode(Context.context, cast this);
	}

	public var renderSurface(get, never):RenderSurface;

	function get_renderSurface() {
		return GetRenderSurface(Context.context, cast this);
	}

	@:to
	public inline function toTexture():Texture {
		return _CastToTexture(Context.context, cast this);
	}

	@:from
	public static inline function fromTexture(t:Texture):Texture2D {
		return _CastFromTexture(Context.context, t);
	}

	@:hlNative("Urho3D", "_graphics_texture2d_create")
	private static function Create(context:Context, name:String):HL_URHO3D_TEXTURE2D {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_texture2d_create_empty")
	private static function CreateEmpty(context:Context):HL_URHO3D_TEXTURE2D {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_texture2d_get_name")
	private static function _getName(Texture2D):hl.Bytes {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_texture2d_cast_to_texture")
	private static function _CastToTexture(context:Context, t:Texture2D):Texture {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_texture2d_cast_from_texture")
	private static function _CastFromTexture(context:Context, t:Texture):Texture2D {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_texture2d_set_size")
	private static function _SetSize(context:Context, t:Texture2D, width:Int, height:Int, format:Int, usage:TextureUsage, multiSample:Int,
			autoResolve:Bool):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_texture2d_set_filter_mode")
	private static function _SetFilterMode(context:Context, t:Texture2D, mode:Int):Void {}

	@:hlNative("Urho3D", "_graphics_texture2d_get_filter_mode")
	private static function _GetFilterMode(context:Context, t:Texture2D):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_graphics_texture2d_get_render_surface")
	private static function GetRenderSurface(context:Context, t:Texture2D):RenderSurface {
		return null;
	}
}
