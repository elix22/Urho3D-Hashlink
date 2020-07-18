package urho3d;

typedef URHO3D_CONTEXT = hl.Abstract<"urho3d_context">;

@:hlNative("Urho3D")
abstract Context(URHO3D_CONTEXT) {

    public static var context:Context = null;
    public inline function new() 
    {
        this = CreateContext();
        context = cast this;
    }

    @:hlNative("Urho3D","_create_context")
    private static function CreateContext():URHO3D_CONTEXT {
        return null;
	}
}
