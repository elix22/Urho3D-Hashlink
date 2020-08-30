package urho3d;

import urho3d.*;

typedef URHO3D_REFCOUNTED = hl.Abstract<"urho3d_refcounted">;

@:hlNative("Urho3D")
abstract RefCounted(URHO3D_REFCOUNTED) {

    @:to
	public inline function ToNode():Node {
		return CastToTNode(Context.context,cast this);
    }

    @:to
	public inline function ToTNode():TNode {
		return CastToTNode(Context.context,cast this);
    }


    @:to
	public inline function ToRigidBody():RigidBody {
		return CastToTRigidBody(Context.context,cast this);
    }

    @:to
	public inline function ToTRigidBody():TRigidBody {
		return CastToTRigidBody(Context.context,cast this);
    }
    

    @:hlNative("Urho3D", "_container_refcounted_cast_to_t_node")
	private static function CastToTNode(c:Context, s:RefCounted):TNode {
		return null;
    }
    
    @:hlNative("Urho3D", "_container_refcounted_cast_to_t_rigid_body")
	private static function CastToTRigidBody(c:Context, s:RefCounted):TRigidBody {
		return null;
	}
}
