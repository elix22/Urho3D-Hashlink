package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_ZONE = hl.Abstract<"hl_urho3d_graphics_zone">;

class Zone extends Component {
	private var abstractZone:AbstractZone = null;

	public inline function new(?absZone:AbstractZone) {
		if (absZone != null)
			abstractZone = absZone;
		else
            abstractZone = new AbstractZone();
        
        super(AbstractZone.CastToComponent(Context.context ,abstractZone));
    }

}

@:hlNative("Urho3D")
abstract AbstractZone(HL_URHO3D_ZONE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public  inline function toZone():Zone {
	//	trace("AbstractZone to Zone");
		return new Zone( cast this);
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
