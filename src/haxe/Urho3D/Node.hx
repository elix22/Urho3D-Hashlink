package urho3d;
import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_NODE = hl.Abstract<"hl_urho3d_scene_node">;


@:enum abstract CreateMode(Int)
{
    var REPLICATED = 0;
    var LOCAL = 1 ;
}

/// Transform space for translations and rotations.
@:enum abstract TransformSpace(Int)
{
    var TS_LOCAL = 0;
    var TS_PARENT =1;
    var TS_WORLD = 2;
}


class Node {
	private var abstractNode:AbstractNode = null;

	public inline function new(?rhs:AbstractNode) {
		if (rhs != null) {
			abstractNode = rhs;
		} else {
			abstractNode = new AbstractNode();
		}
    }

    public function CreateChild(name:String="" , mode:CreateMode=CreateMode.REPLICATED , id:Int=0, temporary:Bool=false):Node{

        var absNode:AbstractNode = AbstractNode.CreatChild(Context.context,abstractNode,name,mode,id,temporary);
        return new Node(absNode);
    }

    public function CreateComponent(type:String, mode:CreateMode=CreateMode.REPLICATED , id:Int=0)
    {
        var absComp:AbstractComponent = AbstractNode.CreateComponent(Context.context,abstractNode,type,mode,id);
        return new Component(absComp);
    }
    
}

@:hlNative("Urho3D")
abstract AbstractNode(HL_URHO3D_NODE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:hlNative("Urho3D", "_scene_node_create")
	private static function Create(c:Context):HL_URHO3D_NODE {
		return null;
    }
    
    @:hlNative("Urho3D", "_scene_node_create_child")
    public static function CreatChild(c:Context , n:AbstractNode , name:String , mode:CreateMode , id:Int , temporary:Bool ):AbstractNode
    {
            return null;
    }

    @:hlNative("Urho3D", "_scene_node_create_component")
    public static function CreateComponent(c:Context , n:AbstractNode , name:String , mode:CreateMode , id:Int ):AbstractComponent
    {
            return null;
    }
}
