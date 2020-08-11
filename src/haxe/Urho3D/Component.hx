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

typedef HL_URHO3D_COMPONENT = hl.Abstract<"hl_urho3d_scene_component">;

class Component {
	private var _node:Node = null;

	public var node(get, set):Node;
	public var abstractComponent:AbstractComponent = null;

	public inline function new(?absComponent:AbstractComponent) {
		if (absComponent != null)
			abstractComponent = absComponent;
		else
			abstractComponent = new AbstractComponent();

		node.bindComponent(this);
	}

	function get_node() {
		if (_node == null) {
			_node = new Node(AbstractComponent.GetNode(Context.context, abstractComponent));
		}
		return _node;
	}

	function set_node(n) {
		_node = n;
		return _node;
	}
}

@:hlNative("Urho3D")
abstract AbstractComponent(HL_URHO3D_COMPONENT) {
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

	@:hlNative("Urho3D", "_scene_component_create")
	private static function Create(c:Context):HL_URHO3D_COMPONENT {
		return null;
	}

	@:hlNative("Urho3D", "_scene_component_get_node")
	public static function GetNode(c:Context, d:AbstractComponent):AbstractNode {
		return null;
	}

	//
}
