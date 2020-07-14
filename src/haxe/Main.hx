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
	private final NUM_SPRITES = 100;
	private var sprites = [];



	public override function Setup() {
		trace("Setup");
	}

	public override function Start() {
		trace("Start");
		CreateSprites();
		SubscribeToEvents();
	}

	public function CreateSprites() {
		var width = Graphics.width;
		var height = Graphics.height;

		var texture = new Texture2D("Textures/UrhoDecal.dds");

		for (i in 0...NUM_SPRITES) {
			var sprite:Sprite = new Sprite();
			sprite.texture = texture;
			sprite.position = new Vector2(Random() * width, Random() * height);
			sprite.size = new IntVector2(128, 128);
			sprite.hotSpot = new IntVector2(64, 64);

			// Set random rotation in degrees and random scale
			sprite.rotation = Random() * 360.0;
			sprite.scale = new Vector2((Random() + 0.5), (Random() + 0.5));

			UI.root.AddChild(sprite);

			sprite.vars["Velocity"] = new Vector2(Random(200.0) - 100.0, Random(200.0) - 100.0);
			sprites.push(sprite);
		}
	}

	public function MoveSprites(timeStep:Single ) {
		var width = Graphics.width;
		var height = Graphics.height;

		// Go through all sprites
		for(sprite in sprites)
		{
			sprite.rotation = sprite.rotation + timeStep * 30.0;
		
			var velocity:Vector2 = sprite.vars["Velocity"];
			velocity.x *= timeStep;
			velocity.y *= timeStep;
			var newPos = sprite.position + velocity;
			if (newPos.x < 0.0)
				newPos.x += width;
			if (newPos.x >= width)
				newPos.x -= width;
			if (newPos.y < 0.0)
				newPos.y += height;
			if (newPos.y >= height)
				newPos.y -= height;
			sprite.position = newPos;

		}

	}

	public function SubscribeToEvents() {
		SubscribeToEvent("Update", HandleUpdate);
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Single = eventData["TimeStep"];
		MoveSprites(step);
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
