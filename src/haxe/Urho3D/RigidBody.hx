package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_RIGID_BODY = hl.Abstract<"hl_urho3d_physics_rigid_body">;

enum abstract CollisionEventMode(Int) from Int to Int
{
    var COLLISION_NEVER = 0;
    var COLLISION_ACTIVE;
    var COLLISION_ALWAYS;
}

class RigidBody extends Component {
	private var _abstract:AbstractRigidBody = null;

	public inline function new(?abs:AbstractRigidBody) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractRigidBody();

		super(AbstractRigidBody.CastToComponent(Context.context, _abstract));
	}

	public var mass(get, set):Float;

	function set_mass(m) {
		AbstractRigidBody.SetMass(Context.context, _abstract, m);
		return m;
	}

	function get_mass() {
		return AbstractRigidBody.GetMass(Context.context, _abstract);
	}

	public var friction(get, set):Float;

	function set_friction(m) {
		AbstractRigidBody.SetFriction(Context.context, _abstract, m);
		return m;
	}

	function get_friction() {
		return AbstractRigidBody.GetFriction(Context.context, _abstract);
	}

	//
	public var rollingFriction(get, set):Float;

	function set_rollingFriction(m) {
		AbstractRigidBody.SetRollingFriction(Context.context, _abstract, m);
		return m;
	}

	function get_rollingFriction() {
		return AbstractRigidBody.GetRollingFriction(Context.context, _abstract);
	}

	public var linearVelocity(get, set):TVector3;

	function set_linearVelocity(v) {
		AbstractRigidBody.SetLinearVelocity(Context.context, _abstract, v);
		return v;
	}

	function get_linearVelocity() {
		return AbstractRigidBody.GetLinearVelocity(Context.context, _abstract);
	}

	public var trigger(get, set):Bool;

	function set_trigger(m) {
		AbstractRigidBody.SetTrigger(Context.context, _abstract, m);
		return m;
	}

	function get_trigger() {
		return AbstractRigidBody.GetTrigger(Context.context, _abstract);
	}

	public var linearDamping(get, set):Float;

	function set_linearDamping(m) {
		AbstractRigidBody.SetLinearDamping(Context.context, _abstract, m);
		return m;
	}

	function get_linearDamping() {
		return AbstractRigidBody.GetLinearDamping(Context.context, _abstract);
	}

	public var angularDamping(get, set):Float;

	function set_angularDamping(m) {
		AbstractRigidBody.SetAngularDamping(Context.context, _abstract, m);
		return m;
	}

	function get_angularDamping() {
		return AbstractRigidBody.GetAngularDamping(Context.context, _abstract);
	}

	public var linearRestThreshold(get, set):Float;

	function set_linearRestThreshold(m) {
		AbstractRigidBody.SetLinearRestThreshold(Context.context, _abstract, m);
		return m;
	}

	function get_linearRestThreshold() {
		return AbstractRigidBody.GetLinearRestThreshold(Context.context, _abstract);
	}

	public var angularRestThreshold(get, set):Float;

	function set_angularRestThreshold(m) {
		AbstractRigidBody.SetAngularRestThreshold(Context.context, _abstract, m);
		return m;
	}

	function get_angularRestThreshold() {
		return AbstractRigidBody.GetAngularRestThreshold(Context.context, _abstract);
	}

	public var collisionLayer(get, set):Int;

	function set_collisionLayer(m) {
		AbstractRigidBody.SetCollisionLayer(Context.context, _abstract, m);
		return m;
	}

	function get_collisionLayer() {
		return AbstractRigidBody.GetCollisionLayer(Context.context, _abstract);
	}

	public var collisionMask(get, set):Int;

	function set_collisionMask(m) {
		AbstractRigidBody.SetCollisionMask(Context.context, _abstract, m);
		return m;
	}

	function get_collisionMask() {
		return AbstractRigidBody.GetCollisionMask(Context.context, _abstract);
	}

	public inline function ApplyImpulse(impulse:TVector3, ?position:TVector3) {
		if(position == null)position = new TVector3();
		AbstractRigidBody.ApplyImpulse(Context.context, _abstract, impulse, position);
	}

	public var angularFactor(get, set):TVector3;

	function set_angularFactor(v) {
		AbstractRigidBody.SetAngularFactor(Context.context, _abstract, v);
		return v;
	}

	function get_angularFactor() {
		return AbstractRigidBody.GetAngularFactor(Context.context, _abstract);
	}

	//
	public var collisionEventMode(get, set):CollisionEventMode;

	function set_collisionEventMode(m) {
		AbstractRigidBody.SetCollisionEventMode(Context.context, _abstract, m);
		return m;
	}

	function get_collisionEventMode() {
		return AbstractRigidBody.GetCollisionEventMode(Context.context, _abstract);
	}

	public var kinematic(get, set):Bool;

	function get_kinematic() {
		return AbstractRigidBody._GetKinematic(Context.context, _abstract);
	}

	function set_kinematic(k) {
		AbstractRigidBody._SetKinematic(Context.context, _abstract, k);
		return k;
	}
}

@:hlNative("Urho3D")
abstract AbstractRigidBody(HL_URHO3D_RIGID_BODY) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:hlNative("Urho3D", "_physics_rigid_body_create")
	private static function Create(context:Context):HL_URHO3D_RIGID_BODY {
		return null;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractRigidBody {
		return null;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractRigidBody):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_mass")
	public static function SetMass(c:Context, s:AbstractRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_mass")
	public static function GetMass(c:Context, s:AbstractRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_friction")
	public static function SetFriction(c:Context, s:AbstractRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_friction")
	public static function GetFriction(c:Context, s:AbstractRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_rolling_friction")
	public static function SetRollingFriction(c:Context, s:AbstractRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_rolling_friction")
	public static function GetRollingFriction(c:Context, s:AbstractRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_linear_velocity")
	public static function SetLinearVelocity(c:Context, s:AbstractRigidBody, v:TVector3):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_linear_velocity")
	public static function GetLinearVelocity(c:Context, s:AbstractRigidBody):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_trigger")
	public static function SetTrigger(c:Context, s:AbstractRigidBody, m:Bool):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_trigger")
	public static function GetTrigger(c:Context, s:AbstractRigidBody):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_linear_dumping")
	public static function SetLinearDamping(c:Context, s:AbstractRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_linear_dumping")
	public static function GetLinearDamping(c:Context, s:AbstractRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_linear_rest_threshold")
	public static function SetLinearRestThreshold(c:Context, s:AbstractRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_linear_rest_threshold")
	public static function GetLinearRestThreshold(c:Context, s:AbstractRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_angular_dumping")
	public static function SetAngularDamping(c:Context, s:AbstractRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_linear_dumping")
	public static function GetAngularDamping(c:Context, s:AbstractRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_angular_rest_threshold")
	public static function SetAngularRestThreshold(c:Context, s:AbstractRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_angular_rest_threshold")
	public static function GetAngularRestThreshold(c:Context, s:AbstractRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_collision_layer")
	public static function SetCollisionLayer(c:Context, s:AbstractRigidBody, m:Int):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_collision_layer")
	public static function GetCollisionLayer(c:Context, s:AbstractRigidBody):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_set_collision_mask")
	public static function SetCollisionMask(c:Context, s:AbstractRigidBody, m:Int):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_collision_mask")
	public static function GetCollisionMask(c:Context, s:AbstractRigidBody):Int {
		return 0;
	}


	@:hlNative("Urho3D", "_physics_rigid_body_set_angular_factor")
	public static function SetAngularFactor(c:Context, s:AbstractRigidBody, v:TVector3):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_angular_factor")
	public static function GetAngularFactor(c:Context, s:AbstractRigidBody):TVector3 {
		return null;
	}


	@:hlNative("Urho3D", "_physics_rigid_body_set_collision_event_mode")
	public static function SetCollisionEventMode(c:Context, s:AbstractRigidBody, m:Int):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_collision_event_mode")
	public static function GetCollisionEventMode(c:Context, s:AbstractRigidBody):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_physics_rigid_body_apply_impulse")
	public static function ApplyImpulse(c:Context, s:AbstractRigidBody, impulse:TVector3, position:TVector3):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_set_kinematic")
	public static function _SetKinematic(c:Context, s:AbstractRigidBody, m:Bool):Void {}

	@:hlNative("Urho3D", "_physics_rigid_body_get_kinematic")
	public static function _GetKinematic(c:Context, s:AbstractRigidBody):Bool {
		return false;
	}
}
