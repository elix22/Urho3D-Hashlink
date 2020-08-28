/**
MIT License

Copyright (c) 2020 Xamarin
Copyright (c) 2020 Eli Aloni (https://github.com/elix22)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
#include "Scripts/Utilities/Math.as"
#include "Scripts/Utilities/FiniteTimeAction.as"
#include "Scripts/Utilities/MoveBy.as"
#include "Scripts/Utilities/MoveTo.as"
#include "Scripts/Utilities/RotateBy.as"
#include "Scripts/Utilities/RepeatForever.as"
#include "Scripts/Utilities/ExtraAction.as"
#include "Scripts/Utilities/Sequence.as"
#include "Scripts/Utilities/ActionEase.as"
#include "Scripts/Utilities/EaseRateAction.as"
#include "Scripts/Utilities/EaseIn.as"
#include "Scripts/Utilities/EaseOut.as"
#include "Scripts/Utilities/BezierBy.as"
#include "Scripts/Utilities/DelayTime.as"
#include "Scripts/Utilities/ScaleTo.as"
#include "Scripts/Utilities/Parallel.as"
#include "Scripts/Utilities/EaseBackInOut.as"



funcdef void CALLBACK(ActionID @ actionID);
uint _index_id = 0;
class ActionID
{
	Array<ActionDef @> _action;
	CALLBACK @ callback;
	uint id =0;
	
	ActionID()
	{
		callback = null;
		id = _index_id++;
	}
	
	ActionID(ActionDef @ action,CALLBACK @ _callback = null )
	{
		callback =_callback;
		id = _index_id++;
		_action.Push(action);
	}
	
	void Push(ActionDef @ action)
	{
		_action.Push(action);
	}
	

	void DeleteTargets()
	{
		for(uint i = 0 ; i < _action.length ; i++)
		{
			if(_action[i].Target !is null)
			{
				_action[i].Target.Remove();
			}
		}		
	}
	
	
}

class ActionGroup
{
	Array<ActionDef @> _actions;

	ActionGroup()
	{
	
	}
	
	void Push(FiniteTimeAction  @ action , Node @ target)
	{
	    ActionDef def(action , target);
		_actions.Push(def);
	}
}


class ActionDef
{
	FiniteTimeActionState @ actionState;
	
	Node @ Target{
		get{
			if(actionState !is null && actionState.Target !is null)
			{
				return actionState.Target;
			}
			else{
				return null;
			}
		}
		
		set
		{
			if(actionState !is null)
			{
				actionState.Target = null;
			}
		}
		
	}
	
	ActionDef()
	{
		
	}
	
	ActionDef( Node @ target )
	{
	}
	
	ActionDef(FiniteTimeAction  @ action , Node @ target)
	{
	   //  log.Warning("ActionDef : " );
		actionState = action.StartAction(target);
	}
	
	ActionDef(FiniteTimeActionState @ _actionState)
	{
		actionState = _actionState;
	}
	
	void Step(float dt)
	{
		if(actionState !is null)
		{		    
			actionState.Step(dt);
		}
	}
	
	bool IsDone()
	{
		if(actionState !is null)
		{
			return actionState.IsDone ;
		}
		else
		{
			return true;
		}
	}
	
	
	
}

class ActionManager
{
	private Array<ActionID @> actions;

	void RemoveAllActions()
	{
		actions.Clear();
	}
	
	void RemoveAllActions(Node @ node)
	{
		for(uint i = 0 ; i < actions.length ; i++)
		{
			for(uint j = 0 ; j < actions[i]._action.length;j++)
			{
				if(actions[i]._action[j].actionState !is null && actions[i]._action[j].actionState.Target is node)
				{
					actions[i]._action.Erase(j);
				}
			}
		}
	}
	
	ActionID @ AddActions(ActionDef  [] actDef,CALLBACK  @ callback = null)
	{
		ActionID id;
		for(uint i = 0 ; i < actDef.length ; i++)
		{
			id.Push(actDef[i]);
		}
		id.callback = callback;
		actions.Push(id);
		return id;
	}

	ActionID @ AddActions(ActionGroup @ group,CALLBACK  @ callback = null)
	{
		ActionID id;
		for(uint i = 0 ; i < group._actions.length ; i++)
		{
			id.Push(group._actions[i]);		
		}
		id.callback = callback;
		actions.Push(id);
		return id;
	}
	
	ActionID @ AddAction(ActionDef @ actDef,CALLBACK  @ callback = null)
	{
        ActionID id(actDef);
		id.callback = callback;
		actions.Push(id);
		return id;
	}
	
	ActionID @ AddAction(FiniteTimeAction  @ action , Node @ target,CALLBACK  @ callback = null)
	{
		ActionDef actDef(action,target);
		ActionID id(actDef);
		id.callback = callback;
		actions.Push(id);
		return id;		
	}
	
	
	ActionID @ AddAction(FiniteTimeActionState @ actionState,CALLBACK  @ callback = null)
	{
		ActionDef actDef(actionState);		
		ActionID id(actDef);
		id.callback = callback;
		actions.Push(id);
		return id;	
	}
	
	bool IsRunning(ActionID  actionID)
	{
		if(actionID._action.length == 0)
		{
			return false;
		}
		else if(actionID._action.length == 1 && actionID._action[0].IsDone() == false)
		{
			return true;
		}
		else if(actionID._action.length == 2 
				&& (actionID._action[0].IsDone() == false
				|| actionID._action[1].IsDone() == false))
		{
			return true;
		}
		else
		{
			for(uint i =0 ; i < actionID._action.length ; i++)
			{
				if(actionID._action[i].IsDone() == false)
				{
				   return true;
				}
			}
		}
		
		
		return false;
	}
	
	bool IsRunning()
	{
		if(actions.length == 0)
		{
			return false;
		}	

		return true;			
	}
	
	bool Step(float timeStep)
	{
	
		if(actions.length == 0)
		{
			return false;
		}
		

		for(uint i = 0 ; i < actions.length ; i++)
		{
			uint actionCountDone = 0;
			for(uint j = 0 ; j < actions[i]._action.length;j++)
			{
				
				if(actions[i]._action[j].IsDone() == true)
				{	
					actionCountDone++;
				}	
				else
				{
					actions[i]._action[j].Step(timeStep);
				}				
			}	
			
			if(actionCountDone == actions[i]._action.length)
			{
				if(actions[i].callback !is null)
				{
					actions[i].callback(actions[i]);
				}
				
				actions.Erase(i);
			}			
		}
		
		if(actions.length == 0)
		{
			//log.Warning("step actions.Clear() ");
			actions.Clear();
			
			return false;
		}
		
		return true;
	}
}

