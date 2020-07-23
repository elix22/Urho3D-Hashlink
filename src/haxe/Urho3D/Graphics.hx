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
    private static function getWidth(context:Context):Int {
        return 0;
    }

    @:hlNative("Urho3D","_graphics_get_height")
    private static function getHeight(context:Context):Int {
        return 0;
    }

    
}


/// Blending mode.
@:enum abstract BlendMode(Int)
{
    var BLEND_REPLACE = 0;
    var BLEND_ADD = 1;
    var BLEND_MULTIPLY =2;
    var BLEND_ALPHA=3;
    var BLEND_ADDALPHA=4;
    var BLEND_PREMULALPHA=5;
    var BLEND_INVDESTALPHA=6;
    var BLEND_SUBTRACT=7;
    var BLEND_SUBTRACTALPHA=8;
    var MAX_BLENDMODES;
}


