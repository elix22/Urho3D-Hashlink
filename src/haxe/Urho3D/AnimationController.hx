
package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_ANIMATION_CONTROLLER = hl.Abstract<"hl_urho3d_graphics_animation_controller">;

class AnimationController extends Component {
	private var _abstract:AbstractAnimationController = null;

	public inline function new(?abs:AbstractAnimationController) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractAnimationController();

		super(AbstractAnimationController.CastToComponent(Context.context, _abstract));
	}

}


@:hlNative("Urho3D")
abstract AbstractAnimationController(HL_URHO3D_ANIMATION_CONTROLLER) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toAnimationController():AnimationController {
		return new AnimationController(cast this);
	}

	@:hlNative("Urho3D", "_graphics_animation_controller_create")
	private static function Create(c:Context):HL_URHO3D_ANIMATION_CONTROLLER {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animation_controller_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractAnimationController {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animation_controller_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractAnimationController):AbstractComponent {
		return null;
    }
    
}