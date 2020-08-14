package urho3d;

import urho3d.Component.AbstractComponent;
import urho3d.Node.AbstractNode;

typedef HL_URHO3D_OBJECT = hl.Abstract<"hl_urho3d_core_object">;

@:hlNative("Urho3D")
abstract Object(HL_URHO3D_OBJECT) {


    @:to
	public inline function toComponent():Component {
		return new Component(CastToComponent(Context.context, cast this));
    }
    
    @:from
	public static inline function fromComponent(c:Component):Object {
		return CastFromComponent(Context.context, c.abstractComponent);
    }

    @:to
	public inline function toNode():Node {
		return new Node(CastToNode(Context.context, cast this));
    }
    
    @:from
	public static inline function fromNode(n:Node):Object {
		return CastFromNode(Context.context, n.abstractNode);
    }
    
    @:hlNative("Urho3D", "_core_object_cast_from_component")
	private static function CastFromComponent(c:Context, s:AbstractComponent):Object {
		return null;
	}

	@:hlNative("Urho3D", "_core_object_cast_to_component")
	private static function CastToComponent(c:Context, s:Object):AbstractComponent {
		return null;
    }
    
    @:hlNative("Urho3D", "_core_object_cast_from_node")
	private static function CastFromNode(c:Context, s:AbstractNode):Object {
		return null;
	}

	@:hlNative("Urho3D", "_core_object_cast_to_node")
	private static function CastToNode(c:Context, s:Object):AbstractNode {
		return null;
	}


}
