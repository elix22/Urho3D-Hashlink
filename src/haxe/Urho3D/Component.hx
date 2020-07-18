package urho3d;

typedef HL_URHO3D_COMPONENT = hl.Abstract<"hl_urho3d_scene_component">;


class Component
{
    private var abstractComponent:AbstractComponent = null;

    public inline function new() {
        abstractComponent = new AbstractComponent();
    }
}

@:hlNative("Urho3D")
abstract AbstractComponent(HL_URHO3D_COMPONENT) {

    public inline function new() {
        this = Create(Context.context);

    }

    @:hlNative("Urho3D", "_scene_component_create")
	private static function Create(c:Context):HL_URHO3D_COMPONENT {
		return null;
    }

}