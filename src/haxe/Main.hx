import haxe.macro.Compiler.IncludePosition;
import urho3d.*;


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


class MyApplication extends Application
{
   public override function Setup() 
   {
	trace("hx MyApplication setup called ");
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
		for (i in 0...10) {
			var s = Sys.time();
			trace("fib=" + fibR(30));
			var e = Sys.time();
			trace("time:" + (e - s));
		}
*/

		var v3 = new HVector2(10, 10);
		var v4:HVector2 = {_x:10,_y:10};

		var v4:Vector2 = {x:30,y:50};
        
		var hash:StringHash = "test hash function";
/*
		trace("URho3D::Vector2 ");
		for (j in 0...10) {
			var start = Sys.time();
			for (i in 0...200000) {
				//var v1 = new Vector2(10, 10);
				//var v2 = new Vector2(20, 20);
				var v1:Vector2 = {x:10,y:10};
				var v2:Vector2 = {x:20,y:20};
				// var v3 = v1+v2;
				if(j%2 == 0)
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
