package urho3d;

private typedef HL_URHO3D_APPLICATION = hl.Abstract<"hl_urho3d_application">;

@:hlNative("Urho3D")
abstract AbstractApplication(HL_URHO3D_APPLICATION) {


    public function new(context:urho3d.Context) 
    {
        trace("new application");
        this = CreateApplication(context);
        setup_closure_application(this,Setup);
        start_closure_application(this,Start);
        stop_closure_application(this,Stop);
    }


    public function Run()
    {
        RunApplication(this);
    }

    public  function Setup():Void
    {
        trace("hx setup called ");
    }

    public  function Start():Void
    {
        trace("hx start called ");
    }

    public  function Stop():Void
    {
        trace("hx Stop called ");
    }

    public function RegisterSetupClosure(callback_fun:Void->Void):Void
    {
        setup_closure_application(this,callback_fun);
    }

    public function RegisterStartClosure(callback_fun:Void->Void):Void
    {
        start_closure_application(this,callback_fun);
    }
 
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
