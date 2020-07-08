package urho3d;

private typedef _URHO3D_APPLICATION_ = hl.Abstract<"urho3d_application">;

@:hlNative("Urho3D")
abstract Application(_URHO3D_APPLICATION_) {

    public function new(context:urho3d.Context) 
    {
        this = CreateApplication(context);
    }


    private static function CreateApplication(ptr:urho3d.Context):_URHO3D_APPLICATION_ {
        return null;
	}
}
