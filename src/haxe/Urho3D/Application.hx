package urho3d;

typedef Long = haxe.Int64;

typedef HLDynEvent = {
	var stringHash:StringHash;
	var testInt:Int;
	var dynStringHash:Dynamic;
}

class Application {
	public static var application:Application = null;

	public var abstractApplication:AbstractApplication;

	public static var context = null;

	public inline function new() {
		context = new urho3d.Context();
		abstractApplication = new AbstractApplication(context);
		abstractApplication.RegisterSetupClosure(Setup);
		abstractApplication.RegisterStartClosure(Start);
		abstractApplication.RegisterStopClosure(Stop);
		application = this;

		LogicComponent.RegisterObject();
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

	public function SubscribeToEvent(?object:Object,stringHash:StringHash, s:String) {
		if (abstractApplication != null) {
			abstractApplication.SubscribeToEvent(stringHash, this, s);
		}
	}

	public inline function Random(?min:Null<Float>, ?max:Null<Float>):Float {
		var rand:Float = Std.random(1000000) / 1000000.0;
		if (min == null)
			return rand;
		else if (min != null && max == null) {
			return rand * min;
		} else {
			return rand * (max - min) + min;
		}
	}

	//public function Clamp<T:Int & Single & Float>(value:T, min:T, max:T) {
	public inline function Clamp(value:Float, min:Float, max:Float) {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}

	public inline function IClamp(value:Int, min:Int, max:Int) {
		if (value < min)
			return min;
		else if (value > max)
			return max;
		else
			return value;
	}

	public inline function IsTouchEnabled():Bool
		{
			return abstractApplication.IsTouchEnabled();
		}

}
