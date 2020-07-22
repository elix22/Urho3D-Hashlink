package urho3d;

typedef Long = haxe.Int64;

typedef HLDynEvent = {
	var stringHash:StringHash;
	var testInt:Int;
	var dynStringHash:Dynamic;
}

class Application {
	private static var application:Application = null;

	public var abstractApplication:AbstractApplication;

	public static var context = null;

	public inline function new() {
		context = new urho3d.Context();
		abstractApplication = new AbstractApplication(context);
		abstractApplication.RegisterSetupClosure(Setup);
		abstractApplication.RegisterStartClosure(Start);
		abstractApplication.RegisterStopClosure(Stop);
		application = this;
	}

	public function Run() {
		abstractApplication.Run();
	}

	public function Setup():Void {
		// trace("hx Application setup called ");
	}

	public function Start():Void {
		// trace("hx Application start called ");
	}

	public function Stop():Void {
		// trace("hx Application Stop called ");
	}

	public function SubscribeToEvent(stringHash:StringHash, callback_fun:StringHash->VariantMap->Void) {
		if (abstractApplication != null) {
			abstractApplication.SubscribeToEvent(stringHash, callback_fun);
		}
	}

	public function Random(?min:Null<Float>, ?max:Null<Float>):Float {
		var rand = Std.random(100000) / 100000.0;
		if (min == null)
			return rand;
		else if (min != null && max == null) {
			return rand * min;
		} else {
			return rand * (max - min) + min;
		}
	}
}
