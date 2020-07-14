package urho3d;

typedef Long = haxe.Int64;

typedef HLDynEvent = {
    var stringHash:StringHash;
    var testInt:Int;
    var dynStringHash:Dynamic;
}

class Application  
{
    public var abstractApplication:AbstractApplication;

    public static var context = null;

    public inline function new()
    {
        context = new urho3d.Context();
        abstractApplication = new AbstractApplication(context);
        abstractApplication.RegisterSetupClosure(Setup);
        abstractApplication.RegisterStartClosure(Start);
        abstractApplication.RegisterStopClosure(Stop);
    }

    public function Run()
    {
        abstractApplication.Run();
    }

    public function Setup():Void
    {
       // trace("hx Application setup called ");
    }

    public function Start():Void
    {
        //trace("hx Application start called ");
    }
    
    public function Stop():Void
    {
        //trace("hx Application Stop called ");
    }

    public function SubscribeToEvent(stringHash:StringHash,callback_fun:StringHash->VariantMap->Void) {
        abstractApplication.SubscribeToEvent(stringHash,callback_fun);
    }

    public function SubscribeToEvent2(stringHash:StringHash,callback_fun:HLDynEvent->Void) {
        abstractApplication.SubscribeToEvent2(stringHash,callback_fun);
    }

    //

}


