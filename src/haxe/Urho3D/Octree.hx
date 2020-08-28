package urho3d;

import urho3d.RayQueryResult.RayQueryLevel;
import urho3d.Drawable.DrawableFlags;
import urho3d.Math.Mathdefs;


typedef HL_URHO3D_OCTREE = hl.Abstract<"hl_urho3d_graphics_octree">;

@:hlNative("Urho3D")
abstract Octree(HL_URHO3D_OCTREE) {
	public function RaycastSingle(r:TRay, rayQueryLevel:RayQueryLevel = RAY_TRIANGLE, maxDistance:Float = Mathdefs.M_INFINITY,
			drawableFlags:DrawableFlags = DRAWABLE_ANY, viewMask:DrawableFlags = DEFAULT_VIEWMASK):RayQueryResults {
		if (this != null)
			return _RaycastSingle(Context.context, cast this, r, rayQueryLevel, maxDistance, drawableFlags, viewMask);
		else
			return null;
	}

	@:hlNative("Urho3D", "_graphics_octree_raycast_single")
	private static function _RaycastSingle(context:Context, o:Octree, r:TRay, rayQueryLevel:Int, maxDistance:Single, drawableFlags:Int,
			viewMask:Int):RayQueryResults {
		return null;
	}
}
