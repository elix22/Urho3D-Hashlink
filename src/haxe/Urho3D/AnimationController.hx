package urho3d;

import hl.uv.Stream;
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

	public inline function PlayExclusive(name:String, layer:Int, looped:Bool, fadeTime:Float = 0.0) {
		return AbstractAnimationController.PlayExclusive(Context.context, _abstract, name, layer, looped, fadeTime);
	}

	public  function SetSpeed(name:String, speed:Float):Bool {
		return AbstractAnimationController.SetSpeed(Context.context, _abstract, name, speed);
	}

	public  function GetSpeed(name:String ):Float {
		return AbstractAnimationController.GetSpeed(Context.context, _abstract, name);
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

	// DEFINE_PRIM(_BOOL, _graphics_animation_controller_play_exclusive, URHO3D_CONTEXT HL_URHO3D_ANIMATION_CONTROLLER _STRING _I32 _BOOL _F32);

	@:hlNative("Urho3D", "_graphics_animation_controller_play_exclusive")
	public static function PlayExclusive(c:Context, s:AbstractAnimationController, name:String, layer:Int, looped:Bool, fadeTime:Single):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_animation_controller_set_speed")
	public static function SetSpeed(c:Context, s:AbstractAnimationController, name:String, speed:Single):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_animation_controller_get_speed")
	public static function GetSpeed(c:Context, s:AbstractAnimationController, name:String):Single {
		return 0.0;
	}
}
