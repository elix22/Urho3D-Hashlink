package samplygame;

import urho3d.actions.*;
import urho3d.actions.ActionManager;
import urho3d.actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;
import samplygame.SpawnEntry.CREATE_OBJECT;

class SpawnMonitorScreenEntry extends SpawnEntry
{
	public var fromLeftSide:Bool;
    
    public function new ( _fromLeftSide:Bool = false, func:CREATE_OBJECT=null,_repeat:Int=0, _msDelay:Int=0)
	{
		super("EnemyMonitorScreen",func,_repeat,_msDelay);
		fromLeftSide = _fromLeftSide;
	}	
}
