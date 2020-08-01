import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;

class Main {
	private static var app = null;

	static function main() {
		// app = new SpritesSample();
		 app = new AnimatingSceneSample();
		 //app = new StaticSceneSample();
		 app.Run();
	}
}


