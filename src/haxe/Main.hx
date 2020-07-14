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

class MyApplication extends Application {

	private var counter = 0;

	public override function Setup() {
		trace("Setup");

		SubscribeToEvent("PostUpdate", HandlePostUpdate);
		SubscribeToEvent("Update", HandleUpdate);
		
	}

	public override function Start() {
		trace("Start");
		
		var texture2d = new Texture2D("Textures/UrhoDecal.dds");
		trace(texture2d);

		var sprite = new Sprite();
		trace(sprite);

		var ui_sprite:UIElement = sprite;
		trace("ui_sprite" + ui_sprite);
		
		sprite.texture = texture2d;
		for(i in 0...10)
			trace(sprite.texture.name);


		sprite.position = new Vector2(Std.random(45)+678.8,Std.random(45)+563.321);
		trace("sprite position "+sprite.position);

		sprite.size = new IntVector2(128, 128);
		trace("sprite size "+sprite.size);

		sprite.hotSpot = new IntVector2(64, 64);
		trace("sprite hotSpot "+sprite.hotSpot);

		sprite.rotation = 45.678;
		trace("sprite rotation "+sprite.rotation);

		sprite.scale = new Vector2(0.5,0.5);
		trace("sprite scale "+sprite.scale);

		sprite.vars["Velocity"] = new Vector2(35.5,65.7);
		var Velocity:Vector2 = sprite.vars["Velocity"] ;
		trace("sprite Velocity "+Velocity);

		var ui = new UIElement();
		trace("ui element " + ui);

		trace(Graphics.height);
		trace(Graphics.width);
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Single = eventData["TimeStep"];
		
		//trace("HandleUpdate hash:" + eventType.GetString() + " timestep:" + step);
	}

	public function HandlePostUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Single = eventData["TimeStep"];
	//	trace("HandlePostUpdate hash:" + eventType.GetString() + " timestep:" + step);
	}

}

class Main {
	static function main() {

		var app = new MyApplication();
		app.Run();
	}
}


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
