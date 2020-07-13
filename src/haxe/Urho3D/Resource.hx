package urho3d;

import haxe.io.Bytes;

typedef HL_URHO3D_RESOURCE = hl.Abstract<"hl_urho3d_resource">;

@:hlNative("Urho3D")
abstract Resource(HL_URHO3D_RESOURCE) {

  
    public inline function new(type:StringHash,name:String) {
        this = Create(Context.context,type,name);

    }

   

    @:hlNative("Urho3D", "_create_resource")
	private static function Create(context:hl.Abstract<"urho3d_context"> ,type:StringHash,name:String):HL_URHO3D_RESOURCE {
		return null;
    }


}