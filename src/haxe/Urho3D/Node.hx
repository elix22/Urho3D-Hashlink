package urho3d;

import hl.Abstract;
import urho3d.AbstractApplication.Dyn;
import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_NODE = hl.Abstract<"hl_urho3d_scene_node">;

typedef HL_URHO3D_POD_NODE = hl.Abstract<"hl_urho3d_scene_pod_node">;
@:hlNative("Urho3D")
abstract PodNode(HL_URHO3D_POD_NODE) {}

@:enum abstract CreateMode(Int) {
	var REPLICATED = 0;
	var LOCAL = 1;
}

/// Transform space for translations and rotations.
@:enum abstract TransformSpace(Int) {
	var TS_LOCAL = 0;
	var TS_PARENT = 1;
	var TS_WORLD = 2;
}

class Node {
	private var children = [];
	private var components = [];

	private var abstractNode:AbstractNode = null;

	public var position(get, set):TVector3;
	public var direction(get, set):TVector3;
	public var scale(get, set):TVector3;
	public var rotation(get, set):TQuaternion;

	public inline function new(?rhs:AbstractNode) {
		if (rhs != null) {
			abstractNode = rhs;
		} else {
			abstractNode = new AbstractNode();
		}

		if (Scene.currentScene != null)
			Scene.currentScene.nodes.push(this);
	}

	public function bindComponent(component:Component) {
		//	trace ("bindComponent :" + component);
		components.push(component);
		component.node = this;
	}

	public function CreateChild(name:String = "", mode:CreateMode = CreateMode.REPLICATED, id:Int = 0, temporary:Bool = false):Node {
		var absNode:AbstractNode = AbstractNode.CreatChild(Context.context, abstractNode, name, mode, id, temporary);
		var node:Node = new Node(absNode);
		this.children.push(node);
		return node;
	}

	public function CreateComponent(type:String, mode:CreateMode = CreateMode.REPLICATED, id:Int = 0) {
		var absComp:AbstractComponent = AbstractNode.CreateComponent(Context.context, abstractNode, type, mode, id);
		return absComp;
	}

	public function GetComponent(type:String, recursive:Bool = false) {
		return AbstractNode.GetComponent(Context.context, abstractNode, type, recursive);
	}

	public function AddComponent(component:Component, id:Int = 0, mode:CreateMode = CreateMode.REPLICATED) {
		// component.node = this;
		bindComponent(component);
		AbstractNode.AddComponent(Context.context, abstractNode, component.abstractComponent, mode, id);
	}

	private function get_position() {
		return AbstractNode.GetPosition(Context.context, abstractNode);
	}

	private function set_position(p) {
		AbstractNode.SetPosition(Context.context, abstractNode, p);
		return p;
	}

	private function get_direction() {
		return AbstractNode.GetDirection(Context.context, abstractNode);
	}

	private function set_direction(p) {
		AbstractNode.SetDirection(Context.context, abstractNode, p);
		return p;
	}

	private function get_scale() {
		return AbstractNode.GetSCale(Context.context, abstractNode);
	}

	private function set_scale(p) {
		AbstractNode.SetScale(Context.context, abstractNode, p);
		return p;
	}

	private function get_rotation() {
		return AbstractNode.GetRotation(Context.context, abstractNode);
	}

	private function set_rotation(r) {
		AbstractNode.SetRotation(Context.context, abstractNode, r);
		return r;
	}

	public function Rotate(q:TQuaternion, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Rotate(Context.context, abstractNode, q, s);
	}

	public function RotateEuler(x:Float, y:Float, z:Float, s:TransformSpace = TS_LOCAL) {
		AbstractNode.RotateEuler(Context.context, abstractNode, x, y, z, s);
	}

	public function Translate(delta:TVector3, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Translate(Context.context, abstractNode, delta, s);
	}

	public function Yaw(a:Float, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Yaw(Context.context, abstractNode, a, s);
	}

	public function Pitch(a:Float, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Pitch(Context.context, abstractNode, a, s);
	}

	public function Roll(a:Float, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Roll(Context.context, abstractNode, a, s);
	}

	public function GetChildrenWithComponent(s:TStringHash, b:Bool = false):Array<Node> {
		var abs_node_array = AbstractNode.GetChildrenWithComponent(Context.context, abstractNode, s, b);
		var node_array:Array<Node> = new Array<Node>();

		var vectorSize = AbstractNode.GetPodVectorSize(Context.context, abs_node_array);

		for (i in 0...vectorSize) {
			var absNode = AbstractNode.GetNodeFromPodVector(Context.context, abs_node_array, i);
			node_array.push(new Node(absNode));
		}
		return node_array;
	}
}



@:hlNative("Urho3D")
abstract AbstractNode(HL_URHO3D_NODE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toNode():Node {
		return new Node(cast this);
	}

	@:hlNative("Urho3D", "_scene_node_create")
	public static function Create(c:Context):HL_URHO3D_NODE {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_create_child")
	public static function CreatChild(c:Context, n:AbstractNode, name:String, mode:CreateMode, id:Int, temporary:Bool):AbstractNode {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_create_component")
	public static function CreateComponent(c:Context, n:AbstractNode, name:String, mode:CreateMode, id:Int):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_get_component")
	public static function GetComponent(c:Context, n:AbstractNode, name:String, recursive:Bool):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_add_component")
	public static function AddComponent(c:Context, n:AbstractNode, component:AbstractComponent, mode:CreateMode, id:Int):Void {}

	@:hlNative("Urho3D", "_scene_node_set_position")
	public static function SetPosition(c:Context, n:AbstractNode, position:TVector3):Void {}

	@:hlNative("Urho3D", "_scene_node_get_position")
	public static function GetPosition(c:Context, n:AbstractNode):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_set_direction")
	public static function SetDirection(c:Context, n:AbstractNode, position:TVector3):Void {}

	@:hlNative("Urho3D", "_scene_node_get_direction")
	public static function GetDirection(c:Context, n:AbstractNode):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_set_scale")
	public static function SetScale(c:Context, n:AbstractNode, position:TVector3):Void {}

	@:hlNative("Urho3D", "_scene_node_get_scale")
	public static function GetSCale(c:Context, n:AbstractNode):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_set_rotation")
	public static function SetRotation(c:Context, n:AbstractNode, position:TQuaternion):Void {}

	@:hlNative("Urho3D", "_scene_node_get_rotation")
	public static function GetRotation(c:Context, n:AbstractNode):TQuaternion {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_rotate")
	public static function Rotate(c:Context, n:AbstractNode, rotation:TQuaternion, s:TransformSpace):Void {}

	@:hlNative("Urho3D", "_scene_node_rotate_euler")
	public static function RotateEuler(c:Context, n:AbstractNode, x:Single, y:Single, z:Single, s:TransformSpace):Void {}

	@:hlNative("Urho3D", "_scene_node_translate")
	public static function Translate(c:Context, n:AbstractNode, position:TVector3, s:TransformSpace):Void {}

	@:hlNative("Urho3D", "_scene_node_yaw")
	public static function Yaw(c:Context, n:AbstractNode, a:Single, s:TransformSpace):Void {}

	@:hlNative("Urho3D", "_scene_node_pitch")
	public static function Pitch(c:Context, n:AbstractNode, a:Single, s:TransformSpace):Void {}

	@:hlNative("Urho3D", "_scene_node_roll")
	public static function Roll(c:Context, n:AbstractNode, a:Single, s:TransformSpace):Void {}

	@:hlNative("Urho3D", "_scene_node_get_children_with_component")
	public static function GetChildrenWithComponent(c:Context, n:AbstractNode, s:TStringHash, b:Bool):PodNode {
		return null;
	}

	// DEFINE_PRIM(_I32, _scene_node_get_from_pod_vector_size, URHO3D_CONTEXT HL_URHO3D_POD_NODE);
	// DEFINE_PRIM(HL_URHO3D_NODE, _scene_node_get_from_pod_vector, URHO3D_CONTEXT HL_URHO3D_POD_NODE _I32);

	@:hlNative("Urho3D", "_scene_node_get_pod_vector_size")
	public static function GetPodVectorSize(c:Context, n:PodNode):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_scene_node_get_from_pod_vector")
	public static function GetNodeFromPodVector(c:Context, n:PodNode, i:Int):AbstractNode {
		return null;
	}
}
