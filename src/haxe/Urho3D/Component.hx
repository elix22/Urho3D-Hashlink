package urho3d;

import urho3d.Zone.AbstractZone;

typedef HL_URHO3D_COMPONENT = hl.Abstract<"hl_urho3d_scene_component">;

class Component {
	public var abstractComponent:AbstractComponent = null;

	public inline function new(?absComponent:AbstractComponent) {
		if (absComponent != null)
			abstractComponent = absComponent;
		else
			abstractComponent = new AbstractComponent();
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

	@:hlNative("Urho3D", "_scene_component_create")
	private static function Create(c:Context):HL_URHO3D_COMPONENT {
		return null;
	}

}
