package urho3d;

import urho3d.StaticModel.AbstractStaticModel;
import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_SKYBOX = hl.Abstract<"hl_urho3d_graphics_skybox">;

class Skybox extends StaticModel {
	private var _abstractSkybox:AbstractSkybox = null;

	public inline function new(?abs:AbstractSkybox) {
		if (abs != null)
			_abstractSkybox = abs;
		else
			_abstractSkybox = new AbstractSkybox();

		super(AbstractSkybox.CastToStaticModel(Context.context, _abstractSkybox));
	}


}


@:hlNative("Urho3D")
abstract AbstractSkybox(HL_URHO3D_SKYBOX) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toSkybox():Skybox {
		return new Skybox(cast this);
	}

	@:hlNative("Urho3D", "_graphics_skybox_create")
	private static function Create(c:Context):HL_URHO3D_SKYBOX {
		return null;
	}

	//

	@:hlNative("Urho3D", "_graphics_skybox_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractSkybox {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_skybox_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractSkybox):AbstractComponent {
		return null;
    }

    @:hlNative("Urho3D", "_graphics_skybox_cast_from_staticmodel")
	public static function CastFromStaticModel(c:Context, s:AbstractStaticModel):AbstractSkybox {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_skybox_cast_to_staticmodel")
	public static function CastToStaticModel(c:Context, s:AbstractSkybox):AbstractStaticModel {
		return null;
    }
    
}