/*
typedef struct hl_urho3d_graphics_billboardset
{
    void *finalizer;
    SharedPtr<Urho3D::BillboardSet> ptr;
} hl_urho3d_graphics_billboardset;

#define HL_URHO3D_BILLBOARDSET _ABSTRACT(hl_urho3d_graphics_billboardset)
hl_urho3d_graphics_billboardset *hl_alloc_urho3d_graphics_billboardset();
hl_urho3d_graphics_billboardset *hl_alloc_urho3d_graphics_billboardset(BillboardSet *billboardSet);
*/

package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_BILLBOARDSET = hl.Abstract<"hl_urho3d_graphics_billboardset">;

class BillboardSet extends Component {
	public var _abstract:AbstractBillboardSet = null;

	public inline function new(?abs:AbstractBillboardSet) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractBillboardSet();

		super(AbstractBillboardSet.CastToComponent(Context.context, _abstract));
	}


}

@:hlNative("Urho3D")
abstract AbstractBillboardSet(HL_URHO3D_BILLBOARDSET) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toBillboardSet():BillboardSet {
		return new BillboardSet(cast this);
	}

	@:hlNative("Urho3D", "_graphics_billboardset_create")
	private static function Create(c:Context):HL_URHO3D_BILLBOARDSET {
		return null;
	}

	//

	@:hlNative("Urho3D", "_graphics_billboardset_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractBillboardSet {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_billboardset_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractBillboardSet):AbstractComponent {
		return null;
    }
    
    /*
DEFINE_PRIM(_VOID, _graphics_billboardset_set_material, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET HL_URHO3D_MATERIAL);
DEFINE_PRIM(HL_URHO3D_MATERIAL, _graphics_billboardset_get_material, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET);

DEFINE_PRIM(_VOID, _graphics_billboardset_set_numBillboards, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET _I32);
DEFINE_PRIM(_I32, _graphics_billboardset_get_numBillboards, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET);

DEFINE_PRIM(_VOID, _graphics_billboardset_set_sorted, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET _BOOL);
DEFINE_PRIM(_BOOL, _graphics_billboardset_get_sorted, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET);

DEFINE_PRIM(_VOID, _graphics_billboardset_commit, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET);
    */

}
