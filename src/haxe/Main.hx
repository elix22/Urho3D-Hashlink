import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;

class Main {
	private static var app = null;

	static function main() {
		//	 app = new SpritesSample();
		//app = new AnimatingSceneSample();
		//	 app = new StaticSceneSample();
		// app = new SkeletalAnimationSample();
		//	app = new BillboardsSample();
		//	app = new DecalsSample();
		// app = new MultipleViewportsSample();
		// app = new RenderToTextureSample();
		// app = new PhysicsSample();
		app = new RagdollsSample();
		app.Run();
	}
}
