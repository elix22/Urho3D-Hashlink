package samplygame;

import urho3d.actions.*;
import urho3d.actions.ActionManager;
import urho3d.actions.ActionManager.ActionID;
import urho3d.*;
import samplygame.Globals.CollisionLayers;

class SpawnArray {
	public var array:Array<SpawnEntry> = [];

	public var repeat:Int = 0;
	public var repeatCounter:Int = 0;

	public function new() {
		repeat = 0;
		repeatCounter = 0;
	}

	public var isRepeat(get, never):Bool;

	function get_isRepeat() {
		return repeatCounter < repeat;
	}

	public var length(get, never):Int;

	function get_length() {
		return array.length;
	}

	public function ResetRepeatCounter() {
		repeatCounter = 0;
	}

	@:arrayAccess
	public  function At(idx:Int):SpawnEntry {
		if (idx >= 0 && idx < array.length) {
			return array[idx];
		} else {
			return null;
		}
	}

	@:arrayAccess
	public  function set_opIndex(idx:Int, value:SpawnEntry):SpawnEntry {
		if (idx >= 0 && idx < array.length) {
			array[idx] = value;
			return value;
		} else
			return null;
	}

	public function Clear() {
		array = [];
		repeat = 0;
		repeatCounter = 0;
	}

	public function Push(entry:SpawnEntry) {
		array.push(entry);
	}
}
