package urho3d;

import urho3d.ParticleEmitter2D.AbstractParticleEmitter2D;
import urho3d.Scene.AbstractScene;
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
import urho3d.SoundSource.AbstractSoundSource;

typedef HL_URHO3D_COMPONENT = hl.Abstract<"hl_urho3d_scene_component">;
typedef URHO3D_COMPONENT_PTR = hl.Abstract<"hl_urho3d_scene_component_ptr">;

enum abstract AutoRemoveMode(Int) to Int from Int {
	var REMOVE_DISABLED = 0;
	var REMOVE_COMPONENT;
	var REMOVE_NODE;
}

class Component {
	private var _node:Node = null;
	private var _scene:Scene = null;

	public var node(get, set):Node;
	public var scene(get, never):Scene;

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

	@:keep
	@:final
	public function Invoke(f:String, args:Array<Dynamic>) {
		try {
			var fn = Reflect.field(this, f);
			if (fn != null) {
				Reflect.callMethod(this, fn, args);
			}
		} catch (e) {}
	}

	@:keep
	@:final
	public function InvokeDelayed(delay:Float = 0.0, repeat:Bool = false, func:String, args:Array<Dynamic>) {
		Application.application.InvokeDelayedObject(delay, repeat, this, func, args);
	}

	@:keep
	@:final
	public function InvokeObject(obj:Dynamic, f:String, args:Array<Dynamic>) {
		try {
			var fn = Reflect.field(obj, f);
			if (fn != null) {
				Reflect.callMethod(obj, fn, args);
			}
		} catch (e) {}
	}

	@:keep
	@:final
	public function InvokeDelayedObject(delay:Float = 0.0, repeat:Bool = false, obj:Dynamic, func:String, args:Array<Dynamic>) {
		Application.application.InvokeDelayedObject(delay, repeat, obj, func, args);
	}

	public function ClearInvokeDelayed(declaration:String = "") {
		Application.application.ClearInvokeDelayedObject(this, declaration);
	}

	public function ClearInvokeDelayedObject(obj:Dynamic, declaration:String = "") {
		Application.application.ClearInvokeDelayedObject(obj, declaration);
	}

	public var enabled(get, set):Bool;

	function get_enabled() {
		return AbstractComponent.GetEnabled(Context.context, abstractComponent);
	}

	function set_enabled(e) {
		AbstractComponent.SetEnabled(Context.context, abstractComponent, e);
		return e;
	}

	function get_scene() {
		if (_scene == null) {
			_scene = new Scene(AbstractComponent.GetScene(Context.context, abstractComponent));
		}
		return _scene;
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

	@:to
	public inline function toSoundSource():SoundSource {
		if (this != null) {
			var abstract_ = AbstractSoundSource.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return new SoundSource(abstract_);
			else
				return null;
		} else {
			return null;
		}
	}

	// ParticleEmitter2D

	@:to
	public inline function toParticleEmitter2D():ParticleEmitter2D {
		if (this != null) {
			var abstract_ = AbstractParticleEmitter2D.CastFromComponent(Context.context, cast this);
			if (abstract_ != null)
				return new ParticleEmitter2D(abstract_);
			else
				return null;
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

	@:hlNative("Urho3D", "_scene_component_get_scene")
	public static function GetScene(c:Context, d:AbstractComponent):AbstractScene {
		return null;
	}

	@:hlNative("Urho3D", "_scene_component_subscribe_to_event")
	private static function _SubscribeToEvent(c:Context, comp:AbstractComponent, tringHash:StringHash, d:Dynamic, s:String):Void {}

	@:hlNative("Urho3D", "_scene_component_subscribe_to_event_sender")
	private static function _SubscribeToEventSender(c:Context, o:Object, comp:AbstractComponent, tringHash:StringHash, d:Dynamic, s:String):Void {}

	@:hlNative("Urho3D", "_scene_component_get_component_pointer")
	public static function GetComponentPointer(c:Context, d:AbstractComponent):URHO3D_COMPONENT_PTR {
		return null;
	}

	@:hlNative("Urho3D", "_scene_component_set_enabled")
	public static function SetEnabled(c:Context, d:AbstractComponent, b:Bool):Void {}

	@:hlNative("Urho3D", "_scene_component_get_enabled")
	public static function GetEnabled(c:Context, d:AbstractComponent):Bool {
		return false;
	}
}
