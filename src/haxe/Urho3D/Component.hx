package urho3d;

import urho3d.StaticModel.AbstractStaticModel;
import urho3d.Node.AbstractNode;
import urho3d.Zone.AbstractZone;

typedef HL_URHO3D_COMPONENT = hl.Abstract<"hl_urho3d_scene_component">;

class Component {
	public  var _node:Node = null;
	public var node(get,never):Node;
	public var abstractComponent:AbstractComponent = null;

	public inline function new(?absComponent:AbstractComponent) {
		if (absComponent != null)
			abstractComponent = absComponent;
		else
			abstractComponent = new AbstractComponent();

		get_node().components.push(this);
	}

	public function get_node()
	{
		if(_node == null)
		{
			_node = new Node(AbstractComponent.GetNode(Context.context,abstractComponent));	
		}
		return _node;
	}
}

@:hlNative("Urho3D")
abstract AbstractComponent(HL_URHO3D_COMPONENT) {
	public inline function new() {
		this = Create(Context.context);
    }
    
    @:to
	public inline function toComponent():Component {
		//trace("AbstractComponent to Component");
		return new Component(cast this);
    }
    
	@:to
	public inline function toZone():Zone {
		//trace("AbstractComponent to zone");
		var abstractZone:AbstractZone = AbstractZone.CastFromComponent(Context.context, cast this);
		return new Zone(abstractZone);
	}

	@:to
	public inline function toStaticModel():StaticModel {
		var abstract_ = AbstractStaticModel.CastFromComponent(Context.context, cast this);
		return new StaticModel(abstract_);
	}

	@:hlNative("Urho3D", "_scene_component_create")
	private static function Create(c:Context):HL_URHO3D_COMPONENT {
		return null;
	}

	@:hlNative("Urho3D", "_scene_component_get_node")
	public static function GetNode(c:Context,d:AbstractComponent):AbstractNode {
		return null;
	}
	//

}
