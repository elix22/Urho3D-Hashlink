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

		super(AbstractZone.CastToComponent(Context.context, abstractZone));
	}

	public var boundingBox(get, set):BoundingBox;

	public function set_boundingBox(b) {
		return AbstractZone.SetBoundingBox(Context.context,abstractZone,b);
	}

	public function get_boundingBox() {
		return AbstractZone.GetBoundingBox(Context.context,abstractZone);
	}

	public var ambientColor(get, set):Color;

	public function set_ambientColor(b) {
		return AbstractZone.SetAmbientColor(Context.context,abstractZone,b);
	}

	public function get_ambientColor() {
		return AbstractZone.GetAmbientColor(Context.context,abstractZone);
	}

	public var fogColor(get, set):Color;

	public function set_fogColor(b) {
		return AbstractZone.SetFogColor(Context.context,abstractZone,b);
	}

	public function get_fogColor() {
		return AbstractZone.GetFogColor(Context.context,abstractZone);
	}

	public var fogStart(get, set):Single;

	public function set_fogStart(b) {
		return AbstractZone.SetFogStart(Context.context,abstractZone,b);
	}

	public function get_fogStart() {
		return AbstractZone.GetFogStart(Context.context,abstractZone);
	}
	public var fogEnd(get, set):Single;

	public function set_fogEnd(b) {
		return AbstractZone.SetFogStart(Context.context,abstractZone,b);
	}

	public function get_fogEnd() {
		return AbstractZone.GetFogStart(Context.context,abstractZone);
	}
}

@:hlNative("Urho3D")
abstract AbstractZone(HL_URHO3D_ZONE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toZone():Zone {
		//	trace("AbstractZone to Zone");
		return new Zone(cast this);
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

	@:hlNative("Urho3D", "_graphics_zone_set_boundingbox")
	public static function SetBoundingBox(c:Context, t:AbstractZone, b:BoundingBox):BoundingBox {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_zone_get_boundingbox")
	public static function GetBoundingBox(c:Context, t:AbstractZone):BoundingBox {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_zone_set_ambient_color")
	public static function SetAmbientColor(c:Context, t:AbstractZone, a:Color):Color {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_zone_get_ambient_color")
	public static function GetAmbientColor(c:Context, t:AbstractZone):Color {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_zone_set_fog_color")
	public static function SetFogColor(c:Context, t:AbstractZone, a:Color):Color {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_zone_get_fog_color")
	public static function GetFogColor(c:Context, t:AbstractZone):Color {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_zone_set_fog_start")
	public static function SetFogStart(c:Context, t:AbstractZone, a:Single):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_zone_get_fog_start")
	public static function GetFogStart(c:Context, t:AbstractZone):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_zone_set_fog_end")
	public static function SetFogEnd(c:Context, t:AbstractZone, a:Single):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_graphics_zone_get_fog_end")
	public static function GetFogEnd(c:Context, t:AbstractZone):Single {
		return 0.0;
	}
}
