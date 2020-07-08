package urho3d;

private typedef HL_URHO3D_APPLICATION = hl.Abstract<"hl_urho3d_application">;

@:hlNative("Urho3D")
abstract Application(HL_URHO3D_APPLICATION) {

    public function new(context:urho3d.Context) 
    {
        trace("new application");
        this = CreateApplication(context);
    }

    public function Run()
    {
        RunApplication(this);
    }

    @:hlNative("Urho3D", "_create_application")
    private static function CreateApplication(ptr:urho3d.Context):HL_URHO3D_APPLICATION {
        return null;
    }
    
    @:hlNative("Urho3D", "_run_application")
    private static function RunApplication(HL_URHO3D_APPLICATION):Void {
	}
}
