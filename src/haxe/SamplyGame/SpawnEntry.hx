package samplygame;

import actions.*;
import actions.ActionManager;
import actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;

typedef CREATE_OBJECT = SpawnEntry->Enemy;

class SpawnEntry {
	public var name:String = "";
	public var _CreateObject:CREATE_OBJECT = null;
	public var _enemy:Array<Enemy> = [];
	public var repeat:Int = 0;
	public var repeat_counter:Int = 0;
	public var msDelay:Int = 0;

	public function new(_enemy:Dynamic = null, ?func:CREATE_OBJECT = null, ?_repeat:Int = 0, ?_msDelay:Int = 0) {
		if (_enemy != null) {
            name = Std.string(_enemy).split("$").join("");
		} else
			name = "";
		_CreateObject = func;
		repeat_counter = 0;
		repeat = _repeat;
		msDelay = _msDelay;
	}

	public var isRepeat(get, never):Bool;

	function get_isRepeat() {
		return repeat_counter - 1 < repeat;
	}

	public function ResetRepeatCounter() {
		repeat_counter = 0;
	}

	public var enemy(get, set):Enemy;

	function get_enemy() {
		if (_enemy.length > 0) {
			return _enemy[0];
		} else {
			return null;
		}
	}

	function set_enemy(value) {
		_enemy = [];
		_enemy.push(value);

		return value;
	}

	public function CreateObject():Enemy {
		if (_CreateObject != null) {
			repeat_counter++;
			_enemy = [];
			_enemy.push(_CreateObject(this));
			return _enemy[0];
		} else {
			trace("_CreateObject = NULL || repeat_counter > repeat ");
			return null;
		}
		return null;
	}
}
