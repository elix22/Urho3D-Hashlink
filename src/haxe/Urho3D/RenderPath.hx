package urho3d;

typedef HL_URHO3D_RENDER_PATH = hl.Abstract<"hl_urho3d_graphics_render_path">;


@:hlNative("Urho3D")
abstract RenderPath(HL_URHO3D_RENDER_PATH) {

	public inline function new() {
		this = Create(Context.context);
	}

	public inline function Clone() {
		return _Clone(Context.context, cast this);
	}

	public inline function Append(x:XMLFile) {
		return _Append(Context.context, cast this, x);
	}

	public inline function SetShaderParameter(key:String, value:Variant) {
		_SetShaderParameter(Context.context, cast this, key, value);
    }
    
    public inline function  GetShaderParameter(key:String):Variant {
		return _GetShaderParameter(Context.context,cast this, key);
	}

	public inline function SetEnabled(x:String, b:Bool) {
		_SetEnabled(Context.context, cast this, x, b);
	}

	public inline function ToggleEnabled(x:String) {
		_ToggleEnabled(Context.context, cast this, x);
	}

	@:hlNative("Urho3D", "_graphics_render_path_create")
	private static function Create(context:Context):HL_URHO3D_RENDER_PATH {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_render_path_clone")
	private static function _Clone(context:Context, r:RenderPath):RenderPath {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_render_path_append")
	private static function _Append(context:Context, r:RenderPath, x:XMLFile):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_render_set_shader_parameter")
    private static function _SetShaderParameter(context:Context, r:RenderPath, x:String, v:Variant):Void {}
      
    @:hlNative("Urho3D", "_graphics_render_get_shader_parameter")
	private static function _GetShaderParameter(context:Context, r:RenderPath, x:String):Variant {return null;}

	@:hlNative("Urho3D", "_graphics_render_set_enabled")
	private static function _SetEnabled(context:Context, r:RenderPath, x:String, b:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_render_toggle_enabled")
	private static function _ToggleEnabled(context:Context, r:RenderPath, x:String):Void {}
}
