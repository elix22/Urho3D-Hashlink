package urho3d;

import urho3d.Component.AutoRemoveMode;
import urho3d.Component.AbstractComponent;
import urho3d.Math.IntMathDefs;

typedef HL_URHO3D_SOUND_SOURCE = hl.Abstract<"hl_urho3d_audio_sound_source">;

class SoundSource extends Component {
	public var _abstract:AbstractSoundSource = null;

	public inline function new(?abs:AbstractSoundSource) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractSoundSource();

		super(AbstractSoundSource.CastToComponent(Context.context, _abstract));
	}

	public function Play(sound:Sound, ?frequency:Float, ?gain:Float, ?panning:Float) {
		AbstractSoundSource.Play(Context.context, _abstract, sound);
	}

	public var gain(get, set):Float;

	function get_gain() {
		return AbstractSoundSource.GetGain(Context.context, _abstract);
	}

	function set_gain(g) {
		AbstractSoundSource.SetGain(Context.context, _abstract, g);
		return g;
	}

	public var autoRemoveMode(get, set):AutoRemoveMode;

	function get_autoRemoveMode() {
		return AbstractSoundSource.GetAutoRemoveMode(Context.context, _abstract);
	}

	function set_autoRemoveMode(m) {
		AbstractSoundSource.SetAutoRemoveMode(Context.context, _abstract, m);
		return m;
	}
}

@:hlNative("Urho3D")
abstract AbstractSoundSource(HL_URHO3D_SOUND_SOURCE) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toSoundSource():SoundSource {
		return new SoundSource(cast this);
	}

	@:hlNative("Urho3D", "_audio_sound_source_create")
	private static function Create(c:Context):HL_URHO3D_SOUND_SOURCE {
		return null;
	}

	@:hlNative("Urho3D", "_audio_sound_source_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractSoundSource {
		return null;
	}

	@:hlNative("Urho3D", "_audio_sound_source_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractSoundSource):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_audio_sound_source_play")
	public static function Play(c:Context, s:AbstractSoundSource, so:Sound):Void {}

	@:hlNative("Urho3D", "_audio_sound_source_set_gain")
	public static function SetGain(c:Context, s:AbstractSoundSource, gain:Single):Void {}

	@:hlNative("Urho3D", "_audio_sound_source_get_gain")
	public static function GetGain(c:Context, s:AbstractSoundSource):Single {
		return 0.0;
	}

	//

	@:hlNative("Urho3D", "_audio_sound_source_set_auto_remove")
	public static function SetAutoRemoveMode(c:Context, s:AbstractSoundSource, mode:Int):Void {}

	@:hlNative("Urho3D", "_audio_sound_source_get_auto_remove")
	public static function GetAutoRemoveMode(c:Context, s:AbstractSoundSource):Int {
		return 0;
	}
}
