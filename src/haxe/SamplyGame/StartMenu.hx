package samplygame;

import urho3d.*;
import actions.*;
import actions.ActionManager.ActionID;
import actions.ActionManager.ActionGroup;
import urho3d.LogicComponent;

class StartMenu extends LogicComponent {
	private var bigAircraft:Node = null;
	private var rotor:Node = null;
	// private Text @ textBlock;
	private var menuLight:Node = null;
	var finished:Bool = true;
	public var startPlay:Bool = false;

	public function new(?dyn:Dynamic) {
		super(dyn);
	}

	public override function DelayedStart() {
		trace("StartMenu DelayedStart");

		bigAircraft = node.CreateChild();
		var model:StaticModel = bigAircraft.CreateComponent("StaticModel");
		model.model = new Model("Models/Player.mdl");
		model.material = new Material("Materials/Player.xml");
		bigAircraft.scale = 1.2;
		bigAircraft.Rotate(new Quaternion(0, 220, 40), TS_LOCAL);
		bigAircraft.position = new Vector3(10, 2, 10);
		ActionManager.actionManager.AddAction(new RepeatForever(new Sequence(new RotateBy(1.0, 0.0, 0.0, 0.1), new RotateBy(1.0, 0.0, 0.0, -0.1))),
			bigAircraft);

		rotor = bigAircraft.CreateChild();
		var rotorModel:StaticModel = rotor.CreateComponent("StaticModel");
		rotorModel.model = new Model("Models/Box.mdl");
		rotorModel.material = new Material("Materials/Black.xml");
		rotor.scale = new Vector3(0.1, 1.6, 0.1);
		rotor.rotation = new Quaternion(0, 0, 0);
		rotor.position = new Vector3(0, -0.15, 1);
		ActionManager.actionManager.AddAction(new RepeatForever(new RotateBy(1.0, 0, 0, 360.0 * 3)), rotor);

        ActionManager.actionManager.AddAction(new EaseIn(new MoveBy(1.0, new Vector3(-10, -2, -10)), 2), bigAircraft);
        
        finished = false;
        startPlay = false;
    }

    public override function Update( timeStep:Float)
	{

		if (finished)
				return;
				
	   if (Input.GetMouseButtonDown(MOUSEB_LEFT) || Input.numTouches > 0)
	   {
			finished = true;
			// log.Warning("touched");
			 
			// ui.root.RemoveChild(textBlock,0);
			
            ActionManager.actionManager.AddAction( new EaseIn( new MoveBy(1.0,  new Vector3(-10, -2, -10)), 3),bigAircraft,this.StartPlay);		
	   }
	}
    
    function StartPlay(actionID:ActionID )
	{		
			startPlay = true;
	}

}
