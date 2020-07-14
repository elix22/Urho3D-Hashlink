package urho3d;

class UI {


    public static var root(get, never):UIElement;
  

    private static function get_root():UIElement
    {
        return getRoot(Context.context);
    }
    
    @:hlNative("Urho3D","_ui_get_root")
    private static function getRoot(context:hl.Abstract<"urho3d_context">):UIElement {
        return null;
    }

    
}