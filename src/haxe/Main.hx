import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;

class Main {
	static function main() {	
		var app = new SpritesSample();
		//var app = new AnimatingSceneSample();
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
