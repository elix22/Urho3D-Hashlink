package urho3d;

import urho3d.RigidBody.AbstractRigidBody;
import urho3d.RigidBody.CollisionEventMode;

typedef HL_URHO3D_T_RIGID_BODY = hl.Abstract<"hl_urho3d_physics_t_rigid_body">;


@:hlNative("Urho3D")
abstract TRigidBody(HL_URHO3D_T_RIGID_BODY) {


    public var mass(get, set):Float;

	function set_mass(m) {
		SetMass(Context.context, cast this, m);
		return m;
	}

	function get_mass() {
		return GetMass(Context.context, cast this);
    }

    public var friction(get, set):Float;

	function set_friction(m) {
		SetFriction(Context.context, cast this , m);
		return m;
	}

	function get_friction() {
		return GetFriction(Context.context, cast this );
	}

	//
	public var rollingFriction(get, set):Float;

	function set_rollingFriction(m) {
		SetRollingFriction(Context.context, cast this , m);
		return m;
	}

	function get_rollingFriction() {
		return GetRollingFriction(Context.context, cast this );
	}

	public var linearVelocity(get, set):TVector3;

	function set_linearVelocity(v) {
		SetLinearVelocity(Context.context, cast this , v);
		return v;
	}

	function get_linearVelocity() {
		return GetLinearVelocity(Context.context, cast this );
	}

	public var trigger(get, set):Bool;

	function set_trigger(m) {
		SetTrigger(Context.context, cast this , m);
		return m;
	}

	function get_trigger() {
		return GetTrigger(Context.context, cast this );
	}

	public var linearDamping(get, set):Float;

	function set_linearDamping(m) {
		SetLinearDamping(Context.context, cast this , m);
		return m;
	}

	function get_linearDamping() {
		return GetLinearDamping(Context.context, cast this );
	}

	public var angularDamping(get, set):Float;

	function set_angularDamping(m) {
		SetAngularDamping(Context.context, cast this , m);
		return m;
	}

	function get_angularDamping() {
		return GetAngularDamping(Context.context, cast this );
	}

	public var linearRestThreshold(get, set):Float;

	function set_linearRestThreshold(m) {
		SetLinearRestThreshold(Context.context, cast this , m);
		return m;
	}

	function get_linearRestThreshold() {
		return GetLinearRestThreshold(Context.context, cast this );
	}

	public var angularRestThreshold(get, set):Float;

	function set_angularRestThreshold(m) {
		SetAngularRestThreshold(Context.context, cast this , m);
		return m;
	}

	function get_angularRestThreshold() {
		return GetAngularRestThreshold(Context.context, cast this );
	}

	public var collisionLayer(get, set):Int;

	function set_collisionLayer(m) {
		SetCollisionLayer(Context.context, cast this , m);
		return m;
	}

	function get_collisionLayer() {
		return GetCollisionLayer(Context.context, cast this );
	}

	public var collisionMask(get, set):Int;

	function set_collisionMask(m) {
		SetCollisionMask(Context.context, cast this , m);
		return m;
	}

	function get_collisionMask() {
		return GetCollisionMask(Context.context, cast this );
	}

	public inline function ApplyImpulse(impulse:TVector3, ?position:TVector3) {
		if(position == null)position = new TVector3();
		_ApplyImpulse(Context.context, cast this , impulse, position);
	}

	public var angularFactor(get, set):TVector3;

	function set_angularFactor(v) {
		SetAngularFactor(Context.context, cast this , v);
		return v;
	}

	function get_angularFactor() {
		return GetAngularFactor(Context.context, cast this );
	}

	//
	public var collisionEventMode(get, set):CollisionEventMode;

	function set_collisionEventMode(m) {
		SetCollisionEventMode(Context.context, cast this , m);
		return m;
	}

	function get_collisionEventMode() {
		return GetCollisionEventMode(Context.context, cast this );
	}
    
	@:hlNative("Urho3D", "_physics_t_rigid_body_cast_from_rigid_body")
	public static function CastFromRigidBody(c:Context, s:AbstractRigidBody):TRigidBody {
		return null;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_cast_to_rigid_body")
	public static function CastToRigidBody(c:Context, s:TRigidBody):AbstractRigidBody {
		return null;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_mass")
	public static function SetMass(c:Context, s:TRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_mass")
	public static function GetMass(c:Context, s:TRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_friction")
	public static function SetFriction(c:Context, s:TRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_friction")
	public static function GetFriction(c:Context, s:TRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_rolling_friction")
	public static function SetRollingFriction(c:Context, s:TRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_rolling_friction")
	public static function GetRollingFriction(c:Context, s:TRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_linear_velocity")
	public static function SetLinearVelocity(c:Context, s:TRigidBody, v:TVector3):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_linear_velocity")
	public static function GetLinearVelocity(c:Context, s:TRigidBody):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_trigger")
	public static function SetTrigger(c:Context, s:TRigidBody, m:Bool):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_trigger")
	public static function GetTrigger(c:Context, s:TRigidBody):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_linear_dumping")
	public static function SetLinearDamping(c:Context, s:TRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_linear_dumping")
	public static function GetLinearDamping(c:Context, s:TRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_linear_rest_threshold")
	public static function SetLinearRestThreshold(c:Context, s:TRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_linear_rest_threshold")
	public static function GetLinearRestThreshold(c:Context, s:TRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_angular_dumping")
	public static function SetAngularDamping(c:Context, s:TRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_linear_dumping")
	public static function GetAngularDamping(c:Context, s:TRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_angular_rest_threshold")
	public static function SetAngularRestThreshold(c:Context, s:TRigidBody, m:Single):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_angular_rest_threshold")
	public static function GetAngularRestThreshold(c:Context, s:TRigidBody):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_collision_layer")
	public static function SetCollisionLayer(c:Context, s:TRigidBody, m:Int):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_collision_layer")
	public static function GetCollisionLayer(c:Context, s:TRigidBody):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_set_collision_mask")
	public static function SetCollisionMask(c:Context, s:TRigidBody, m:Int):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_collision_mask")
	public static function GetCollisionMask(c:Context, s:TRigidBody):Int {
		return 0;
	}


	@:hlNative("Urho3D", "_physics_t_rigid_body_set_angular_factor")
	public static function SetAngularFactor(c:Context, s:TRigidBody, v:TVector3):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_angular_factor")
	public static function GetAngularFactor(c:Context, s:TRigidBody):TVector3 {
		return null;
	}


	@:hlNative("Urho3D", "_physics_t_rigid_body_set_collision_event_mode")
	public static function SetCollisionEventMode(c:Context, s:TRigidBody, m:Int):Void {}

	@:hlNative("Urho3D", "_physics_t_rigid_body_get_collision_event_mode")
	public static function GetCollisionEventMode(c:Context, s:TRigidBody):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_physics_t_rigid_body_apply_impulse")
	public static function _ApplyImpulse(c:Context, s:TRigidBody, impulse:TVector3, position:TVector3):Void {}
}