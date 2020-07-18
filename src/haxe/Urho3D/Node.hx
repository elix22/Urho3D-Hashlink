package urho3d;

typedef HL_URHO3D_NODE = hl.Abstract<"hl_urho3d_scene_node">;

class Node {
	private var abstractNode:AbstractNode = null;

	public inline function new(?rhs:AbstractNode) {
		if (rhs != null) {
			abstractNode = rhs;
		} else {
			abstractNode = new AbstractNode();
		}
	}
}

@:hlNative("Urho3D")
abstract AbstractNode(HL_URHO3D_NODE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:hlNative("Urho3D", "_create_scene_node")
	private static function Create(c:Context):HL_URHO3D_NODE {
		return null;
	}
}
