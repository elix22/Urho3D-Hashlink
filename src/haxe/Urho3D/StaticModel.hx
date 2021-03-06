package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_STATICMODEL = hl.Abstract<"hl_urho3d_graphics_staticmodel">;

class StaticModel extends Component {
	private var _abstract:AbstractStaticModel = null;

	public inline function new(?abs:AbstractStaticModel) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractStaticModel();

		super(AbstractStaticModel.CastToComponent(Context.context, _abstract));
	}

	public var model(get, set):Model;
	public var material(get, set):Material;
	public var castShadows(get, set):Bool;
	public var occluder(get, set):Bool;
	public var occludee(get, set):Bool;

	function set_occluder(m) {
		AbstractStaticModel.SetOccluder(Context.context, _abstract, m);
		return m;
	}

	function get_occluder() {
		return AbstractStaticModel.GetOccluder(Context.context, _abstract);
    }
    
    function set_occludee(m) {
		AbstractStaticModel.SetOccludee(Context.context, _abstract, m);
		return m;
	}

	function get_occludee() {
		return AbstractStaticModel.GetOccludee(Context.context, _abstract);
	}

	function set_model(m) {
		AbstractStaticModel.SetModel(Context.context, _abstract, m);
		return m;
	}

	function get_model() {
		return AbstractStaticModel.GetModel(Context.context, _abstract);
	}

	function set_material(m) {
		AbstractStaticModel.SetMaterial(Context.context, _abstract, m);
		return m;
	}

	function get_material() {
		return AbstractStaticModel.GetMaterial(Context.context, _abstract);
	}

	function set_castShadows(c) {
		AbstractStaticModel.SetCastShadows(Context.context, _abstract, c);
		return c;
	}

	function get_castShadows() {
		return AbstractStaticModel.GetCastShadows(Context.context, _abstract);
	}
}

@:hlNative("Urho3D")
abstract AbstractStaticModel(HL_URHO3D_STATICMODEL) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toStaticModel():StaticModel {
		return new StaticModel(cast this);
	}

	@:hlNative("Urho3D", "_graphics_staticmodel_create")
	private static function Create(c:Context):HL_URHO3D_STATICMODEL {
		return null;
	}

	//

	@:hlNative("Urho3D", "_graphics_staticmodel_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractStaticModel {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_staticmodel_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractStaticModel):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_staticmodel_set_model")
	public static function SetModel(c:Context, s:AbstractStaticModel, m:Model):Void {}

	@:hlNative("Urho3D", "_graphics_staticmodel_get_model")
	public static function GetModel(c:Context, s:AbstractStaticModel):Model {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_staticmodel_set_material")
	public static function SetMaterial(c:Context, s:AbstractStaticModel, m:Material):Void {}

	@:hlNative("Urho3D", "_graphics_staticmodel_get_material")
	public static function GetMaterial(c:Context, s:AbstractStaticModel):Material {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_staticmodel_set_cast_shadows")
	public static function SetCastShadows(c:Context, s:AbstractStaticModel, m:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_staticmodel_get_cast_shadows")
	public static function GetCastShadows(c:Context, s:AbstractStaticModel):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_staticmodel_set_occluder")
	public static function SetOccluder(c:Context, s:AbstractStaticModel, m:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_staticmodel_get_occluder")
	public static function GetOccluder(c:Context, s:AbstractStaticModel):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_staticmodel_set_occludee")
	public static function SetOccludee(c:Context, s:AbstractStaticModel, m:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_staticmodel_get_occludee")
	public static function GetOccludee(c:Context, s:AbstractStaticModel):Bool {
		return false;
	}
}
