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
#include "Scripts/Globals.as" 
#include "Scripts/Aircraft.as" 


class Enemy : Aircraft
{

	Enemy()
	{
		CollisionLayer = CollisionLayers::Enemy;
	}
	
	void Init() override
	{
		actionManager.AddAction( MoveBy(0.6f, Vector3(0, -2, 0)),node,CALLBACK(this.InitializedDone));	
	}
	
	void InitializedDone(ActionID @ actionID)
	{
		MoveRandomly(minX: 1, maxX: 2, minY: -3, maxY: 3, duration: 1.5f);
		StartShooting();	
	}
	
	void StartShooting()
	{
		Array<Component@>@ scriptInstances = node.GetComponents("ScriptInstance");
		
		if(IsAlive)
		{
			for (uint i = 0; i < scriptInstances.length; ++i)
			{
				ScriptInstance@ instance = cast<ScriptInstance>(scriptInstances[i]);
				Weapon@ weapon = cast<Weapon>(instance.scriptObject);
				if(weapon !is null)
				{
					weapon.FireAsync(false);
				}
			}
			
			actionManager.AddAction( DelayTime(Random(0.1f, 0.5f)),node,CALLBACK(this.ShootingLoop));	
		}		
	}
	
	void ShootingLoop(ActionID @ actionID)
	{
		if(IsAlive)
		{
			StartShooting();
		}		
	}
	
	void MoveRandomly(float minX, float maxX, float minY, float maxY, float duration)
	{
		if(IsAlive)
		{
			FiniteTimeAction @ moveAction =  MoveBy(duration, Vector3(Random(minX, maxX), Random(minY, maxY), 0));
			actionManager.AddAction(Sequence(moveAction, moveAction.Reverse()),node,CALLBACK(this.MoveRandomLoop));
		}
	}
	
	void MoveRandomLoop(ActionID @ actionID)
	{
		if(IsAlive)
		{
			MoveRandomly(minX: 1, maxX: 2, minY: -3, maxY: 3, duration: 1.5f);
		}
	}
	
	void Update(float timeStep) 
	{
		//Base class  must be called first
		GameObject::Update(timeStep);

		node.LookAt(Vector3(0, -3, 0),  Vector3(0, 1, -1), TS_WORLD);
		
	}
	
}