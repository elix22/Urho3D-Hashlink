package urho3d;

typedef HL_URHO3D_SPRITE = hl.Abstract<"hl_urho3d_sprite">;

@:hlNative("Urho3D")
abstract Sprite(HL_URHO3D_SPRITE) {
	public inline function new() {
		this = Create(Context.context);
	}

	public var texture(get, set):Texture2D;
	public var position(get, set):Vector2;
	public var size(get, set):IntVector2;
    public var hotSpot(get, set):IntVector2;
    public var rotation(get, set):Single;
    public var scale(get, set):Vector2;
    public var vars(get, never):VariantMap;


    @:to
    public inline function toUIElement():UIElement
    {
            return CastToUIElement(Context.context,this);
    }

	function set_texture(t) {
		if (t != null)
			return _set_texture(Context.context, this, t);
		else
			return null;
	}

	function get_texture() {
		return _get_texture(Context.context, this);
	}

	function set_position(t) {
		if (t != null)
			return _set_position(Context.context, this, t);
		else
			return null;
	}

	function get_position() {
		return _get_position(Context.context, this);
	}

	function set_size(t) {
		if (t != null)
			return _set_size(Context.context, this, t);
		else
			return null;
	}

	function get_size() {
		return _get_size(Context.context, this);
	}

	function set_hotSpot(t) {
		if (t != null)
			return _set_hotspot(Context.context, this, t);
		else
			return null;
	}

	function get_hotSpot() {
		return _get_hotspot(Context.context, this);
    }


    function set_rotation(t) {
		return _set_rotation(Context.context, this, t);
	}

	function get_rotation() {
		return _get_rotation(Context.context, this);
    }

	function set_scale(t) {
		if (t != null)
			return _set_scale(Context.context, this, t);
		else
			return null;
	}

	function get_scale() {
		return _get_scale(Context.context, this);
    }
    
    function get_vars() {
		return _get_vars(Context.context, this);
	}
    


	@:hlNative("Urho3D", "_create_sprite")
	private static function Create(context:hl.Abstract<"urho3d_context">):HL_URHO3D_SPRITE {
		return null;
	}

	@:hlNative("Urho3D", "_sprite_set_texture")
	private static function _set_texture(context:hl.Abstract<"urho3d_context">, v:HL_URHO3D_SPRITE, Texture2D):Texture2D {
		return null;
	}

	@:hlNative("Urho3D", "_sprite_get_texture")
	private static function _get_texture(context:hl.Abstract<"urho3d_context">, v:HL_URHO3D_SPRITE):Texture2D {
		return null;
	}

	@:hlNative("Urho3D", "_sprite_set_position")
	private static function _set_position(context:hl.Abstract<"urho3d_context">, v:HL_URHO3D_SPRITE, Vector2):Vector2 {
		return null;
	}

	@:hlNative("Urho3D", "_sprite_get_position")
	private static function _get_position(context:hl.Abstract<"urho3d_context">, v:HL_URHO3D_SPRITE):Vector2 {
		return null;
	}

	@:hlNative("Urho3D", "_sprite_set_size")
	private static function _set_size(context:hl.Abstract<"urho3d_context">,v:HL_URHO3D_SPRITE, t:IntVector2):IntVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_sprite_get_size")
	private static function _get_size(context:hl.Abstract<"urho3d_context">, v:HL_URHO3D_SPRITE):IntVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_sprite_set_hotspot")
	private static function _set_hotspot(context:hl.Abstract<"urho3d_context">, v:HL_URHO3D_SPRITE, t:IntVector2):IntVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_sprite_get_hotspot")
	private static function _get_hotspot(context:hl.Abstract<"urho3d_context">, v:HL_URHO3D_SPRITE):IntVector2 {
		return null;
    }
    
    @:hlNative("Urho3D", "_sprite_set_rotation")
	private static function _set_rotation(context:hl.Abstract<"urho3d_context">, v:HL_URHO3D_SPRITE, t:Single):Single {
		return 0;
	}

	@:hlNative("Urho3D", "_sprite_get_rotation")
	private static function _get_rotation(context:hl.Abstract<"urho3d_context">, t:HL_URHO3D_SPRITE):Single {
		return 0;
    }
    
    @:hlNative("Urho3D", "_sprite_set_scale")
	private static function _set_scale(context:hl.Abstract<"urho3d_context">, t:HL_URHO3D_SPRITE, Vector2):Vector2 {
		return null;
	}

	@:hlNative("Urho3D", "_sprite_get_scale")
	private static function _get_scale(context:hl.Abstract<"urho3d_context">, t:HL_URHO3D_SPRITE):Vector2 {
		return null;
    }
    
    @:hlNative("Urho3D", "_sprite_get_vars")
	private static function _get_vars(context:hl.Abstract<"urho3d_context">, t:HL_URHO3D_SPRITE):VariantMap {
		return null;
    }
    
    @:hlNative("Urho3D", "_cast_sprite_to_uielement")
	private static function CastToUIElement(context:hl.Abstract<"urho3d_context"> , t:HL_URHO3D_SPRITE):UIElement {
		return null;
    }
}
