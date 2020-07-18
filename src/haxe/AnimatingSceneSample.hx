
import urho3d.*;
import urho3d.Application;
import urho3d.Graphics.BlendMode;


class AnimatingSceneSample extends Application {

    private var scene:Scene = null;
    private var node:Node = null;
    private var component:Component = null;
    public override function Setup() {
		trace("Setup");
	}

	public override function Start() {
        trace("Start");
        
        scene = new Scene();
        trace (scene);
		SubscribeToEvents();
    }
    
    public function SubscribeToEvents() {
		SubscribeToEvent("Update", HandleUpdate);
	}

	public function HandleUpdate(eventType:StringHash, eventData:VariantMap) {
		var step:Single = eventData["TimeStep"];

	}

}