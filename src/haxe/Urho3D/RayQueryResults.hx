package urho3d;

typedef HL_URHO3D_RAY_QUERY_RESULTS = hl.Abstract<"hl_urho3d_graphics_ray_query_results">;

@:hlNative("Urho3D")
abstract RayQueryResults(HL_URHO3D_RAY_QUERY_RESULTS) {
	public var size(get, never):Int;

	function get_size() {
		return GetSize(cast this);
	}

    
    @:arrayAccess
	public inline function getValue(i:Int):RayQueryResult {
		return GetResult(cast this,i);
    }
    

	@:hlNative("Urho3D", "_graphics_ray_query_results_get_size")
	private static function GetSize(r:RayQueryResults):Int {
		return 0;
    }
    
    
    @:hlNative("Urho3D", "_graphics_ray_query_results_get_result")
	private static function GetResult(r:RayQueryResults, i:Int):RayQueryResult {
		return null;
    }
    
}
