package urho3d;

 typedef HL_URHO3D_LIGHT_CASCADE_PARAMETERS = hl.Abstract<"hl_urho3d_graphics_light_cascade_parameters">;

@:hlNative("Urho3D")
abstract CascadeParameters(HL_URHO3D_LIGHT_CASCADE_PARAMETERS) {
	public function new(split1:Float,split2:Float,split3:Float,split4:Float,fadeStart:Float,biasAutoAdjust:Float = 1.0) {
		this = Create(split1,split2,split3,split4,fadeStart,biasAutoAdjust);
	}

	@:hlNative("Urho3D", "_graphics_light_cascade_parameters_create")
	private static function Create(csplit1:Single,split2:Single,split3:Single,split4:Single,fadeStart:Single,biasAutoAdjust:Single):HL_URHO3D_LIGHT_CASCADE_PARAMETERS {
		return null;
	}
}