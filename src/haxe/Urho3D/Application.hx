package urho3d;

typedef Long = haxe.Int64;

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

}


