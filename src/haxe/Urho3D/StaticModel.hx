
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

    public var model(get,set):Model;
    public var material(get,set):Material;

    public function set_model(m)
    {
        AbstractStaticModel.SetModel(Context.context,_abstract,m);
        return m;
    }

    public function get_model()
    {
        return AbstractStaticModel.GetModel(Context.context,_abstract);
    }

    public function set_material(m)
    {
        AbstractStaticModel.SetMaterial(Context.context,_abstract,m);
        return m;
    }

    public function get_material()
    {
        return AbstractStaticModel.GetMaterial(Context.context,_abstract);
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
	public static function SetModel(c:Context, s:AbstractStaticModel , m:Model):Void {
    }

    @:hlNative("Urho3D", "_graphics_staticmodel_get_model")
	public static function GetModel(c:Context, s:AbstractStaticModel ):Model {
        return null;
    }

    @:hlNative("Urho3D", "_graphics_staticmodel_set_material")
	public static function SetMaterial(c:Context, s:AbstractStaticModel , m:Material):Void {
    }

    @:hlNative("Urho3D", "_graphics_staticmodel_get_material")
	public static function GetMaterial(c:Context, s:AbstractStaticModel ):Material {
        return null;
    }
    
}