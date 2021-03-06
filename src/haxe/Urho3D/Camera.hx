package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_CAMERA = hl.Abstract<"hl_urho3d_graphics_camera">;

enum abstract ViewOverride(Int) from Int to Int {
	var VO_NONE = 0x0;
	var VO_LOW_MATERIAL_QUALITY = 0x1;
	var VO_DISABLE_SHADOWS = 0x2;
	var VO_DISABLE_OCCLUSION = 0x4;
}

class Camera extends Component {
	public var _abstract:AbstractCamera = null;

	public inline function new(?abs:AbstractCamera) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractCamera();

		super(AbstractCamera.CastToComponent(Context.context, _abstract));
	}

	public function GetScreenRay(x:Float, y:Float):TRay {
		return AbstractCamera.GetScreenRay(Context.context, _abstract, x, y);
	}

	public var farClip(get, set):Float;

	public function set_farClip(f) {
		AbstractCamera.SetFarclip(Context.context, _abstract, f);
		return f;
	}

	public function get_farClip() {
		return AbstractCamera.GetFarclip(Context.context, _abstract);
	}

	public var fov(get, set):Float;

	public function set_fov(f) {
		AbstractCamera.SetFOV(Context.context, _abstract, f);
		return f;
	}

	public function get_fov() {
		return AbstractCamera.GetFOV(Context.context, _abstract);
	}

	public var viewOverrideFlags(get, set):ViewOverride;

	function set_viewOverrideFlags(f) {
		AbstractCamera.SetViewOverrideFlags(Context.context,_abstract,f);
		return f;
	}

	function get_viewOverrideFlags() {
		return AbstractCamera.GetViewOverrideFlags(Context.context, _abstract);
	}
}

@:hlNative("Urho3D")
abstract AbstractCamera(HL_URHO3D_CAMERA) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toCamera():Camera {
		return new Camera(cast this);
	}

	@:hlNative("Urho3D", "_graphics_camera_create")
	private static function Create(c:Context):HL_URHO3D_CAMERA {
		return null;
	}

	//

	@:hlNative("Urho3D", "_graphics_camera_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractCamera {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_camera_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractCamera):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_camera_set_far_clip")
	public static function SetFarclip(c:Context, s:AbstractCamera, f:Single):Void {}

	@:hlNative("Urho3D", "_graphics_camera_get_far_clip")
	public static function GetFarclip(c:Context, s:AbstractCamera):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_camera_set_fov")
	public static function SetFOV(c:Context, s:AbstractCamera, f:Single):Void {}

	@:hlNative("Urho3D", "_graphics_camera_get_fov")
	public static function GetFOV(c:Context, s:AbstractCamera):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_camera_get_screen_ray")
	public static function GetScreenRay(c:Context, s:AbstractCamera, x:Single, y:Single):TRay {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_camera_set_view_override_flags")
	public static function SetViewOverrideFlags(c:Context, s:AbstractCamera, i:Int):Void {}

	@:hlNative("Urho3D", "_graphics_camera_get_view_override_flags")
	public static function GetViewOverrideFlags(c:Context, s:AbstractCamera):Int {
		return 0;
	}
}
