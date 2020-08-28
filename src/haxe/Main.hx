
import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;
import samplygame.*;


class Main {
	private static var app = null;

	static function main() {
		//	 app = new SpritesSample();
		//	app = new AnimatingSceneSample();
		//	 app = new StaticSceneSample();
		// app = new SkeletalAnimationSample();
		//	app = new BillboardsSample();
		//	app = new DecalsSample();
		 //  app = new MultipleViewportsSample();
		// app = new RenderToTextureSample();
		// app = new PhysicsSample();
		//	app = new RagdollsSample();
		//app = new CharacterDemoSample();
		app = new SamplyGame();
		app.Run();
	}
}


///hl --hot-reload  main.hl
/*
class Main {

	macro static function randomValue() {
		return macro $v{100000 + Std.random(1000)};
	}

	#if !macro

	@:hlNative("std","sys_check_reload")
	static function check_reload() return false;

	static function foo() {
		return randomValue();
	}
	
	static function reload() {
		Sys.sleep(1); // make sure timestamp is different
		Sys.command("haxe",["-cp","src/haxe","-hl","main.hl","-main","Main"]);
		Sys.println(check_reload() ? "Module Reloaded" : "Module not reloaded");
	}

	static function main() {
		while( true ) {
			Sys.println(foo());
			reload();
		}
	}
	
	#end
	
}
*/
