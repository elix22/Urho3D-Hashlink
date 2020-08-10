package urho3d;

import haxe.io.Bytes;

typedef HL_URHO3D_XML_FILE = hl.Abstract<"hl_urho3d_resource_xml_file">

@:hlNative("Urho3D")
abstract XMLFile(HL_URHO3D_XML_FILE) {

  
    public inline function new(name:String) {
        this = Create(Context.context,name);

    }

    @:hlNative("Urho3D", "_create_resource_xml_file")
	private static function Create(context:Context ,name:String):HL_URHO3D_XML_FILE {
		return null;
    }


}