package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_LIGHT = hl.Abstract<"hl_urho3d_graphics_light">;

@:enum abstract LightType(Int) {
	var LIGHT_DIRECTIONAL = 0;
	var LIGHT_SPOT = 1;
	var LIGHT_POINT = 2;
}

class Light extends Component {
	private var _abstract:AbstractLight = null;

	public inline function new(?abs:AbstractLight) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractLight();

		super(AbstractLight.CastToComponent(Context.context, _abstract));
	}

	public var lightType(get, set):LightType;

	public function set_lightType(t) {
		AbstractLight.SetLightType(Context.context, _abstract, t);
		return t;
	}

	public function get_lightType() {
		return AbstractLight.GetLightType(Context.context, _abstract);
    }
    


    public var range(get, set):Float;

	public function set_range(t) {
		AbstractLight.SetRange(Context.context, _abstract, t);
		return t;
	}

	public function get_range() {
		return AbstractLight.GetRange(Context.context, _abstract);
	}

	public var color(get,set):Color;

	public function set_color(t) {
		AbstractLight.SetColor(Context.context, _abstract, t);
		return t;
	}

	public function get_color() {
		return AbstractLight.GetColor(Context.context, _abstract);
	}

	public var castShadows(get, set):Bool;

	public function set_castShadows(t) {
		AbstractLight.SetCastShadows(Context.context, _abstract, t);
		return t;
	}

	public function get_castShadows() {
		return AbstractLight.GetCastShadows(Context.context, _abstract);
	}

	public var shadowBias(get,set):BiasParameters;

	public function set_shadowBias(t) {
		AbstractLight.SetShadowBias(Context.context, _abstract, t);
		return t;
	}

	public function get_shadowBias() {
		return AbstractLight.GetShadowBias(Context.context, _abstract);
	}

	public var shadowCascade(get,set):CascadeParameters;

	public function set_shadowCascade(t) {
		AbstractLight.SetShadowCascade(Context.context, _abstract, t);
		return t;
	}

	public function get_shadowCascade() {
		return AbstractLight.GetShadowCascade(Context.context, _abstract);
	}

	public var specularIntensity(get, set):Float;

	public function set_specularIntensity(t) {
		AbstractLight.SetSpecularIntensity(Context.context, _abstract, t);
		return t;
	}

	public function get_specularIntensity() {
		return AbstractLight.GetSpecularIntensity(Context.context, _abstract);
	}

}

@:hlNative("Urho3D")
abstract AbstractLight(HL_URHO3D_LIGHT) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toLight():Light {
		return new Light(cast this);
	}

	@:hlNative("Urho3D", "_graphics_light_create")
	private static function Create(c:Context):HL_URHO3D_LIGHT {
		return null;
	}

	//

	@:hlNative("Urho3D", "_graphics_light_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractLight {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_light_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractLight):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_light_set_light_type")
	public static function SetLightType(c:Context, s:AbstractLight, t:LightType):Void {}

	@:hlNative("Urho3D", "_graphics_light_get_light_type")
	public static function GetLightType(c:Context, s:AbstractLight):LightType {
		return LIGHT_POINT;
	}

	@:hlNative("Urho3D", "_graphics_light_set_range")
	public static function SetRange(c:Context, s:AbstractLight, t:Single):Void {}

	@:hlNative("Urho3D", "_graphics_light_get_range")
	public static function GetRange(c:Context, s:AbstractLight):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_light_set_specular_intensity")
	public static function SetSpecularIntensity(c:Context, s:AbstractLight, t:Single):Void {}

	@:hlNative("Urho3D", "_graphics_light_get_specular_intensity")
	public static function GetSpecularIntensity(c:Context, s:AbstractLight):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_light_set_color")
	public static function SetColor(c:Context, s:AbstractLight,c:Color):Void {
	}

	@:hlNative("Urho3D", "_graphics_light_get_color")
	public static function GetColor(c:Context, s:AbstractLight):Color {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_light_set_cast_shadows")
	public static function SetCastShadows(c:Context, s:AbstractLight,c:Bool):Void {
	}

	@:hlNative("Urho3D", "_graphics_light_get_cast_shadows")
	public static function GetCastShadows(c:Context, s:AbstractLight):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_light_set_shadow_bias")
	public static function SetShadowBias(c:Context, s:AbstractLight,b:BiasParameters):Void {
	}

	@:hlNative("Urho3D", "_graphics_light_get_shadow_bias")
	public static function GetShadowBias(c:Context, s:AbstractLight):BiasParameters {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_light_set_shadow_cascade")
	public static function SetShadowCascade(c:Context, s:AbstractLight,b:CascadeParameters):Void {
	}

	@:hlNative("Urho3D", "_graphics_light_get_shadow_cascade")
	public static function GetShadowCascade(c:Context, s:AbstractLight):CascadeParameters {
		return null;
	}

}
