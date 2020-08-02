package urho3d;

typedef HL_URHO3D_LIGHT_BIAS_PARAMETERS = hl.Abstract<"hl_urho3d_graphics_light_bias_parameters">;

@:hlNative("Urho3D")
abstract BiasParameters(HL_URHO3D_LIGHT_BIAS_PARAMETERS) {
	public function new(constantBias:Float, slopeScaledBias:Float, normalOffset:Float = 0.0) {
		this = Create(constantBias, slopeScaledBias, normalOffset);
	}

	@:hlNative("Urho3D", "_graphics_light_bias_parameters_create")
	private static function Create(constantBias:Single, slopeScaledBias:Single, normalOffset:Single):HL_URHO3D_LIGHT_BIAS_PARAMETERS {
		return null;
	}
}
