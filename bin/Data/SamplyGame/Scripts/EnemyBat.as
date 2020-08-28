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
#include "Scripts/Enemy.as"
#include "Scripts/BigWhiteCube.as"

class EnemyBat : Enemy
{

	EnemyBat()
	{
		MaxHealth = 30;
		name = "EnemyBat";
	}

	/*
	void DelayedStart()
	{
		log.Warning("EnemyBat::DelayedStart ");
		Play();
	}
	*/
	
	void Init() override
	{
		StaticModel@ model = node.CreateComponent("StaticModel");
		model.model = cache.GetResource("Model", "Models/Enemy1.mdl");
		model.material  = cast<Material>(cache.GetResource("Material", "Materials/Enemy1.xml")).Clone("");
		node.SetScale(Random(0.5f, 0.8f));
		node.position =  Vector3(Random(-2.0,2.0), 5.0f, 0.0f);
		
		
		// load weapons:	
		node.CreateScriptObject(scriptFile, "BigWhiteCube");
		
        float fb = Random(1);
		int b = (fb > 0.5f) ? 1:0;
		node.position = Vector3(3 * ((b == 1) ? 1 : -1), Random(0, 2), 0);
		actionManager.AddAction(MoveTo(1.0f, Vector3(Random(-2, 2), Random(2, 4), 0)),node,CALLBACK(this.StartMoveRandomLoop));
	
		//actionManager.AddAction(MoveTo(5.0f, Vector3(Random(-2, 2), Random(2, 4), 0)),node,CALLBACK(this.RemoveTargets));
	//	StartShooting();
	}
	
	void StartMoveRandomLoop(ActionID @ actionID)
	{
		//log.Warning("EnemyBat::StartMoveRandomLoop ");
		MoveRandomly(minX: -2.0f, maxX: 2.0f, minY: -1.0f, maxY: 1.0f, duration: 0.5f);
		StartShooting();
		
	}
	
	void RemoveTargets(ActionID @ actionID)
	{
		actionID.DeleteTargets();
	}

}