package urho3d;

import urho3d.Component.AbstractComponent;
import urho3d.MathDefs.IntMathDefs;

typedef HL_URHO3D_DECALSET = hl.Abstract<"hl_urho3d_graphics_decalset">;

class DecalSet extends Component {
	public var _abstract:AbstractDecalSet = null;

	public inline function new(?abs:AbstractDecalSet) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractDecalSet();

		super(AbstractDecalSet.CastToComponent(Context.context, _abstract));
	}

	public var material(get, set):Material;

	function set_material(m) {
		AbstractDecalSet.SetMaterial(Context.context, _abstract, m);
		return m;
	}

	function get_material() {
		return AbstractDecalSet.GetMaterial(Context.context, _abstract);
	}

	public inline function AddDecal(target:Drawable, worldPosition:TVector3, worldRotation:TQuaternion, size:Float, aspectRatio:Float, depth:Float,
			topLeftUV:TVector2, bottomRightUV:TVector2, timeToLive:Float = 0.0, normalCutoff:Float = 0.1, subGeometry:Int = M_MAX_UNSIGNED) {
		AbstractDecalSet.AddDecal(Context.context, _abstract, target, worldPosition, worldRotation, size, aspectRatio, depth, topLeftUV, bottomRightUV,
			timeToLive, normalCutoff, subGeometry);
	}
}

@:hlNative("Urho3D")
abstract AbstractDecalSet(HL_URHO3D_DECALSET) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toDecalSet():DecalSet {
		return new DecalSet(cast this);
	}

	@:hlNative("Urho3D", "_graphics_decalset_create")
	private static function Create(c:Context):HL_URHO3D_DECALSET {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_decalset_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractDecalSet {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_decalset_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractDecalSet):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_decalset_set_material")
	public static function SetMaterial(c:Context, s:AbstractDecalSet, m:Material):Void {}

	@:hlNative("Urho3D", "_graphics_decalset_get_material")
	public static function GetMaterial(c:Context, s:AbstractDecalSet):Material {
		return null;
	}

	@:hlNative("Urho3D", "_graphics_decalset_add_decal")
	public static function AddDecal(c:Context, s:AbstractDecalSet, d:Drawable, t:TVector3, q:TQuaternion, s1:Single, s2:Single, s3:Single, t2:TVector2,
		t3:TVector2, s4:Single, s5:Single, i1:Int):Void {}
}
