package urho3d;

typedef HL_URHO3D_UIELEMENT = hl.Abstract<"hl_urho3d_uielement">;

/// %UI element horizontal alignment.
enum abstract HorizontalAlignment(Int) to Int from Int {
	var HA_LEFT = 0;
	var HA_CENTER;
	var HA_RIGHT;
	var HA_CUSTOM;
}

/// %UI element vertical alignment.
enum abstract VerticalAlignment(Int) to Int from Int {
	var VA_TOP = 0;
	var VA_CENTER;
	var VA_BOTTOM;
	var VA_CUSTOM;
}

/// %UI element corners.
enum abstract Corner(Int) to Int from Int {
	var C_TOPLEFT = 0;
	var C_TOPRIGHT;
	var C_BOTTOMLEFT;
	var C_BOTTOMRIGHT;
	var MAX_UIELEMENT_CORNERS;
}

/// %UI element orientation.
enum abstract Orientation(Int) to Int from Int {
	var O_HORIZONTAL = 0;
	var O_VERTICAL;
}

/// %UI element focus mode.
enum abstract FocusMode(Int) to Int from Int {
	/// Is not focusable and does not affect existing focus.
	var FM_NOTFOCUSABLE = 0;
	/// Resets focus when clicked.
	var FM_RESETFOCUS;
	/// Is focusable.
	var FM_FOCUSABLE;
	/// Is focusable and also defocusable by pressing ESC.
	var FM_FOCUSABLE_DEFOCUSABLE;
}

/// Layout operation mode.
enum abstract LayoutMode(Int) to Int from Int {
	/// No layout operations will be performed.
	var LM_FREE = 0;
	/// Layout child elements horizontally and resize them to fit. Resize element if necessary.
	var LM_HORIZONTAL;
	/// Layout child elements vertically and resize them to fit. Resize element if necessary.
	var LM_VERTICAL;
}

/// Traversal mode for rendering.
enum abstract TraversalMode(Int) to Int from Int {
	/// Traverse through children having same priority first and recurse into their children before traversing children having higher priority.
	var TM_BREADTH_FIRST = 0;
	/// Traverse through each child and its children immediately after in sequence.
	var TM_DEPTH_FIRST;
}

enum abstract DragAndDropMode(Int) to Int from Int {
	/// Drag and drop disabled.
	var DD_DISABLED = 0x0;
	/// Drag and drop source flag.
	var DD_SOURCE = 0x1;
	/// Drag and drop target flag.
	var DD_TARGET = 0x2;
	/// Drag and drop source and target.
	var DD_SOURCE_AND_TARGET = 0x3;
}

@:hlNative("Urho3D")
abstract UIElement(HL_URHO3D_UIELEMENT) {
	public inline function new() {
		this = Create(Context.context);
	}

	public function AddChild(t:UIElement) {
		_addChild(Context.context, this, t);
	}

	public function RemoveChild(t:UIElement, index:Int = 0) {
		_removeChild(Context.context, this, t, index);
	}

	@:hlNative("Urho3D", "_create_uielement")
	private static function Create(context:Context):HL_URHO3D_UIELEMENT {
		return null;
	}

	@:hlNative("Urho3D", "_ui_uielement_add_child")
	private static function _addChild(context:Context, t:HL_URHO3D_UIELEMENT, child:UIElement) {}

	// DEFINE_PRIM(_VOID, _ui_uielement_remove_child, URHO3D_CONTEXT HL_URHO3D_UIELEMENT HL_URHO3D_UIELEMENT _I32);

	@:hlNative("Urho3D", "_ui_uielement_remove_child")
	private static function _removeChild(context:Context, t:HL_URHO3D_UIELEMENT, child:UIElement, index:Int) {}
}
