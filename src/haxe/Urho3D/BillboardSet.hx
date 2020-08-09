package urho3d;

import urho3d.Component.AbstractComponent;


typedef HL_URHO3D_POD_BILLBOARD = hl.Abstract<"hl_urho3d_graphics_pod_billboard">;

@:hlNative("Urho3D")
abstract BillboardPOD(HL_URHO3D_POD_BILLBOARD) {


    @:arrayAccess
	public inline function GetBillboard(i:Int):Billboard {
		return _GetBillboard(Context.context,cast this,i);
    }
    @:hlNative("Urho3D", "_graphics_billboardset_get_billboard_from_pod")
	private static function _GetBillboard(c:Context,b:BillboardPOD,i:Int):Billboard {
		return null;
    }
}


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

	public inline function Commit() {
		AbstractBillboardSet.Commit(Context.context, _abstract);
	}

	public inline function GetBillboard(i:Int):Billboard {
		return AbstractBillboardSet.GetBillboard(Context.context, _abstract, i);
	}

	public var numBillboards(get, set):Int;

	function set_numBillboards(n) {
		AbstractBillboardSet.SetNumBillboards(Context.context, _abstract, n);
		return n;
	}

	function get_numBillboards() {
		return AbstractBillboardSet.GetNumBillboards(Context.context, _abstract);
	}

	public var sorted(get, set):Bool;

	function set_sorted(s) {
		AbstractBillboardSet.SetSorted(Context.context, _abstract, s);
		return s;
	}

	function get_sorted() {
		return AbstractBillboardSet.GetSorted(Context.context, _abstract);
	}

	public var material(get, set):Material;

	function set_material(m) {
		AbstractBillboardSet.SetMaterial(Context.context, _abstract, m);
		return m;
	}

	function get_material() {
		return AbstractBillboardSet.GetMaterial(Context.context, _abstract);
	}

	public var billboards(get, never):BillboardPOD;

	function get_billboards() {
		return AbstractBillboardSet.GetBillboards(Context.context, _abstract);
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

	@:hlNative("Urho3D", "_graphics_billboardset_set_material")
	public static function SetMaterial(c:Context, s:AbstractBillboardSet, m:Material):Void {}

	@:hlNative("Urho3D", "_graphics_billboardset_get_material")
	public static function GetMaterial(c:Context, s:AbstractBillboardSet):Material {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_billboardset_set_numBillboards")
	public static function SetNumBillboards(c:Context, s:AbstractBillboardSet, m:Int):Void {}

	@:hlNative("Urho3D", "_graphics_billboardset_get_numBillboards")
	public static function GetNumBillboards(c:Context, s:AbstractBillboardSet):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_graphics_billboardset_set_sorted")
	public static function SetSorted(c:Context, s:AbstractBillboardSet, m:Bool):Void {}

	@:hlNative("Urho3D", "_graphics_billboardset_get_sorted")
	public static function GetSorted(c:Context, s:AbstractBillboardSet):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_graphics_billboardset_get_billboard")
	public static function GetBillboard(c:Context, s:AbstractBillboardSet, m:Int):Billboard {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_billboardset_get_billboards")
	public static function GetBillboards(c:Context, s:AbstractBillboardSet):BillboardPOD {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_billboardset_get_billboard_from_pod")
	public static function GetBillboardFromPOD(c:Context, s:BillboardPOD, m:Int):Billboard {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_billboardset_commit")
	public static function Commit(c:Context, s:AbstractBillboardSet):Void {}
}
