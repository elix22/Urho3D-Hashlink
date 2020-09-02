
package urho3d;


typedef HL_URHO3D_UI_FONT = hl.Abstract<"hl_urho3d_ui_font">;


@:hlNative("Urho3D")
abstract Font(HL_URHO3D_UI_FONT) {

  
    public inline function new(s:String) {
        this = Create(Context.context,s);
    }

    @:hlNative("Urho3D", "_ui_font_create")
	private static function Create(context:Context , s:String):HL_URHO3D_UI_FONT {
		return null;
    }

}