

import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;
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

class SpritesApp extends Application {
	private var NUM_SPRITES = 700;
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
			sprite.color = new Color(Random(0.5) + 0.5, Random(0.5) + 0.5, Random(0.5) + 0.5);
			sprite.blendMode = BlendMode.BLEND_ADD;
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
			var newPos = sprite.position + sprite.vars["Velocity"].GetVector2()*timeStep;
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
		var app = new SpritesApp();
		app.Run();
	}
}



/*

		
		var v1 = new Vector2(10, 10);
		var v2 = new Vector2(20, 80);
		var v3 = new Vector2(10, 10);
		trace(v1);
		trace(v1.DotProduct(v2));
		trace(v1.ProjectOntoAxis(v2));
		trace(v1.Angle(v2));
		trace(v1.Lerp(v2,0.5));
		trace(v1.Equals(v3));
		trace(v1.Equals(v2));
		trace(v1.IsInf());
		trace(v1.IsNaN());
		trace(v1.isNotEqual(v3));
		v1.Normalize();
		trace(Vector2.ZERO);
		trace(Vector2.LEFT);
		trace(Vector2.RIGHT);
		trace(Vector2.UP);
		trace(Vector2.DOWN);
		trace(Vector2.ONE);
		trace(v1);
		

		trace("URho3D::Vector2 ");
		for (j in 0...10) {
			var start = Sys.time();
			for (i in 0...200000) {
				var v1 = new Vector2(10, 10);
				var v2 = new Vector2(20, 20);
				
				if (j % 2 == 0)
				{
					var newPos = (v1 += v2*0.3);
				}
				else
				{
					var newPos = {x:v1.x + v2.x*0.3,y:v1.y + v2.y*0.3};
				}
				
			}
			var end = Sys.time();
			trace("time:" + (end - start));
		}
 */
