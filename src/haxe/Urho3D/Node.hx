package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_NODE = hl.Abstract<"hl_urho3d_scene_node">;

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

	public var position(get, set):Vector3;
	public var direction(get, set):Vector3;
	public var scale(get, set):Vector3;
	public var rotation(get, set):Quaternion;

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

	public function GetComponent(type:String) {
		var absComp:AbstractComponent = AbstractNode.GetComponent(Context.context, abstractNode, type);
		return absComp;
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

	public function Rotate(q:Quaternion, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Rotate(Context.context, abstractNode, q, s);
	}

	public function RotateEuler(x:Float, y:Float, z:Float, s:TransformSpace = TS_LOCAL) {
		AbstractNode.RotateEuler(Context.context, abstractNode, x, y, z, s);
	}
}

@:hlNative("Urho3D")
abstract AbstractNode(HL_URHO3D_NODE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toNode():Node {
		// trace("AbstractNode to Node");
		return new Node(cast this);
	}

	@:hlNative("Urho3D", "_scene_node_create")
	private static function Create(c:Context):HL_URHO3D_NODE {
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
	public static function GetComponent(c:Context, n:AbstractNode, name:String):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_add_component")
	public static function AddComponent(c:Context, n:AbstractNode, component:AbstractComponent, mode:CreateMode, id:Int):Void {}

	@:hlNative("Urho3D", "_scene_node_set_position")
	public static function SetPosition(c:Context, n:AbstractNode, position:Vector3):Void {}

	@:hlNative("Urho3D", "_scene_node_get_position")
	public static function GetPosition(c:Context, n:AbstractNode):Vector3 {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_set_direction")
	public static function SetDirection(c:Context, n:AbstractNode, position:Vector3):Void {}

	@:hlNative("Urho3D", "_scene_node_get_direction")
	public static function GetDirection(c:Context, n:AbstractNode):Vector3 {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_set_scale")
	public static function SetScale(c:Context, n:AbstractNode, position:Vector3):Void {}

	@:hlNative("Urho3D", "_scene_node_get_scale")
	public static function GetSCale(c:Context, n:AbstractNode):Vector3 {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_set_rotation")
	public static function SetRotation(c:Context, n:AbstractNode, position:Quaternion):Void {}

	@:hlNative("Urho3D", "_scene_node_get_rotation")
	public static function GetRotation(c:Context, n:AbstractNode):Quaternion {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_rotate")
	public static function Rotate(c:Context, n:AbstractNode, rotation:Quaternion, s:TransformSpace):Void {}

	@:hlNative("Urho3D", "_scene_node_rotate_euler")
	public static function RotateEuler(c:Context, n:AbstractNode, x:Single, y:Single, z:Single, s:TransformSpace):Void {}

	//
}
