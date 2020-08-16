package urho3d;

import urho3d.Component.AbstractComponent;
import urho3d.RigidBody.AbstractRigidBody;

typedef HL_URHO3D_CONSTRAINT = hl.Abstract<"hl_urho3d_physics_constraint">;

enum abstract ConstraintType(Int) from Int to Int {
	var CONSTRAINT_POINT = 0;
	var CONSTRAINT_HINGE;
	var CONSTRAINT_SLIDER;
	var CONSTRAINT_CONETWIST;
}

/*
	constraint.lowLimit = lowLimit;
 */
class Constraint extends Component {
	private var _abstract:AbstractConstraint = null;

	public inline function new(?abs:AbstractConstraint) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractConstraint();

		super(AbstractConstraint.CastToComponent(Context.context, _abstract));
	}

	public var constraintType(get, set):ConstraintType;

	function set_constraintType(t) {
		AbstractConstraint.SetConstraintType(Context.context, _abstract, t);
		return t;
	}

	function get_constraintType() {
		return AbstractConstraint.GetConstraintType(Context.context, _abstract);
    }
    
    public var disableCollision(get, set):Bool;

	function set_disableCollision(t) {
		AbstractConstraint.SetDisableCollision(Context.context, _abstract, t);
		return t;
	}

	function get_disableCollision() {
		return AbstractConstraint.GetDisableCollision(Context.context, _abstract);
    }
    
    public var otherBody(get, set):AbstractRigidBody;

	function set_otherBody(t) {
		AbstractConstraint.SetOtherBody(Context.context, _abstract, t);
		return t;
	}

	function get_otherBody() {
		return AbstractConstraint.GetOtherBody(Context.context, _abstract);
    }

    public var worldPosition(get, set):TVector3;

	function set_worldPosition(t) {
		AbstractConstraint.SetWorldPosition(Context.context, _abstract, t);
		return t;
	}

	function get_worldPosition() {
		return AbstractConstraint.GetWorldPosition(Context.context, _abstract);
    }

    public var axis(never, set):TVector3;

	function set_axis(t) {
		AbstractConstraint.SetAxis(Context.context, _abstract, t);
		return t;
    }
    
    public var otherAxis(never, set):TVector3;

	function set_otherAxis(t) {
		AbstractConstraint.SetOtherAxis(Context.context, _abstract, t);
		return t;
    }

    
    public var highLimit(get, set):TVector2;

	function set_highLimit(t) {
		AbstractConstraint.SetHighLimit(Context.context, _abstract, t);
		return t;
	}

	function get_highLimit() {
		return AbstractConstraint.GetHighLimit(Context.context, _abstract);
    }

    
    public var lowLimit(get, set):TVector2;

	function set_lowLimit(t) {
		AbstractConstraint.SetLowLimit(Context.context, _abstract, t);
		return t;
	}

	function get_lowLimit() {
		return AbstractConstraint.GetLowimit(Context.context, _abstract);
    }

}

@:hlNative("Urho3D")
abstract AbstractConstraint(HL_URHO3D_CONSTRAINT) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:hlNative("Urho3D", "_physics_constraint_create")
	private static function Create(context:Context):HL_URHO3D_CONSTRAINT {
		return null;
	}

	@:hlNative("Urho3D", "_physics_constraint_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractConstraint {
		return null;
	}

	@:hlNative("Urho3D", "_physics_constraint_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractConstraint):AbstractComponent {
		return null;
	}

	/*
		DEFINE_PRIM(_VOID, _physics_constraint_set_low_limit, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT HL_URHO3D_TVECTOR2);
		DEFINE_PRIM(HL_URHO3D_TVECTOR2, _physics_constraint_get_low_limit, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT );
	 */
	@:hlNative("Urho3D", "_physics_constraint_set_type")
	public static function SetConstraintType(c:Context, s:AbstractConstraint, type:Int):Void {}

	@:hlNative("Urho3D", "_physics_constraint_get_type")
	public static function GetConstraintType(c:Context, s:AbstractConstraint):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_physics_constraint_set_disable_collision")
	public static function SetDisableCollision(c:Context, s:AbstractConstraint, type:Bool):Void {}

	@:hlNative("Urho3D", "_physics_constraint_get_disable_collision")
	public static function GetDisableCollision(c:Context, s:AbstractConstraint):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_physics_constraint_set_other_body")
	public static function SetOtherBody(c:Context, s:AbstractConstraint, type:AbstractRigidBody):Void {}

	@:hlNative("Urho3D", "_physics_constraint_get_other_body")
	public static function GetOtherBody(c:Context, s:AbstractConstraint):AbstractRigidBody {
		return null;
	}

	@:hlNative("Urho3D", "_physics_constraint_set_world_position")
	public static function SetWorldPosition(c:Context, s:AbstractConstraint, type:TVector3):Void {}

	@:hlNative("Urho3D", "_physics_constraint_get_world_position")
	public static function GetWorldPosition(c:Context, s:AbstractConstraint):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_physics_constraint_set_axis")
	public static function SetAxis(c:Context, s:AbstractConstraint, type:TVector3):Void {}

	@:hlNative("Urho3D", "_physics_constraint_set_other_axis")
	public static function SetOtherAxis(c:Context, s:AbstractConstraint, type:TVector3):Void {}

	@:hlNative("Urho3D", "_physics_constraint_set_high_limit")
	public static function SetHighLimit(c:Context, s:AbstractConstraint, type:TVector2):Void {}

	@:hlNative("Urho3D", "_physics_constraint_get_high_limit")
	public static function GetHighLimit(c:Context, s:AbstractConstraint):TVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_physics_constraint_set_low_limit")
	public static function SetLowLimit(c:Context, s:AbstractConstraint, type:TVector2):Void {}

	@:hlNative("Urho3D", "_physics_constraint_get_low_limit")
	public static function GetLowimit(c:Context, s:AbstractConstraint):TVector2 {
		return null;
	}
}
