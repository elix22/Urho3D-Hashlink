package urho3d;

import urho3d.*;
import urho3d.Context;
import urho3d.Node.AbstractNode;


typedef HL_URHO3D_T_NODE = hl.Abstract<"hl_urho3d_scene_t_node">;

@:hlNative("Urho3D")
abstract TNode(HL_URHO3D_T_NODE) {


    @:to
	public inline function ToNode():Node {
		return new Node(CastToNode(Context.context,cast this));
    }

    @:to
	public inline function ToAbstractNode():AbstractNode {
		return CastToNode(Context.context,cast this);
    }

    @:hlNative("Urho3D", "_scene_t_node_cast_from_node")
	private static function CastFromNode(c:Context, s:AbstractNode):TNode {
		return null;
	}

	@:hlNative("Urho3D", "_scene_t_node_cast_to_node")
	private static function CastToNode(c:Context, s:TNode):AbstractNode {
		return null;
	}
}