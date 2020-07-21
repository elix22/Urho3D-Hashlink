package urho3d;

import urho3d.Component.AbstractComponent;

typedef HL_URHO3D_LOGIC_COMPONENT = hl.Abstract<"hl_urho3d_scene_logic_component">;

class LogicComponent extends Component{
    private var abstractLogicComponent:AbstractLogicComponent = null;
    public inline function new() {
        abstractLogicComponent = new AbstractLogicComponent();
        AbstractLogicComponent.BindCallbacks(abstractLogicComponent,Start,DelayedStart,Stop,Update,PostUpdate,FixedUpdate,FixedPostUpdate);

        super(AbstractLogicComponent.CastToComponent(Context.context, abstractLogicComponent));
    }

    public function Start():Void {
		// trace("Start");
	}

	public function DelayedStart():Void {
	//	 trace(" DelayedStart  ");
	}

	public function Stop():Void {
	//	 trace("  Stop  ");
    }
    
    public function Update(timeStep:Single):Void {
	//	 trace("Update " + timeStep);
	}
    
    public function PostUpdate(timeStep:Single):Void {
      //  trace("PostUpdate " + timeStep);
    }
   
    public function FixedUpdate(timeStep:Single):Void {
       // trace("FixedUpdate " + timeStep);
    }
    
    public function FixedPostUpdate(timeStep:Single):Void {
       // trace("FixedPostUpdate " + timeStep);
    }
    
}


@:hlNative("Urho3D")
abstract AbstractLogicComponent(HL_URHO3D_LOGIC_COMPONENT) {
	public inline function new() {
		this = Create(Context.context);
	}


	@:hlNative("Urho3D", "_scene_logic_component_create")
	private static function Create(c:Context):HL_URHO3D_LOGIC_COMPONENT {
		return null;
    }

    @:hlNative("Urho3D", "_scene_logic_component_bind_callbacks")
    public static function BindCallbacks(ptr:AbstractLogicComponent,callback_start:Void->Void,callback_delayed_start:Void->Void,callback_stop:Void->Void,callback_update:Single->Void,callback_post_update:Single->Void,callback_fixed_update:Single->Void,callback_fixed_post_update:Single->Void):Void {
    }

    @:hlNative("Urho3D", "_scene_logic_component_cast_from_component")
	public static function CastFromComponent(c:Context, s:AbstractComponent):AbstractLogicComponent {
		return null;
	}

	@:hlNative("Urho3D", "_scene_logic_component_cast_to_component")
	public static function CastToComponent(c:Context, s:AbstractLogicComponent):AbstractComponent {
		return null;
	}

}