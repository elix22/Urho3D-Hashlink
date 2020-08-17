package urho3d;

enum abstract FileMode(Int) from Int to Int
{
    var FILE_READ = 0;
    var FILE_WRITE;
    var FILE_READWRITE;
}

typedef HL_URHO3D_FILE = hl.Abstract<"hl_urho3d_io_file">;

@:hlNative("Urho3D")
abstract File(HL_URHO3D_FILE) {
	public inline function new(name:String,mode:FileMode) {
		this = Create(Context.context,name,mode);
	}

	@:hlNative("Urho3D", "_io_file_create")
	private static function Create(context:Context,name:String,mode:Int):HL_URHO3D_FILE {
		return null;
	}
}
