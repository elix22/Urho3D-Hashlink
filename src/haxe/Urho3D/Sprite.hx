package urho3d;


typedef HL_URHO3D_SPRITE = hl.Abstract<"hl_urho3d_sprite">;

@:hlNative("Urho3D")
abstract Sprite(HL_URHO3D_SPRITE) {


    public inline function new() {
        this = Create(Context.context);
    }

    public var texture(get,set):Texture2D;


    function set_texture(t)
    {
        if(t != null)
            return _set_texture(Context.context,this,t);
        else 
            return null;
    }

    function get_texture()
    {
         return _get_texture(Context.context,this);
    }

    @:hlNative("Urho3D", "_create_sprite")
	private static function Create(context:hl.Abstract<"urho3d_context"> ):HL_URHO3D_SPRITE {
		return null;
    }

    @:hlNative("Urho3D", "_sprite_set_texture")
	private static function _set_texture(context:hl.Abstract<"urho3d_context">,HL_URHO3D_SPRITE,Texture2D):Texture2D {
		return null;
    }

    @:hlNative("Urho3D", "_sprite_get_texture")
	private static function _get_texture(context:hl.Abstract<"urho3d_context">,HL_URHO3D_SPRITE):Texture2D {
		return null;
    }


}