/*
	typedef struct hl_urho3d_graphics_drawable
	{
	void *finalizer;
	SharedPtr<Urho3D::Drawable> ptr;
	} hl_urho3d_graphics_drawable;

	#define HL_URHO3D_DRAWABLE _ABSTRACT(hl_urho3d_graphics_drawable)
	hl_urho3d_graphics_drawable *hl_alloc_urho3d_graphics_drawable(urho3d_context *context,int drawableFlags);
 */

package urho3d;

import urho3d.Node.AbstractNode;
import urho3d.Camera.AbstractCamera;
import urho3d.Scene.AbstractScene;
import urho3d.MathDefs.IntMathDefs;

enum abstract DrawableFlags(Int) to Int from Int {
	var DRAWABLE_UNDEFINED = 0x0;
	var DRAWABLE_GEOMETRY = 0x1;
	var DRAWABLE_LIGHT = 0x2;
	var DRAWABLE_ZONE = 0x4;
	var DRAWABLE_GEOMETRY2D = 0x8;
	var DRAWABLE_ANY = 0xff;
	var DEFAULT_VIEWMASK = M_MAX_UNSIGNED;
	var DEFAULT_LIGHTMASK = M_MAX_UNSIGNED;
	var DEFAULT_SHADOWMASK = M_MAX_UNSIGNED;
	var DEFAULT_ZONEMASK = M_MAX_UNSIGNED;
}

typedef HL_URHO3D_DRAWABLE = hl.Abstract<"hl_urho3d_graphics_drawable">;

@:hlNative("Urho3D")
abstract Drawable(HL_URHO3D_DRAWABLE) {
	public var node(get, never):Node;

	function get_node() {
		return new Node(_GetNode(Context.context, cast this));
	}

	@:hlNative("Urho3D", "_graphics_drawable_get_node")
	private static function _GetNode(context:Context, d:Drawable):AbstractNode {
		return null;
	}
}
