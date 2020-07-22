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

    private static var nodes = [];
    private  var components = [];
	private var abstractNode:AbstractNode = null;

	public var position(get, set):Vector3;
	public var rotation(get, set):Quaternion;

	public inline function new(?rhs:AbstractNode) {
		if (rhs != null) {
			abstractNode = rhs;
		} else {
			abstractNode = new AbstractNode();
        }
        nodes.push(this);
	}

	public function CreateChild(name:String = "", mode:CreateMode = CreateMode.REPLICATED, id:Int = 0, temporary:Bool = false):Node {
		var absNode:AbstractNode = AbstractNode.CreatChild(Context.context, abstractNode, name, mode, id, temporary);
		return absNode;
	}

	public function CreateComponent(type:String, mode:CreateMode = CreateMode.REPLICATED, id:Int = 0) {
		var absComp:AbstractComponent = AbstractNode.CreateComponent(Context.context, abstractNode, type, mode, id);
		return absComp;
	}

	public function AddComponent(component:Component, id:Int = 0, mode:CreateMode = CreateMode.REPLICATED) {
        component._node = this;
        components.push(component);
		AbstractNode.AddComponent(Context.context, abstractNode, component.abstractComponent, mode, id);
    }
    
    public function get_position() {
		return AbstractNode.GetPosition(Context.context,abstractNode);
	}

	public function set_position(p) {
        AbstractNode.SetPosition(Context.context,abstractNode,p);
		return p;
	}

	public function get_rotation() {
		return AbstractNode.GetRotation(Context.context,abstractNode);
	}

	public function set_rotation(r) {
        AbstractNode.SetRotation(Context.context,abstractNode,r);
		return r;
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

	@:hlNative("Urho3D", "_scene_node_add_component")
	public static function AddComponent(c:Context, n:AbstractNode, component:AbstractComponent, mode:CreateMode, id:Int):Void {}

	@:hlNative("Urho3D", "_scene_node_set_position")
	public static function SetPosition(c:Context, n:AbstractNode, position:Vector3):Void {}

	@:hlNative("Urho3D", "_scene_node_get_position")
	public static function GetPosition(c:Context, n:AbstractNode):Vector3 {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_set_rotation")
	public static function SetRotation(c:Context, n:AbstractNode, position:Quaternion):Void {}

	@:hlNative("Urho3D", "_scene_node_get_rotation")
	public static function GetRotation(c:Context, n:AbstractNode):Quaternion {
		return null;
	}

	//
}
