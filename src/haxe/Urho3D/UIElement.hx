package urho3d;


typedef HL_URHO3D_UIELEMENT = hl.Abstract<"hl_urho3d_uielement">;

@:hlNative("Urho3D")
abstract UIElement(HL_URHO3D_UIELEMENT) {

  
    public inline function new() {
        this = Create(Context.context);
    }

    public function AddChild(t:UIElement)
    {
        _addChild(Context.context,this, t);
    }

    @:hlNative("Urho3D", "_create_uielement")
	private static function Create(context:Context):HL_URHO3D_UIELEMENT {
		return null;
    }

    @:hlNative("Urho3D", "_ui_uielement_addchild")
	private static function _addChild(context:Context, t:HL_URHO3D_UIELEMENT, child:UIElement) {
    }


}