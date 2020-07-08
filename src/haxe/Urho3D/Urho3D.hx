package urho3d;


@:hlNative("Urho3D")
class Urho3D
{


	public static function StartUrho3DApplication():Void {
	}

	public  static function create(context:urho3d.Context)
	{
		CreateApp(context);
	}

	public static function CreateApp(ptr:urho3d.Context):Void {
	}

}


