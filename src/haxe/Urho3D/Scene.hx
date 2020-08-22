package urho3d;

import haxe.macro.Expr.Field;
import urho3d.Node.AbstractNode;

typedef HL_URHO3D_SCENE = hl.Abstract<"hl_urho3d_scene_scene">;

class Scene extends Node {
	public static var currentScene:Scene = null;

	public var nodes = [];
	public var abstractScene:AbstractScene = null;

	public inline function new(?rhs:AbstractScene) {
		if (rhs != null)
			abstractScene = rhs;
		else
			abstractScene = new AbstractScene(this);

		super(AbstractScene.CastToNode(Context.context, abstractScene));
		//	currentScene = this;
	}

	public var octree(get, never):Octree;

	function get_octree() {
		return AbstractScene.GetOctree(Context.context, abstractScene);
	}

	public inline function SaveXML(?p:String, s:String = "\t"):Bool {
		if (p != null) {
			return AbstractScene.SaveXMLString(Context.context, abstractScene, p, s);
		} else
			return false;
	}

	public inline function LoadXML(?p:String):Bool {
		nodes = [];
		if (p != null) {
			return AbstractScene.LoadXMLString(Context.context, abstractScene, p);
		} else
			return false;
	}

	public var physicsWorld(get, never):PhysicsWorld;

	function get_physicsWorld() {
		return AbstractScene.GetPhysicsWorld(Context.context, abstractScene);
	}
}

@:hlNative("Urho3D")
abstract AbstractScene(HL_URHO3D_SCENE) {
	public inline function new(d:Dynamic) {
		this = Create(Context.context, d);
	}

	@:hlNative("Urho3D", "_scene_scene_create")
	private static function Create(c:Context, d:Dynamic):HL_URHO3D_SCENE {
		return null;
	}

	@:to
	public inline function toScene():Scene {
		return new Scene(cast this);
	}

	@:hlNative("Urho3D", "_scene_scene_cast_to_node")
	public static function CastToNode(c:Context, s:AbstractScene):AbstractNode {
		return null;
	}

	@:hlNative("Urho3D", "_scene_scene_get_octree")
	public static function GetOctree(c:Context, s:AbstractScene):Octree {
		return null;
	}

	@:hlNative("Urho3D", "_scene_scene_save_xml")
	public static function SaveXML(c:Context, s:AbstractScene, f:File, s:String):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_scene_scene_load_xml")
	public static function LoadXML(c:Context, s:AbstractScene, f:File):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_scene_scene_save_xml_string")
	public static function SaveXMLString(c:Context, s:AbstractScene, f:String, s:String):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_scene_scene_load_xml_string")
	public static function LoadXMLString(c:Context, s:AbstractScene, f:String):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_scene_scene_get_physics_world")
	public static function GetPhysicsWorld(c:Context, s:AbstractScene):PhysicsWorld {
		return null;
	}
}
