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
}
