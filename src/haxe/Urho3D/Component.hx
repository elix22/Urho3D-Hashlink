package urho3d;

import urho3d.StaticModel.AbstractStaticModel;
import urho3d.Node.AbstractNode;
import urho3d.Zone.AbstractZone;
import urho3d.Camera.AbstractCamera;
import urho3d.Light.AbstractLight;
import urho3d.AnimatedModel.AbstractAnimatedModel;
import urho3d.BillboardSet.AbstractBillboardSet;
import urho3d.DecalSet.AbstractDecalSet;
import urho3d.RigidBody.AbstractRigidBody;
import urho3d.CollisionShape.AbstractCollisionShape;
import urho3d.Skybox.AbstractSkybox;
import urho3d.Constraint.AbstractConstraint;
import urho3d.AnimationController.AbstractAnimationController;
import urho3d.LogicComponent.AbstractLogicComponent;
import urho3d.PhysicsWorld;

typedef HL_URHO3D_COMPONENT = hl.Abstract<"hl_urho3d_scene_component">;
typedef URHO3D_COMPONENT_PTR = hl.Abstract<"hl_urho3d_scene_component_ptr">;

class Component {
	private var _node:Node = null;

	public var node(get, set):Node;
	public var abstractComponent:AbstractComponent = null;

	public inline function new(?absComponent:AbstractComponent) {
		if (absComponent != null)
			abstractComponent = absComponent;
		else
			abstractComponent = new AbstractComponent();

		if (node != null) {
			node.bindComponent(this);
		}
	}

	public var pointer(get, never):URHO3D_COMPONENT_PTR;

	function get_pointer() {
		return AbstractComponent.GetComponentPointer(Context.context, abstractComponent);
	}

	public function SubscribeToEvent(?object:Object, stringHash:StringHash, s:String) {
		if (abstractComponent != null) {
			abstractComponent.SubscribeToEvent(object, stringHash, this, s);
		}
	}

	function get_node() {
		if (_node == null) {
			_node = new Node(AbstractComponent.GetNode(Context.context, abstractComponent));
		}
		return _node;
	}

	public function set_node(n) {
		_node = n;
		return _node;
	}

	@:to
	public inline function toZone():Zone {
		if (this != null) {
			var abstractZone:AbstractZone = AbstractZone.CastFromComponent(Context.context, abstractComponent);
			return new Zone(abstractZone);
		} else {
			return null;
		}
	}

	@:to
	public inline function toStaticModel():StaticModel {
		if (this != null) {
			var abstract_ = AbstractStaticModel.CastFromComponent(Context.context, abstractComponent);
			return new StaticModel(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toAnimatedModel():AnimatedModel {
		if (this != null) {
			var abstract_ = AbstractAnimatedModel.CastFromComponent(Context.context, abstractComponent);
			return new AnimatedModel(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toCamera():Camera {
		if (this != null) {
			var abstract_ = AbstractCamera.CastFromComponent(Context.context, abstractComponent);
			return new Camera(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toLight():Light {
		if (this != null) {
			var abstract_ = AbstractLight.CastFromComponent(Context.context, abstractComponent);
			return new Light(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toBillboardset():BillboardSet {
		if (this != null) {
			var abstract_ = AbstractBillboardSet.CastFromComponent(Context.context, abstractComponent);
			return new BillboardSet(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toDecalset():DecalSet {
		if (this != null) {
			var abstract_ = AbstractDecalSet.CastFromComponent(Context.context, abstractComponent);
			if (abstract_ != null)
				return new DecalSet(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toRigidBody():RigidBody {
		if (this != null) {
			var abstract_ = AbstractRigidBody.CastFromComponent(Context.context, abstractComponent);
			if (abstract_ != null)
				return new RigidBody(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toCollisionShape():CollisionShape {
		if (this != null) {
			var abstract_ = AbstractCollisionShape.CastFromComponent(Context.context, abstractComponent);
			if (abstract_ != null)
				return new CollisionShape(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toSkybox():Skybox {
		if (this != null) {
			var abstract_ = AbstractSkybox.CastFromComponent(Context.context, abstractComponent);
			if (abstract_ != null)
				return new Skybox(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toAnimationController():AnimationController {
		if (this != null) {
			var abstract_ = AbstractAnimationController.CastFromComponent(Context.context, abstractComponent);
			if (abstract_ != null)
				return new AnimationController(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toLogicComponent():LogicComponent {
		if (this != null) {
			var abstract_ = AbstractLogicComponent.CastFromComponent(Context.context, abstractComponent);
			if (abstract_ != null)
				return new LogicComponent(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}
}

@:hlNative("Urho3D")
abstract AbstractComponent(HL_URHO3D_COMPONENT) from Dynamic {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toComponent():Component {
		if (this != null) {
			return new Component(cast this);
		} else {
			return null;
		}
	}

	@:to
	public inline function toZone():Zone {
		if (this != null) {
			var abstractZone:AbstractZone = AbstractZone.CastFromComponent(Context.context, cast this);
			return new Zone(abstractZone);
		} else {
			return null;
		}
	}

	@:to
	public inline function toStaticModel():StaticModel {
		if (this != null) {
			var abstract_ = AbstractStaticModel.CastFromComponent(Context.context, cast this);
			return new StaticModel(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toAnimatedModel():AnimatedModel {
		if (this != null) {
			var abstract_ = AbstractAnimatedModel.CastFromComponent(Context.context, cast this);
			return new AnimatedModel(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toCamera():Camera {
		if (this != null) {
			var abstract_ = AbstractCamera.CastFromComponent(Context.context, cast this);
			return new Camera(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toLight():Light {
		if (this != null) {
			var abstract_ = AbstractLight.CastFromComponent(Context.context, cast this);
			return new Light(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toBillboardset():BillboardSet {
		if (this != null) {
			var abstract_ = AbstractBillboardSet.CastFromComponent(Context.context, cast this);
			return new BillboardSet(abstract_);
		} else {
			return null;
		}
	}

	@:to
	public inline function toDecalset():DecalSet {
		if (this != null) {
			var abstract_ = AbstractDecalSet.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return new DecalSet(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toRigidBody():RigidBody {
		if (this != null) {
			var abstract_ = AbstractRigidBody.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return new RigidBody(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toAbstractRigidBody():AbstractRigidBody {
		if (this != null) {
			var abstract_ = AbstractRigidBody.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return abstract_;
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toCollisionShape():CollisionShape {
		if (this != null) {
			var abstract_ = AbstractCollisionShape.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return new CollisionShape(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toConstraint():Constraint {
		if (this != null) {
			var abstract_ = AbstractConstraint.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return new Constraint(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toAbstractConstraint():AbstractConstraint {
		if (this != null) {
			var abstract_ = AbstractConstraint.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return abstract_;
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toSkybox():Skybox {
		if (this != null) {
			var abstract_ = AbstractSkybox.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return new Skybox(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toAnimationController():AnimationController {
		if (this != null) {
			var abstract_ = AbstractAnimationController.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return new AnimationController(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toLogicComponent():LogicComponent {
		if (this != null) {
			var abstract_ = AbstractLogicComponent.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return new LogicComponent(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	@:to
	public inline function toAbstractLogicComponent():AbstractLogicComponent {
		if (this != null) {
			return AbstractLogicComponent.CastFromComponent(Context.context, cast this);
		} else {
			return null;
		}
	}


	@:keep
	public function SubscribeToEvent(?object:Object, stringHash:StringHash, d:Dynamic, s:String) {
		if (object != null) {
			_SubscribeToEventSender(Context.context, object, cast this, stringHash, d, s);
		} else {
			_SubscribeToEvent(Context.context, cast this, stringHash, d, s);
		}
	}

	@:hlNative("Urho3D", "_scene_component_create")
	private static function Create(c:Context):HL_URHO3D_COMPONENT {
		return null;
	}

	@:hlNative("Urho3D", "_scene_component_get_node")
	public static function GetNode(c:Context, d:AbstractComponent):AbstractNode {
		return null;
	}

	// DEFINE_PRIM(_VOID, _scene_component_subscribe_to_event, URHO3D_CONTEXT HL_URHO3D_COMPONENT HL_URHO3D_STRINGHASH _DYN _STRING);

	@:hlNative("Urho3D", "_scene_component_subscribe_to_event")
	private static function _SubscribeToEvent(c:Context, comp:AbstractComponent, tringHash:StringHash, d:Dynamic, s:String):Void {}

	@:hlNative("Urho3D", "_scene_component_subscribe_to_event_sender")
	private static function _SubscribeToEventSender(c:Context, o:Object, comp:AbstractComponent, tringHash:StringHash, d:Dynamic, s:String):Void {}

	@:hlNative("Urho3D", "_scene_component_get_component_pointer")
	public static function GetComponentPointer(c:Context, d:AbstractComponent):URHO3D_COMPONENT_PTR {
		return null;
	}
}
