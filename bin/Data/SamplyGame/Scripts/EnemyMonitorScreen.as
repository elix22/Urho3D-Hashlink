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
#include "Scripts/SmallPlates.as"

class EnemyMonitorScreen : Enemy
{
	bool fromLeftSide;

	EnemyMonitorScreen()
	{
		//log.Warning("EnemyMonitorScreen()");
		name = "EnemyMonitorScreen";
		MaxHealth = 80;
		CollisionShapeSize  = Vector3(1,1,1) / 2.0f;
	}
	
	EnemyMonitorScreen(bool _fromLeftSide)
	{
		fromLeftSide = _fromLeftSide;
	}

	void Init() override
	{
       // log.Warning("EnemyMonitorScreen::Init");
		StaticModel@ model = node.CreateComponent("StaticModel");
		model.model = cache.GetResource("Model", "Models/Enemy3.mdl");
		model.material  = cast<Material>(cache.GetResource("Material", "Materials/Enemy3.xml")).Clone("");
		node.SetScale(1.0f);

		// load weapons:	
		node.CreateScriptObject(scriptFile, "SmallPlates");
		
		float direction = fromLeftSide ? -1 : 1;
		node.position =  Vector3(3 * direction, 3, 0);
		actionManager.AddAction(MoveTo(0.5f, Vector3(1.1f * direction, 2.0f, 0)),node,CALLBACK(this.StartMoveRandomLoop));
	}
	
	void StartMoveRandomLoop(ActionID @ actionID)
	{
		//log.Warning("EnemyMonitorScreen::StartMoveRandomLoop ");
		MoveRandomly(minX: -0.3f, maxX: 0.3f, minY: -0.3f, maxY: 0.3f, duration: 1.0f);
		StartShooting();
		
	}
}