package urho3d;

import urho3d.Animation.WrapMode;
import urho3d.GraphicsDefs;

typedef HL_URHO3D_MATERIAL = hl.Abstract<"hl_urho3d_graphics_material">;

@:hlNative("Urho3D")
abstract Material(HL_URHO3D_MATERIAL) {
	public inline function new(?name:String) {
		if (name == null)
			this = CreateEmpty(Context.context);
		else
			this = Create(Context.context, name);
	}

	public inline function SetTechnique(index:Int, tech:Technique, qualityLevel:MaterialQuality = QUALITY_LOW, lodDistance:Float = 0.0) {
		_SetTechnique(Context.context, cast this, index, tech, qualityLevel, lodDistance);
	}

	public inline function SetTexture(unit:TextureUnit, texture:Texture) {
		_SetTexture(Context.context, cast this, unit, texture);
	}

	public inline function SetShaderParameter(name:String, v:TVariant) {
		_SetShaderParameter(Context.context, cast this, name, v);
	}

	public inline function GetShaderParameter(name:String):TVariant {
		return _GetShaderParameter(Context.context, cast this, name);
	}

	public inline function SetShaderParameterAnimation(name:String, va:ValueAnimation,w:WrapMode=WM_LOOP, s:Single=1.0):Void {
		_SetShaderParameterAnimation(Context.context, cast this, name, va,w, s);
	}

	public inline function GetShaderParameterAnimation(name:String):ValueAnimation {
		return _GetShaderParameterAnimation(Context.context, cast this, name);
	}

	public inline function Clone(name:String=""):Material {
		return _Clone(Context.context, cast this, name);
	}

	public var depthBias(get, set):BiasParameters;

	function set_depthBias(o) {
		_SetDepthBias(Context.context, cast this, o);
		return o;
	}

	function get_depthBias() {
		return _GetDepthBias(Context.context, cast this);
	}

	@:hlNative("Urho3D", "_graphics_material_create")
	private static function Create(context:Context, name:String):HL_URHO3D_MATERIAL {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_material_create_empty")
	private static function CreateEmpty(context:Context):HL_URHO3D_MATERIAL {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_material_set_technique")
	private static function _SetTechnique(context:Context, material:Material, index:Int, tech:Technique, qualityLevel:Int, lodDistance:Single):Void {}

	@:hlNative("Urho3D", "_graphics_material_set_texture")
	private static function _SetTexture(context:Context, material:Material, unit:Int, texture:Texture):Void {}

	@:hlNative("Urho3D", "_graphics_material_set_depth_bias")
	private static function _SetDepthBias(context:Context, material:Material, parameters:BiasParameters):Void {}

	@:hlNative("Urho3D", "_graphics_material_get_depth_bias")
	private static function _GetDepthBias(context:Context, material:Material):BiasParameters {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_material_set_shader_parameter")
	private static function _SetShaderParameter(context:Context, material:Material, name:String, v:TVariant):Void {}

	@:hlNative("Urho3D", "_graphics_material_get_shader_parameter")
	private static function _GetShaderParameter(context:Context, material:Material, name:String):TVariant {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_material_set_shader_parameter_animation")
	private static function _SetShaderParameterAnimation(context:Context, material:Material, name:String, va:ValueAnimation,w:Int, s:Single):Void {}

	@:hlNative("Urho3D", "_graphics_material_get_shader_parameter_animation")
	private static function _GetShaderParameterAnimation(context:Context, material:Material, name:String):ValueAnimation {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_material_clone")
	private static function _Clone(context:Context, material:Material, name:String):Material {
		return null;
	}
}
