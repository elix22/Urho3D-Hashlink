package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_COLLISION_SHAPE = hl.Abstract<"hl_urho3d_physics_collision_shape">;

enum abstract ShapeType(Int) to Int from Int
{
    var SHAPE_BOX = 0;
    var SHAPE_SPHERE;
    var SHAPE_STATICPLANE;
    var SHAPE_CYLINDER;
    var SHAPE_CAPSULE;
    var SHAPE_CONE;
    var SHAPE_TRIANGLEMESH;
    var SHAPE_CONVEXHULL;
    var SHAPE_TERRAIN;
    var SHAPE_GIMPACTMESH;
}

class CollisionShape extends Component {
	private var _abstract:AbstractCollisionShape = null;

	public inline function new(?abs:AbstractCollisionShape) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractCollisionShape();

		super(AbstractCollisionShape.CastToComponent(Context.context, _abstract));
	}

	public inline function SetBox(size:TVector3, ?position:TVector3, ?rotation:TQuaternion) {
        if(position == null)position = new TVector3();
        if(rotation == null)rotation = new TQuaternion();
		AbstractCollisionShape.SetBox(Context.context, _abstract, size, position, rotation);
	}

	public inline function SetSphere(diameter:Float, ?position:TVector3, ?rotation:TQuaternion) {
        if(position == null)position = new TVector3();
        if(rotation == null)rotation = new TQuaternion();
		AbstractCollisionShape.SetSphere(Context.context, _abstract, diameter, position, rotation);
	}

	public inline function SetStaticPlane(?position:TVector3, ?rotation:TQuaternion) {
        if(position == null)position = new TVector3();
        if(rotation == null)rotation = new TQuaternion();
		AbstractCollisionShape.SetStaticPlane(Context.context, _abstract, position, rotation);
	}

	public inline function SetCylinder(diameter:Float,height:Float, ?position:TVector3, ?rotation:TQuaternion) {
        if(position == null)position = new TVector3();
        if(rotation == null)rotation = new TQuaternion();
		AbstractCollisionShape.SetCylinder(Context.context, _abstract, diameter,height, position, rotation);
	}

	public inline function SetCapsule(diameter:Float,height:Float, ?position:TVector3, ?rotation:TQuaternion) {
        if(position == null)position = new TVector3();
        if(rotation == null)rotation = new TQuaternion();
		AbstractCollisionShape.SetCapsule(Context.context, _abstract, diameter,height, position, rotation);
	}
}

@:hlNative("Urho3D")
abstract AbstractCollisionShape(HL_URHO3D_COLLISION_SHAPE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:hlNative("Urho3D", "_physics_collision_shape_create")
	private static function Create(context:Context):HL_URHO3D_COLLISION_SHAPE {
		return null;
	}

	@:hlNative("Urho3D", "_physics_collision_shape_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractCollisionShape {
		return null;
	}

	@:hlNative("Urho3D", "_physics_collision_shape_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractCollisionShape):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_physics_collision_shape_set_box")
	public static function SetBox(c:Context, s:AbstractCollisionShape, size:TVector3, position:TVector3, rotation:TQuaternion):Void {}


	@:hlNative("Urho3D", "_physics_collision_shape_set_sphere")
	public static function SetSphere(c:Context, s:AbstractCollisionShape, diameter:Single, position:TVector3, rotation:TQuaternion):Void {}

	@:hlNative("Urho3D", "_physics_collision_shape_set_static_plane")
	public static function SetStaticPlane(c:Context, s:AbstractCollisionShape, position:TVector3, rotation:TQuaternion):Void {}

	@:hlNative("Urho3D", "_physics_collision_shape_set_cylinder")
	public static function SetCylinder(c:Context, s:AbstractCollisionShape, diameter:Single, height:Single, position:TVector3, rotation:TQuaternion):Void {}

	@:hlNative("Urho3D", "_physics_collision_shape_set_capsule")
	public static function SetCapsule(c:Context, s:AbstractCollisionShape, diameter:Single, height:Single, position:TVector3, rotation:TQuaternion):Void {}
}
