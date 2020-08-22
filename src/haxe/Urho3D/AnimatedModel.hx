package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_ANIMATEDMODEL = hl.Abstract<"hl_urho3d_graphics_animatedmodel">;

class AnimatedModel extends Component {
	public var _abstract:AbstractAnimatedModel = null;

	public inline function new(?abs:AbstractAnimatedModel) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractAnimatedModel();

		super(AbstractAnimatedModel.CastToComponent(Context.context, _abstract));
	}

	public var model(get, set):Model;
	public var material(get, set):Material;
	public var castShadows(get, set):Bool;
	public var occluder(get, set):Bool;
	public var occludee(get, set):Bool;
	public var updateInvisible(get, set):Bool;

	function set_updateInvisible(b) {
		AbstractAnimatedModel.SetUpdateInvisible(Context.context, _abstract, b);
		return b;
	}

	function get_updateInvisible() {
		return AbstractAnimatedModel.GetUpdateInvisible(Context.context, _abstract);
	}

	function set_occluder(m) {
		AbstractAnimatedModel.SetOccluder(Context.context, _abstract, m);
		return m;
	}

	function get_occluder() {
		return AbstractAnimatedModel.GetOccluder(Context.context, _abstract);
	}

	function set_occludee(m) {
		AbstractAnimatedModel.SetOccludee(Context.context, _abstract, m);
		return m;
	}

	function get_occludee() {
		return AbstractAnimatedModel.GetOccludee(Context.context, _abstract);
	}

	function set_model(m) {
		AbstractAnimatedModel.SetModel(Context.context, _abstract, m);
		return m;
	}

	function get_model() {
		return AbstractAnimatedModel.GetModel(Context.context, _abstract);
	}

	function set_material(m) {
		AbstractAnimatedModel.SetMaterial(Context.context, _abstract, m);
		return m;
	}

	function get_material() {
		return AbstractAnimatedModel.GetMaterial(Context.context, _abstract);
	}

	function set_castShadows(c) {
		AbstractAnimatedModel.SetCastShadows(Context.context, _abstract, c);
		return c;
	}

	function get_castShadows() {
		return AbstractAnimatedModel.GetCastShadows(Context.context, _abstract);
	}

	public function AddAnimationState(animation:Animation):AnimationState {
		return AbstractAnimatedModel.AddAnimationState(Context.context, _abstract, animation);
	}

	public function GetAnimationState(i:Int):AnimationState {
		return AbstractAnimatedModel.GetAnimationState(Context.context, _abstract, i);
	}

	public var skeleton(get,never):Skeleton;

	public function get_skeleton():Skeleton {
		return AbstractAnimatedModel.GetSkeleton(Context.context, _abstract);
	}
}

@:hlNative("Urho3D")
abstract AbstractAnimatedModel(HL_URHO3D_ANIMATEDMODEL) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toAnimatedModel():AnimatedModel {
		return new AnimatedModel(cast this);
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_create")
	private static function Create(c:Context):HL_URHO3D_ANIMATEDMODEL {
		return null;
	}

	//

	@:hlNative("Urho3D", "_graphics_animatedmodel_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractAnimatedModel {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractAnimatedModel):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_set_model")
	public static function SetModel(c:Context, s:AbstractAnimatedModel, m:Model):Void {}

	@:hlNative("Urho3D", "_graphics_animatedmodel_get_model")
	public static function GetModel(c:Context, s:AbstractAnimatedModel):Model {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_set_material")
	public static function SetMaterial(c:Context, s:AbstractAnimatedModel, m:Material):Void {}

	@:hlNative("Urho3D", "_graphics_animatedmodel_get_material")
	public static function GetMaterial(c:Context, s:AbstractAnimatedModel):Material {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_add_animation_state")
	public static function AddAnimationState(c:Context, s:AbstractAnimatedModel, a:Animation):AnimationState {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_get_animation_state")
	public static function GetAnimationState(c:Context, s:AbstractAnimatedModel, i:Int):AnimationState {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_set_cast_shadows")
	public static function SetCastShadows(c:Context, s:AbstractAnimatedModel, m:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_animatedmodel_get_cast_shadows")
	public static function GetCastShadows(c:Context, s:AbstractAnimatedModel):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_set_occluder")
	public static function SetOccluder(c:Context, s:AbstractAnimatedModel, m:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_animatedmodel_get_occluder")
	public static function GetOccluder(c:Context, s:AbstractAnimatedModel):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_set_occludee")
	public static function SetOccludee(c:Context, s:AbstractAnimatedModel, m:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_animatedmodel_get_occludee")
	public static function GetOccludee(c:Context, s:AbstractAnimatedModel):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_set_update_invisible")
	public static function SetUpdateInvisible(c:Context, s:AbstractAnimatedModel, m:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_animatedmodel_get_update_invisible")
	public static function GetUpdateInvisible(c:Context, s:AbstractAnimatedModel):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_animatedmodel_get_skeleton")
	public static function GetSkeleton(c:Context, s:AbstractAnimatedModel):Skeleton {
		return null;
	}
}
