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

	public function SubscribeToEvent(stringHash:StringHash, s:String) {
		if (abstractApplication != null) {
			abstractApplication.SubscribeToEvent(stringHash, this, s);
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

	//public function Clamp<T:Int & Single & Float>(value:T, min:T, max:T) {
	public function Clamp(value:Float, min:Float, max:Float) {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}

	public function IClamp(value:Int, min:Int, max:Int) {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}

}
