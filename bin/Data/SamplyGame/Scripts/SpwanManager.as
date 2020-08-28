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
#include "Scripts/Utilities/Sample.as"
#include "Scripts/EnemyBat.as" 
#include "Scripts/EnemyMonitorScreen.as"
#include "Scripts/EnemySlotMachine.as"


funcdef Enemy @ CREATE_OBJECT(SpawnEntry @ spawnEntry);


class SpawnEntry
{
	String name;
	CREATE_OBJECT @ _CreateObject;
	Array<Enemy @> _enemy;
	uint repeat ;
	uint repeat_counter;
	uint msDelay;


	SpawnEntry()
	{
		name = "";
		repeat_counter = 0;
		repeat = 0;
		msDelay = 0;
	}
	
	SpawnEntry(String _name)
	{
		name = _name;
		_CreateObject = null;
		repeat_counter = 0;
		repeat = 0;
		msDelay = 0;
	}

	SpawnEntry(String _name,CREATE_OBJECT @ func)
	{
		name = _name;
		_CreateObject = func;
		repeat_counter = 0;
		repeat = 0;
		msDelay = 0;
	}

	SpawnEntry(String _name,CREATE_OBJECT @ func,uint _repeat)
	{
		name = _name;
		_CreateObject = func;
		repeat_counter = 0;
		repeat = _repeat;
		msDelay = 0;
	}

	SpawnEntry(String _name,CREATE_OBJECT @ func,uint _repeat,uint _msDelay)
	{
		name = _name;
		_CreateObject = func;
		repeat_counter = 0;
		repeat = _repeat;
		msDelay = _msDelay;
	}
	
	bool isRepeat
	{
	  get{
		 return repeat_counter-1 < repeat;
	  }
	  
	}
	
	void ResetRepeatCounter()
	{
		repeat_counter = 0;
	}
	
	Enemy @ enemy
	{
		get
		{
			if(_enemy.length > 0)
			{
				return _enemy[0];
			}
			else{
				return null;
			}
			
		}
		
		set
		{
			_enemy.Clear();
			_enemy.Push(value);	
		}
	
	}
	
	Enemy @ CreateObject()
	{
		if(_CreateObject !is null)
		{
			repeat_counter++;
			_enemy.Clear();
			_enemy.Push(_CreateObject(this));
			return _enemy[0];
		}
		else
		{
			log.Error("_CreateObject = NULL || repeat_counter > repeat ");
		}
		return null;
	}
	

}

class SpawnMonitorScreenEntry : SpawnEntry
{
	bool fromLeftSide;
	SpawnMonitorScreenEntry()
	{
		super("EnemyMonitorScreen");
		fromLeftSide = false;
	}
	
	SpawnMonitorScreenEntry(bool _fromLeftSide)
	{
		super("EnemyMonitorScreen");
		fromLeftSide = _fromLeftSide;
	}	
	
	SpawnMonitorScreenEntry(bool _fromLeftSide,CREATE_OBJECT @ func)
	{
		super("EnemyMonitorScreen",func);
		fromLeftSide = _fromLeftSide;
	}	

	SpawnMonitorScreenEntry(bool _fromLeftSide,CREATE_OBJECT @ func,uint _repeat)
	{
		super("EnemyMonitorScreen",func,_repeat);
		fromLeftSide = _fromLeftSide;
	}	
	
	SpawnMonitorScreenEntry(bool _fromLeftSide,CREATE_OBJECT @ func,uint _repeat,uint _msDelay)
	{
		super("EnemyMonitorScreen",func,_repeat,_msDelay);
		fromLeftSide = _fromLeftSide;
	}	
}

class SpawnArray
{
	Array<SpawnEntry @> array;
	
	
	uint _repeat = 0;
	uint repeat_counter = 0;
	
	SpawnArray()
	{
		 _repeat = 0;
		 repeat_counter = 0;
	}
	
	uint repeat
	{
		get
		{
			return _repeat;
		}
		
		set
		{
			_repeat = value;
		}
		
	
	}
	
	uint repeatCounter
	{
		get
		{
			return repeat_counter;
		}
		
		set
		{
			repeat_counter = value;
		}	
	
	}
	
	bool isRepeat
	{
	  get{
		 return repeat_counter < _repeat;
	  }
	  
	}
	
	uint length
	{
		get{
			return array.length;
		}
	}
	
	void ResetRepeatCounter()
	{
		repeat_counter = 0;
	}
	
	
	SpawnEntry @ get_opIndex(uint idx) const       
	{ 
		if(idx >= 0 && idx < array.length)
		{
			return array[idx];
		}
		else{
			return null;
		}
		
	}
    
	void set_opIndex(uint idx, SpawnEntry @ value) 
	{ 
		if(idx >= 0 && idx < array.length)
		{
			array[idx] = value;
		}	
	}
	
	SpawnArray()
	{
	
	}
	
	void Clear()
	{
		array.Clear();
		_repeat = 0;
		repeat_counter = 0;
	}
	
	void Push(SpawnEntry @entry)
	{
		array.Push(entry);
	}
	
}
