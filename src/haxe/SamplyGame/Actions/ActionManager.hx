package samplygame.actions;

import urho3d.Bone;
import urho3d.Node;
import samplygame.actions.FiniteTimeAction.FiniteTimeActionState;

// callback_fun:Void->Void

typedef CALLBACK = ActionID->Void;

class ActionID {
	public var _action:Array<ActionDef> = new Array<ActionDef>();

	public var callback:CALLBACK;

	var id:Int = 0;

	static var _index_id:Int = 0;

	public function new(action:ActionDef = null, _callback:CALLBACK = null) {
		callback = _callback;
		id = _index_id++;
		if (action != null)
			_action.push(action);
	}

	public function Push(action:ActionDef) {
		_action.push(action);
	}

	public function DeleteTargets() {
		for (i in 0..._action.length) {
			if (_action[i].Target != null) {
				_action[i].Target.Remove();
			}
		}
	}
}

class ActionGroup {
	public var _actions:Array<ActionDef> = new  Array<ActionDef>();

	public function new() {
		_actions = [];
	}

	public function Push(action:FiniteTimeAction, target:Node) {
		_actions.push(new ActionDef(action, target));
	}
}

class ActionDef {
	public var actionState:FiniteTimeActionState = null;
	public var Target(get, set):Node;

	public function new(?_actionState:FiniteTimeActionState, ?action:FiniteTimeAction, ?target:Node) {
		if (_actionState != null) {
			actionState = _actionState;
		} else if (action != null && target != null) {
			actionState = action.StartAction(target);
		}
	}

	inline function get_Target() {
		if (actionState != null && actionState.Target != null) {
			return actionState.Target;
		} else {
			return null;
		}
	}

	inline function set_Target(t) {
		if (actionState != null) {
			actionState.Target = t;
		}
		return t;
	}

	public function Step(dt:Float) {
		if (actionState != null) {
			actionState.Step(dt);
		}
	}

	public function IsDone():Bool {
		if (actionState != null) {
			return actionState.isDone;
		} else {
			return true;
		}
	}
}

class ActionManager {
	public static var actionManager:ActionManager = new ActionManager();

	private var actions:Array<ActionID>;

	public function new() {
		actions = [];
	}

	public function RemoveAllActions(?node:Node) {
		if (node == null)
			actions = [];
		else {
			for (i in 0...actions.length) {
				for (j in 0...actions[i]._action.length) {
					if (actions[i]._action[j].actionState != null && actions[i]._action[j].actionState.Target == node) {
						actions[i]._action.remove(actions[i]._action[j]);
					}
				}
			}
		}
	}

	public function AddActions(?actDef:Array<ActionDef>, ?group:ActionGroup, ?callback:CALLBACK = null) {
		if (actDef != null) {
			var id = new ActionID();
			for (i in 0...actDef.length) {
				id.Push(actDef[i]);
			}
			id.callback = callback;
			actions.push(id);
			return id;
		} else if (group != null) {
			var id = new ActionID();
			for (i in 0...group._actions.length) {
				id.Push(group._actions[i]);
			}
			id.callback = callback;
			actions.push(id);
			return id;
		} else
			return null;
	}

	public function AddAction(?actDef:ActionDef, ?action:FiniteTimeAction, ?target:Node, ?actionState:FiniteTimeActionState, ?callback:CALLBACK = null) {
		if (actDef != null) {
			var id = new ActionID(actDef, callback);
			actions.push(id);
			return id;
		} else if (action != null && target != null) {
			var actDef = new ActionDef(action, target);
			var id = new ActionID(actDef, callback);
			actions.push(id);
			return id;
		} else if (actionState != null) {
			var actDef = new ActionDef(actionState);
			var id = new ActionID(actDef, callback);
			actions.push(id);
			return id;
		} else
			return null;
	}

	public function IsRunning(?actionID:ActionID):Bool {
		if (actionID == null) {
			if (actions.length == 0) {
				return false;
			}
			return true;
		} else {
			if (actionID._action.length == 0) {
				return false;
			} else if (actionID._action.length == 1 && actionID._action[0].IsDone() == false) {
				return true;
			} else if (actionID._action.length == 2 && (actionID._action[0].IsDone() == false || actionID._action[1].IsDone() == false)) {
				return true;
			} else {
				for (i in 0...actionID._action.length) {
					if (actionID._action[i].IsDone() == false) {
						return true;
					}
				}
			}
			return false;
		}

		return false;
	}

	public function Step(timeStep:Float):Bool {
    
		if (actions.length == 0) {
			return false;
		}

		for (i in 0...actions.length) {
			var actionCountDone = 0;
			for (j in 0...actions[i]._action.length) {
				if (actions[i]._action[j].IsDone() == true) {
					actionCountDone++;
				} else {
					actions[i]._action[j].Step(timeStep);
				}
			}

			if (actionCountDone == actions[i]._action.length) {
				if (actions[i].callback != null) {
					actions[i].callback(actions[i]);
				}

				actions.remove(actions[i]);
			}
		}

		if (actions.length == 0) {
			actions = [];
			return false;
		}

		return true;
	}
}
