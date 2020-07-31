import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;

class Main {
	private static var app = null;

	static function main() {
		// app = new SpritesSample();
		 app = new AnimatingSceneSample();
		// app = new StaticSceneSample();
		 app.Run();
	}
}


/*

		trace("URho3D::Vector2 ");
		var v1 = new Vector2(10, 10);
		var v2 = new Vector2(20, 20);
		var newPos = (v1 += v2*0.3);
		trace(newPos);
		for (j in 0...10) {
			var start = Sys.time();
			for (i in 0...200000) {
				var v1 = new Vector2(10, 10);
				var v2 = new Vector2(20, 20);
				var newPos = (v1 += v2*0.3);
			}
			var end = Sys.time();
			trace("time:" + (end - start));
		}
		trace("Vector2Native ");
		var v1 = new TVector2(10, 10);
		var v2 = new TVector2(20, 20);
		var newPos = (v1 += v2*0.3);
		trace(newPos);
		for (j in 0...10) {
			var start = Sys.time();
			for (i in 0...200000) {
				var v1 = new TVector2(45.6, 45.6);
				var v2 = new TVector2(45.6, 45.6);
				var newPos = (v1 += v2*0.3);
			}
			var end = Sys.time();
			trace("time:" + (end - start));
		}

*/