package urho3d;

import urho3d.Application;

private typedef HL_URHO3D_APPLICATION = hl.Abstract<"hl_urho3d_application">;
abstract Dyn<T>(Dynamic) from T to T {}



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
        var stringHash:StringHash = new StringHash("test");
        trace ("stringHash" + stringHash.GetString());
        _passStringhash(this,stringHash);
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

    @:keep
    public function SubscribeToEvent(stringHash:StringHash,callback_fun:StringHash->VariantMap->Void)
    {
        _SubscribeToEvent(this,stringHash,callback_fun);
    }

    public function SubscribeToEvent2(stringHash:StringHash,callback_fun:HLDynEvent->Void) {
        _SubscribeToEvent2(this,stringHash,callback_fun);
    }

    @:hlNative("Urho3D", "_application_subscribe_to_event2")
    private static function _SubscribeToEvent2(ptr:HL_URHO3D_APPLICATION,tringHash:StringHash,callback_fun:Dyn<{stringHash:StringHash, testInt:Int,dynStringHash:Dynamic}>->Void):Void {
    }

    @:hlNative("Urho3D", "_application_subscribe_to_event")
    private static function _SubscribeToEvent(ptr:HL_URHO3D_APPLICATION,tringHash:StringHash,callback_fun:StringHash->VariantMap->Void):Void {
    }

    @:hlNative("Urho3D", "_create_application")
    private static function CreateApplication(ptr:urho3d.Context):HL_URHO3D_APPLICATION {
        return null;
    }
    

    @:hlNative("Urho3D", "_pass_stringhash")
    private static function _passStringhash(HL_URHO3D_APPLICATION,StringHash):Void {}

    @:hlNative("Urho3D", "_run_application")
    private static function RunApplication(HL_URHO3D_APPLICATION):Void {}
    
    @:hlNative("Urho3D", "_setup_closure_application")
    public static function setup_closure_application(HL_URHO3D_APPLICATION,callback_fun:Void->Void):Void {}

    @:hlNative("Urho3D", "_start_closure_application")
    public static function start_closure_application(HL_URHO3D_APPLICATION,callback_fun:Void->Void):Void {}

    @:hlNative("Urho3D", "_stop_closure_application")
    public static function stop_closure_application(HL_URHO3D_APPLICATION,callback_fun:Void->Void):Void {}
}
