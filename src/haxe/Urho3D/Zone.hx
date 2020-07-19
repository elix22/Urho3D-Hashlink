package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_ZONE = hl.Abstract<"hl_urho3d_graphics_zone">;

class Zone extends Component{
	private var abstractZone:AbstractZone = null;

	public inline function new(?absZone:AbstractZone) {
		if (absZone != null)
			abstractZone = absZone;
		else
            abstractZone = new AbstractZone();
        
        super(AbstractZone.CastToComponent(Context.context ,abstractZone));
    }
    
    @:from
	public static inline function fromComponent(component:Component):Zone {
        trace("component to zone");
        var abstractZone:AbstractZone = AbstractZone.CastFromComponent(Context.context,component.abstractComponent) ; //
		return new Zone(abstractZone);
	}

	@:to
	public inline function toComponent():Component {
        trace("zone to component");
        var abstractComponent:AbstractComponent = AbstractZone.CastToComponent(Context.context,this.abstractZone);
		return new Component(abstractComponent);
	}
}

@:hlNative("Urho3D")
abstract AbstractZone(HL_URHO3D_ZONE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:hlNative("Urho3D", "_graphics_zone_create")
	private static function Create(c:Context):HL_URHO3D_ZONE {
		return null;
	}

	//

	@:hlNative("Urho3D", "_graphics_zone_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractZone {
		return null;
    }
    
    @:hlNative("Urho3D", "_graphics_zone_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractZone):AbstractComponent {
		return null;
    }
}
