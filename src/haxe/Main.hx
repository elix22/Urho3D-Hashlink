import haxe.Int32;
import haxe.macro.Compiler.IncludePosition;
import urho3d.*;
import urho3d.Application;

// HASHLINK JIT
// WINDOWS :  cl /c /MD Urho3DGlue.cpp /I . /I $(HASHLINK)
// WINDOWS :  cl /LD /MD glue_native.obj "$(HASHLINK_BIN)\libhl.lib"
// LINUX : gcc -o urho3d.hdll Urho3DGlue.cpp -shared -Wall -O3 -I. -std=c11 -fPIC -I/usr/local/include -lhl -lUrho3D  -L../Urho3D/Lib
// MAC : gcc -o urho3d.hdll Urho3DGlue.cpp -shared -Wall -O3 -I. -std=c11 -I/usr/local/include -lhl -lsdl2
// haxe -main Main -hl hello.hl
// hl hello.hl
// HASHLINK C
// haxe --main Main --hl out/main.c
// gcc -O3 -o urho3d-test  -I out out/main.c  Urho3DGlue.cpp   -lhl -lUrho3D  -L../Urho3D/Lib

@:structInit class HVector2 {
	public var x:Single;
	public var y:Single;

	public function new(_x:Null<Single> = 0.0, _y:Null<Single> = 0.0) {
		if (_x != null) {
			x = _x;
		}

		if (_y != null) {
			y = _y;
		}
	}

	@:op(A += B)
	public function add(rhs:HVector2):HVector2 {
		x += rhs.x;
		y += rhs.y;

		return this;
	}
}

class MyApplication extends Application {
	public override function Setup() {
		trace("Setup");

		SubscribeToEvent("Update",HandleUpdate);
	//	SubscribeToEvent2("Update",HandleUpdate2);
		/*
		var t:Variant = 55;
		var I:Int32 = t;
		trace("int from variant " + I);

		var vc:Vector2 = {x: 203.45, y: 230.567};
		var v1:Variant = vc;
		var vc2:Vector2 = v1;
		trace("Vector2 from variant " + vc2);

		var t2:Variant = 556.4563;
		var F:Single = 45.0;
		F = t2;
		trace("Single from variant " + F);
		*/
	}

	public override function Start() {
		
		/*
		var start = Sys.time();
		for (i in 0...100000) {
			var vc:Vector2 = {x: 20, y: 20};
			var v1:Variant = vc;
			var vec:Vector2 = v1;
		}
		var end = Sys.time();
		trace("time:" + (end - start));
		*/


	}

	public function HandleUpdate( eventType:StringHash,  eventData:VariantMap)
	{
		
		var  step:Single = eventData["TimeStep"];

		trace("update hx hash:" + eventType.GetString() + " timestep:" + step );
	}

	public function HandleUpdate2(event:HLDynEvent)
	{
		//var stringHash:StringHash = event.stringHash;
		//var dynStringHash:StringHash = event.dynStringHash;
		
		//trace("HandleUpdate2 hx " + stringHash.GetString());	
		

	}
}

class Main {
	static function fibR(n:Int):Int {
		if (n < 2)
			return n;
		return (fibR(n - 2) + fibR(n - 1));
	}

	static function main() {

		/*
		var vm = new VariantMap();

		for (i in 100...110) {
			var str:String = "test" + i;
			vm[str] = i;
			var s:Int = vm[str];
			trace("got Int from Variantmap " + s);
		}

		var hash:StringHash = "test hash function";

		trace("URho3D::Vector2 ");
		for (j in 0...10) {
			var start = Sys.time();
			for (i in 0...200000) {
				var v1 = new Vector2(10, 10);
				var v2 = new Vector2(20, 20);
				// var v1:Vector2 = {x:10,y:10};
				// var v2:Vector2 = {x:20,y:20};
				// var v3 = v1+v2;
				if (j % 2 == 0)
					v1.add2(v2);
				else
					v1 += v2;
				// trace(v1);
				v1 = null;
				v2 = null;
			}
			var end = Sys.time();
			trace("time:" + (end - start));
		}
		*/

		var app = new MyApplication();
		app.Run();

		// Urho3D.create(context);
		//	Urho3D.StartUrho3DApplication();
	}
}
