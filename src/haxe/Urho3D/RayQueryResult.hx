package urho3d;

enum abstract RayQueryLevel(Int) to Int from Int {
	var RAY_AABB = 0;
	var RAY_OBB = 1;
	var RAY_TRIANGLE = 2;
	var RAY_TRIANGLE_UV = 3;
}

typedef HL_URHO3D_RAY_QUERY_RESULT = hl.Abstract<"hl_urho3d_graphics_ray_query_result">;

@:hlNative("Urho3D")
abstract RayQueryResult(HL_URHO3D_RAY_QUERY_RESULT) {
	public var position(get, never):TVector3;

	function get_position() {
		return GetPosition(cast this);
    }
    
    public var drawable(get,never):Drawable;

    function get_drawable()
    {
        return GetDrawable(cast this);
    }

	@:hlNative("Urho3D", "_graphics_ray_query_result_get_position")
	private static function GetPosition(r:RayQueryResult):TVector3 {
		return null;
    }
    
    //DEFINE_PRIM(HL_URHO3D_DRAWABLE, _graphics_ray_query_result_get_drawable, HL_URHO3D_RAY_QUERY_RESULT);
    @:hlNative("Urho3D", "_graphics_ray_query_result_get_drawable")
	private static function GetDrawable(r:RayQueryResult):Drawable {
		return null;
    }
}
