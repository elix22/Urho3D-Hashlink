package urho3d;

import urho3d.UIElement.HorizontalAlignment;
import hl.Bytes;

typedef HL_URHO3D_UI_TEXT = hl.Abstract<"hl_urho3d_ui_text">;

@:hlNative("Urho3D")
abstract Text(HL_URHO3D_UI_TEXT) {
	public inline function new() {
		this = Create(Context.context);
	}


    @:from
	public static inline function fromUIElement(c:UIElement):Text {
		return CastFromUIElement(Context.context,c);
    }
    
    @:to
	public inline function toUIElement():UIElement {
		 return CastToUIElement(Context.context, cast this);
    }
    

	public var text(get, set):String;

	function get_text() @:privateAccess {
		return String.fromUTF8(_getText(Context.context, cast this));
	}

	function set_text(t) {
		_setText(Context.context, cast this, t);
		return t;
	}

	public var horizontalAlignment(get, set):HorizontalAlignment;

	function get_horizontalAlignment() {
		return GetHorizontalAlignment(Context.context, cast this);
	}

	function set_horizontalAlignment(a) {
		SetHorizontalAlignment(Context.context, cast this, a);
		return a;
	}

	public function AddChild(t:UIElement) {
		_addChild(Context.context, cast this, t);
	}

	public function SetFont(font:Font, size:Float = 12) {
		_setFont(Context.context, cast this, font, size);
	}

	@:hlNative("Urho3D", "_ui_text_create")
	private static function Create(context:Context):HL_URHO3D_UI_TEXT {
		return null;
	}

	@:hlNative("Urho3D", "_ui_text_addchild")
	private static function _addChild(context:Context, t:Text, child:UIElement) {}

	@:hlNative("Urho3D", "_ui_text_set_font")
	private static function _setFont(context:Context, t:Text, font:Font, size:Single):Bool {return false;}

	@:hlNative("Urho3D", "_ui_text_set_text")
	private static function _setText(context:Context, t:Text, text:String) {}

	@:hlNative("Urho3D", "_ui_text_get_text")
	private static function _getText(c:Context, n:Text):Bytes {
		return null;
	}

	@:hlNative("Urho3D", "_ui_text_set_text_alignment")
	private static function SetTextAlignment(context:Context, t:Text, a:Int) {}

	@:hlNative("Urho3D", "_ui_text_get_text_alignment")
	private static function GetTextAlignment(c:Context, n:Text):Int {
		return 0;
    }

    @:hlNative("Urho3D", "_ui_text_set_horizontal_alignment")
	private static function SetHorizontalAlignment(context:Context, t:Text, a:Int) {}

	@:hlNative("Urho3D", "_ui_text_get_horizontal_alignment")
	private static function GetHorizontalAlignment(c:Context, n:Text):Int {
		return 0;
    }
    
    @:hlNative("Urho3D", "_ui_text_cast_to_uielement")
    private static function CastToUIElement(context:Context, t:Text):UIElement {return null;}
    
    @:hlNative("Urho3D", "_ui_text_cast_from_uielement")
	private static function CastFromUIElement(context:Context, t:UIElement):Text {return null;}
}
