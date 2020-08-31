package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_PARTICLE_EMITTER_2D = hl.Abstract<"hl_urho3d_urho2d_particle_emitter2d">;

class ParticleEmitter2D extends Component {
	public var _abstract:AbstractParticleEmitter2D = null;

	public inline function new(?abs:AbstractParticleEmitter2D) {
		if (abs != null)
			_abstract = abs;
		else
			_abstract = new AbstractParticleEmitter2D();

		super(AbstractParticleEmitter2D.CastToComponent(Context.context, _abstract));
    }
    
    public var effect(get,set):ParticleEffect2D;

    function get_effect() {
        return AbstractParticleEmitter2D.GetEffect(Context.context,_abstract);
    }

    function set_effect(e) {
        AbstractParticleEmitter2D.SetEffect(Context.context,_abstract,e);
        return e;
    }

}

@:hlNative("Urho3D")
abstract AbstractParticleEmitter2D(HL_URHO3D_PARTICLE_EMITTER_2D) {
	public inline function new() {
		this = Create(Context.context);
	}

	@:to
	public inline function toParticleEmitter2D():ParticleEmitter2D {
		return new ParticleEmitter2D(cast this);
	}

	@:hlNative("Urho3D", "_urho2d_particle_emitter2d_create")
	private static function Create(c:Context):HL_URHO3D_PARTICLE_EMITTER_2D {
		return null;
	}

	@:hlNative("Urho3D", "_urho2d_particle_emitter2d_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractParticleEmitter2D {
		return null;
	}

	@:hlNative("Urho3D", "_urho2d_particle_emitter2d_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractParticleEmitter2D):AbstractComponent {
		return null;
	}

	@:hlNative("Urho3D", "_urho2d_particle_emitter2d_set_effect")
	public static function SetEffect(c:Context, s:AbstractParticleEmitter2D, e:ParticleEffect2D):Void {}

	@:hlNative("Urho3D", "_urho2d_particle_emitter2d_get_effect")
	public static function GetEffect(c:Context, s:AbstractParticleEmitter2D):ParticleEffect2D {
		return null;
	}
}
