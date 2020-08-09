package urho3d;

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
			abstractScene = new AbstractScene();

		super(AbstractScene.CastToNode(Context.context, abstractScene));
		//	currentScene = this;
	}

	public var octree(get, never):Octree;

	function get_octree() {
		return AbstractScene.GetOctree(Context.context, abstractScene);
	}
}

@:hlNative("Urho3D")
abstract AbstractScene(HL_URHO3D_SCENE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:hlNative("Urho3D", "_scene_scene_create")
	private static function Create(c:Context):HL_URHO3D_SCENE {
		return null;
	}

	//

	@:hlNative("Urho3D", "_scene_scene_cast_to_node")
	public static function CastToNode(c:Context, s:AbstractScene):AbstractNode {
		return null;
	}

	@:hlNative("Urho3D", "_scene_scene_get_octree")
	public static function GetOctree(c:Context, s:AbstractScene):Octree {
		return null;
	}
}
