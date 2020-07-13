package urho3d;

class Graphics {


    public static var width(get, never):Int;
    public static var height(get, never):Int;

    private static function get_width():Int
    {
        return getWidth(Context.context);
    }

    private static function get_height():Int
    {
        return getHeight(Context.context);
    }

    
    @:hlNative("Urho3D","_graphics_get_width")
    private static function getWidth(context:hl.Abstract<"urho3d_context">):Int {
        return 0;
    }

    @:hlNative("Urho3D","_graphics_get_height")
    private static function getHeight(context:hl.Abstract<"urho3d_context">):Int {
        return 0;
    }
    
}