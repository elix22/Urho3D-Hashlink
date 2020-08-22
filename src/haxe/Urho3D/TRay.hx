package urho3d;

typedef HL_URHO3D_T_RAY = hl.Abstract<"hl_urho3d_math_t_ray">;

@:hlNative("Urho3D")
abstract TRay(HL_URHO3D_T_RAY) {
	public inline function new(origin:TVector3, direction:TVector3) {
		this = Create(origin, direction);
	}


    @:to
	public inline function toRay():Ray {
		return CastToRay(cast this);
	}

	@:from
	public static inline function fromRay(v:Ray):TRay {
		return CastFromRay(v);
    }
    
	@:hlNative("Urho3D", "_math_t_ray_create")
	private static function Create(o:TVector3, d:TVector3):HL_URHO3D_T_RAY {
		return null;
    }
    

    @:hlNative("Urho3D", "_math_t_ray_cast_to_ray")
	private static function CastToRay(o:TRay):Ray {
		return null;
    }

    @:hlNative("Urho3D", "_math_t_ray_cast_from_ray")
	private static function CastFromRay(o:Ray):TRay {
		return null;
    }
}
