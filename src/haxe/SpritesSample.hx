import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;

class SpritesSample extends Application {
	final NUM_SPRITES = 700;
	private var sprites:Array<Sprite> = [];

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
			var sprite = new Sprite();
			sprite.texture = texture;
			sprite.position = new TVector2(Random() * width, Random() * height);
			sprite.size = new TIntVector2(128, 128);
			sprite.hotSpot = new TIntVector2(64, 64);

			// Set random rotation in degrees and random scale
			sprite.rotation = Random() * 360.0;
			sprite.scale = new TVector2((Random() + 0.5), (Random() + 0.5));
			sprite.color = new TColor(Random(0.5) + 0.5, Random(0.5) + 0.5, Random(0.5) + 0.5);
			sprite.blendMode = BlendMode.BLEND_ADD;
			UI.root.AddChild(sprite);

			sprite.vars["Velocity"] = new TVector2(Random(200.0) - 100.0, Random(200.0) - 100.0);
			sprites.push(sprite);
		}
	}

	public function MoveSprites(timeStep:Float) {
		var width = Graphics.width;
		var height = Graphics.height;

		// Go through all sprites
		for (sprite in sprites) {
			sprite.rotation = sprite.rotation + timeStep * 30.0;
			var newPos = sprite.position + sprite.vars["Velocity"].tvector2 * timeStep;

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
		SubscribeToEvent("Update", "HandleUpdate");
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step= eventData["TimeStep"].float;
		MoveSprites(step);
	}
}
