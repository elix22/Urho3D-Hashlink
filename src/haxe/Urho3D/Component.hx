package urho3d;

import urho3d.StaticModel.AbstractStaticModel;
import urho3d.Node.AbstractNode;
import urho3d.Zone.AbstractZone;
import urho3d.Camera.AbstractCamera;
import urho3d.Light.AbstractLight;
import urho3d.AnimatedModel.AbstractAnimatedModel;

typedef HL_URHO3D_COMPONENT = hl.Abstract<"hl_urho3d_scene_component">;

class Component {
	private  var _node:Node = null;
	public var node(get,set):Node;
	public var abstractComponent:AbstractComponent = null;

	public inline function new(?absComponent:AbstractComponent) {
		if (absComponent != null)
			abstractComponent = absComponent;
		else
			abstractComponent = new AbstractComponent();

		node.bindComponent(this);
	}

	function get_node()
	{
		if(_node == null)
		{
			_node = new Node(AbstractComponent.GetNode(Context.context,abstractComponent));	
		}
		return _node;
	}

	function set_node(n)
		{
			_node = n;
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

	@:to
	public inline function toAnimatedModel():AnimatedModel {
		var abstract_ = AbstractAnimatedModel.CastFromComponent(Context.context, cast this);
		return new AnimatedModel(abstract_);
	}

	@:to
	public inline function toCamera():Camera {
		var abstract_ = AbstractCamera.CastFromComponent(Context.context, cast this);
		return new Camera(abstract_);
	}

	@:to
	public inline function toLight():Light {
		var abstract_ = AbstractLight.CastFromComponent(Context.context, cast this);
		return new Light(abstract_);
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
