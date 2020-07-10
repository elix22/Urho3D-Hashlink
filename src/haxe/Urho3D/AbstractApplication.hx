package urho3d;

private typedef HL_URHO3D_APPLICATION = hl.Abstract<"hl_urho3d_application">;

@:hlNative("Urho3D")
abstract AbstractApplication(HL_URHO3D_APPLICATION) {

    @:keep
    public function new(context:urho3d.Context) 
    {
        this = CreateApplication(context);
    }

    @:keep
    public function Run()
    {
        RunApplication(this);
    }

    @:keep
    public function RegisterSetupClosure(callback_fun:Void->Void):Void
    {
        setup_closure_application(this,callback_fun);
    }

    @:keep
    public function RegisterStartClosure(callback_fun:Void->Void):Void
    {
        start_closure_application(this,callback_fun);
    }
 
    @:keep
    public function RegisterStopClosure(callback_fun:Void->Void):Void
    {
        stop_closure_application(this,callback_fun);
    }


    @:hlNative("Urho3D", "_create_application")
    private static function CreateApplication(ptr:urho3d.Context):HL_URHO3D_APPLICATION {
        return null;
    }
    
    @:hlNative("Urho3D", "_run_application")
    private static function RunApplication(HL_URHO3D_APPLICATION):Void {}
    
    @:hlNative("Urho3D", "_setup_closure_application")
    public static function setup_closure_application(HL_URHO3D_APPLICATION,callback_fun:Void->Void):Void {}

    @:hlNative("Urho3D", "_start_closure_application")
    public static function start_closure_application(HL_URHO3D_APPLICATION,callback_fun:Void->Void):Void {}

    @:hlNative("Urho3D", "_stop_closure_application")
    public static function stop_closure_application(HL_URHO3D_APPLICATION,callback_fun:Void->Void):Void {}
}
