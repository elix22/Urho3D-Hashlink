package urho3d;

import haxe.rtti.CType.TypeParams;
import hl.uv.Tcp;
import hl.Abstract;
import urho3d.AbstractApplication.Dyn;
import urho3d.Component.AbstractComponent;
import urho3d.LogicComponent.AbstractLogicComponent;
import urho3d.Component.URHO3D_COMPONENT_PTR;

typedef HL_URHO3D_NODE = hl.Abstract<"hl_urho3d_scene_node">;
typedef HL_URHO3D_POD_NODE = hl.Abstract<"hl_urho3d_scene_pod_node">;
typedef URHO3D_NODE_PTR = hl.Abstract<"hl_urho3d_scene_node_ptr">;


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
	//private var children:Array<Node> = [];
	private var children_name_map = new Map<String, Node>();
	private var children_pointers_map = new Map<URHO3D_NODE_PTR, Node>();
	//private var components:Array<Component> = [];
	private var components_map = new Map<URHO3D_COMPONENT_PTR, Component>();
	private var logic_components_map = new Map<String, Array<Dynamic>>();

	public var abstractNode:AbstractNode = null;

	public var position(get, set):TVector3;
	public var worldPosition(get, set):TVector3;
	public var direction(get, set):TVector3;
	public var scale(get, set):TVector3;
	public var rotation(get, set):TQuaternion;

	public var pointer(get, never):URHO3D_NODE_PTR;

	function get_pointer() {
		return AbstractNode.GetNodePointer(Context.context, abstractNode);
	}

	public inline function new(?rhs:AbstractNode) {
		if (rhs != null) {
			abstractNode = rhs;
		} else {
			abstractNode = new AbstractNode();
		}

		AbstractNode.SetDynamic(Context.context, abstractNode, this);

		if (Scene.currentScene != null)
			Scene.currentScene.nodes.push(this);
	}

	@:keep
	public inline function CleanChildData() {
		/*
		for (child in children) {
			child.CleanChildData();
		}
		*/
		for(child in children_pointers_map)
			{
				child.CleanChildData();
			}
		//children = [];
		children_name_map.clear();
		//components = [];
		components_map.clear();
		logic_components_map.clear();
		children_pointers_map.clear();
	}

	@:keep
	public inline function SubscribeToEvent(?object:Object, stringHash:StringHash, s:String) {
		if (abstractNode != null) {
			abstractNode.SubscribeToEvent(object, stringHash, this, s);
		}
	}

	@:keep
	public  inline function bindComponent(component:Component) {
		// trace ("bindComponent :" + Std.string(component));
		//components.push(component);
		components_map[component.pointer] = component;
		component.node = this;
	}

	@:keep
	public inline function unbindComponent(c:Component) {
		/*
		for (component in components) {
			if (component == c) {
				components.remove(component);
				break;
			}
		}
		*/
		logic_components_map.remove(Std.string(c));
		return components_map.remove(c.pointer);
	}

	@:keep
	public inline function unbindComponentString(c:String) {
		var result:Bool = false;
		for (component in components_map) {
			var names = Std.string(component).split(".");
			for (name in names) {
				if (name == c) {
					result = components_map.remove(component.pointer);
					break;
				}
			}
		}
		logic_components_map.remove(c);
		return result;
	}

	@:keep
	public function CreateHashLinkLogicComponent(component:AbstractLogicComponent, componentType:hl.Bytes):Dynamic {
		return LogicComponent.CreateFactory(componentType, component);
	}

	@:keep
	public function CreateChildFromAbstractNode(absNode:AbstractNode):Node {
		var node:Node = new Node(absNode);
		this.children_pointers_map[node.pointer]= node;
		return node;
		//	trace("CreateChildFromAbstractNode "+this.abstractNode + ":" + absNode);
		//this.children.push(node);
	}

	@:keep
	public inline function CreateChild(name:String = "", mode:CreateMode = CreateMode.REPLICATED, id:Int = 0, temporary:Bool = false):Node {
		var absNode:AbstractNode = AbstractNode.CreatChild(Context.context, abstractNode, name, mode, id, temporary);
		var node:Node = new Node(absNode);
		//this.children.push(node);
		//trace(node.pointer);
		this.children_pointers_map[node.pointer]= node;
		if (name != "")
			children_name_map[name] = node;
		return node;
	}

	@:keep
	public inline function CreateComponent(type:String, mode:CreateMode = CreateMode.REPLICATED, id:Int = 0) {
		var comp:AbstractComponent = AbstractNode.CreateComponent(Context.context, abstractNode, type, mode, id);
		return comp;
	}

	// StaticModel

	@:keep
	public inline function GetComponent(type:String, recursive:Bool = false) {
		var comp = AbstractNode.GetComponent(Context.context, abstractNode, type, recursive);
		// if(comp==null)return GetLogicComponent(dynType);
		return comp;
	}

	@:keep
	public inline function GetLogicComponent(type:Dynamic, recursive:Bool = true):Dynamic {
		var typeStr = Std.string(type).split("$").join("");

		if (logic_components_map[typeStr] != null) {
			return logic_components_map[typeStr][0];
		} else {
			//	trace("GetLogicComponent "+abstractNode);
			var abs_comp = AbstractNode.GetLogicComponent(Context.context, abstractNode, typeStr, recursive);
			if (abs_comp != null) {
				if (logic_components_map[typeStr] == null)
					logic_components_map[typeStr] = [];
				logic_components_map[typeStr].push(abs_comp);
				return abs_comp;
			} else
				return null;
		}
	}

	@:keep
	public inline function AddComponent(component:Dynamic, id:Int = 0, mode:CreateMode = CreateMode.REPLICATED) {
		// component.node = this;
		bindComponent(component);
		AbstractNode.AddComponent(Context.context, abstractNode, component.abstractComponent, mode, id);

		if (logic_components_map[Std.string(component)] == null)
			logic_components_map[Std.string(component)] = [];
		logic_components_map[Std.string(component)].push(component);
	}

	@:keep
	public inline function AddLogicComponent(component:Dynamic, id:Int = 0, mode:CreateMode = CreateMode.REPLICATED) {
		// trace("AddLogicComponent " + Std.string(component));
		bindComponent(component);
		AbstractNode.AddComponent(Context.context, abstractNode, component.abstractComponent, mode, id);

		if (logic_components_map[Std.string(component)] == null)
			logic_components_map[Std.string(component)] = [];
		logic_components_map[Std.string(component)].push(component);
	}

	@:keep
	public inline function RemoveComponent(?strComponent:String, ?component:Component) {
		var result:Bool = false;

		if (strComponent != null) {
			AbstractNode.RemoveComponentString(Context.context, abstractNode, strComponent);
			result = unbindComponentString(strComponent);
		}
		if (component != null) {
			AbstractNode.RemoveComponent(Context.context, abstractNode, component.abstractComponent);
			result = unbindComponent(component);
		}

		return result;
	}

	@:keep
	public inline function RemoveLogicComponent(component:Component):Bool {
		AbstractNode.RemoveComponent(Context.context, abstractNode, component.abstractComponent);
		return unbindComponent(component);
		/*
			if (logic_components_map[Std.string(component)] != null) {
				var components = logic_components_map[Std.string(component)];
				return components.remove(component);
			}
		 */
	}

	private inline function get_position() {
		return AbstractNode.GetPosition(Context.context, abstractNode);
	}

	private inline function set_position(p) {
		AbstractNode.SetPosition(Context.context, abstractNode, p);
		return p;
	}

	private inline function get_worldPosition() {
		return AbstractNode.GetWorldtPosition(Context.context, abstractNode);
	}

	private inline function set_worldPosition(p) {
		AbstractNode.SetWorldPosition(Context.context, abstractNode, p);
		return p;
	}

	private inline function get_direction() {
		return AbstractNode.GetDirection(Context.context, abstractNode);
	}

	private inline function set_direction(p) {
		AbstractNode.SetDirection(Context.context, abstractNode, p);
		return p;
	}

	private inline function get_scale() {
		return AbstractNode.GetSCale(Context.context, abstractNode);
	}

	private inline function set_scale(p) {
		AbstractNode.SetScale(Context.context, abstractNode, p);
		return p;
	}

	private inline function get_rotation() {
		return AbstractNode.GetRotation(Context.context, abstractNode);
	}

	private inline function set_rotation(r) {
		AbstractNode.SetRotation(Context.context, abstractNode, r);
		return r;
	}

	public inline function Rotate(q:TQuaternion, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Rotate(Context.context, abstractNode, q, s);
	}

	public inline function RotateEuler(x:Float, y:Float, z:Float, s:TransformSpace = TS_LOCAL) {
		AbstractNode.RotateEuler(Context.context, abstractNode, x, y, z, s);
	}

	public inline function Translate(delta:TVector3, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Translate(Context.context, abstractNode, delta, s);
	}

	public inline function Yaw(a:Float, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Yaw(Context.context, abstractNode, a, s);
	}

	public inline function Pitch(a:Float, s:TransformSpace = TS_LOCAL) {
		AbstractNode.Pitch(Context.context, abstractNode, a, s);
	}

	public inline function Roll(a:Float, s:TransformSpace = TS_LOCAL) {
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

	public inline function GetChild(name:String, recursive:Bool = false):Node {
		// trace("GetChild "+name + ":"+abstractNode);
		if (children_name_map[name] != null) {
			return children_name_map[name];
		} else {
			// trace("GetChild " + name + ":" + abstractNode);
			var node = new Node(AbstractNode.GetChild(Context.context, abstractNode, name, recursive));
			children_name_map[name] = node;
			return node;
		}
	}

	public inline function LookAt(target:TVector3, ?up:TVector3, space:TransformSpace = TS_WORLD):Bool {
		if (up == null)
			up = Vector3.UP;
		return AbstractNode.LookAt(Context.context, abstractNode, target, up, space);
	}
}

@:hlNative("Urho3D")
abstract AbstractNode(HL_URHO3D_NODE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toNode():Node {
		// trace("toNode "+ this);
		return new Node(cast this);
	}

	@:keep
	public function SubscribeToEvent(?object:Object, stringHash:StringHash, d:Dynamic, s:String) {
		if (object != null) {
			_SubscribeToEventSender(Context.context, object, cast this, stringHash, d, s);
		} else {
			_SubscribeToEvent(Context.context, cast this, stringHash, d, s);
		}
	}

	@:hlNative("Urho3D", "_scene_node_create")
	public static function Create(c:Context):HL_URHO3D_NODE {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_create_child")
	public static function CreatChild(c:Context, n:AbstractNode, name:String, mode:CreateMode, id:Int, temporary:Bool):AbstractNode {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_set_dynamic")
	public static function SetDynamic(c:Context, n:AbstractNode, d:Dynamic):Void {}

	@:hlNative("Urho3D", "_scene_node_create_component")
	public static function CreateComponent(c:Context, n:AbstractNode, name:String, mode:CreateMode, id:Int):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_get_component")
	public static function GetComponent(c:Context, n:AbstractNode, name:String, recursive:Bool):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_get_logic_component")
	public static function GetLogicComponent(c:Context, n:AbstractNode, type:String, recursive:Bool):Dynamic {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_add_component")
	public static function AddComponent(c:Context, n:AbstractNode, component:AbstractComponent, mode:CreateMode, id:Int):Void {}

	@:hlNative("Urho3D", "_scene_node_remove_component")
	public static function RemoveComponent(c:Context, n:AbstractNode, component:AbstractComponent):Void {}

	@:hlNative("Urho3D", "_scene_node_remove_component_string")
	public static function RemoveComponentString(c:Context, n:AbstractNode, component:String):Void {}

	@:hlNative("Urho3D", "_scene_node_set_position")
	public static function SetPosition(c:Context, n:AbstractNode, position:TVector3):Void {}

	@:hlNative("Urho3D", "_scene_node_get_position")
	public static function GetPosition(c:Context, n:AbstractNode):TVector3 {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_set_world_position")
	public static function SetWorldPosition(c:Context, n:AbstractNode, position:TVector3):Void {}

	@:hlNative("Urho3D", "_scene_node_get_world_position")
	public static function GetWorldtPosition(c:Context, n:AbstractNode):TVector3 {
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

	@:hlNative("Urho3D", "_scene_node_subscribe_to_event")
	private static function _SubscribeToEvent(c:Context, node:AbstractNode, tringHash:StringHash, d:Dynamic, s:String):Void {}

	@:hlNative("Urho3D", "_scene_node_subscribe_to_event_sender")
	private static function _SubscribeToEventSender(c:Context, o:Object, node:AbstractNode, tringHash:StringHash, d:Dynamic, s:String):Void {}

	@:hlNative("Urho3D", "_scene_node_get_child")
	public static function GetChild(c:Context, n:AbstractNode, n:String, b:Bool):AbstractNode {
		return null;
	}

	@:hlNative("Urho3D", "_scene_node_look_at")
	public static function LookAt(c:Context, n:AbstractNode, target:TVector3, up:TVector3, s:TransformSpace):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_scene_node_get_node_pointer")
	public static function GetNodePointer(c:Context, n:AbstractNode):URHO3D_NODE_PTR {
		return null;
	}
}
