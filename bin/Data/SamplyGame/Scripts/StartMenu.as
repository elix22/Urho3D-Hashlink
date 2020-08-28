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
#include "Scripts/Player.as"
#include "Scripts/Enemy.as"
#include "Scripts/EnemyBat.as"
 
 
class StartMenu: GameObject
{
	private Node @ bigAircraft;
	private Node @ rotor;
	private Text @ textBlock;
	private Node @ menuLight;
	bool finished = true;
	bool startPlay = false;
 
	void DelayedStart()
	{
		bigAircraft = node.CreateChild();
		StaticModel@ model = bigAircraft.CreateComponent("StaticModel");
		model.model = cache.GetResource("Model", "Models/Player.mdl");
		model.material  = cache.GetResource("Material", "Materials/Player.xml");
		bigAircraft.SetScale(1.2f);
		bigAircraft.Rotate( Quaternion(0, 220, 40), TS_LOCAL);
		bigAircraft.position =  Vector3(10, 2, 10);
		actionManager.AddAction(RepeatForever(Sequence(RotateBy(1.0f, 0.0f, 0.0f, 0.1f),  RotateBy(1.0f, 0.0f, 0.0f, -0.1f))),bigAircraft);
		
		
		rotor = bigAircraft.CreateChild();
		StaticModel@ rotorModel = rotor.CreateComponent("StaticModel");
		rotorModel.model = cache.GetResource("Model", "Models/Box.mdl");
		rotorModel.material  = cache.GetResource("Material", "Materials/Black.xml");	
		rotor.scale =  Vector3(0.1f, 1.6f, 0.1f);
		rotor.rotation =  Quaternion(0, 0, 0);
		rotor.position =  Vector3(0, -0.15f, 1);		
		actionManager.AddAction( RepeatForever( RotateBy(1.0f, 0, 0, 360.0f * 3)),rotor);
		
		actionManager.AddAction( EaseIn( MoveBy(1.0f,  Vector3(-10, -2, -10)), 2),bigAircraft);
		
		
		textBlock =  Text();
		textBlock.text ="TAP TO START";
		textBlock.horizontalAlignment = HA_CENTER;
		textBlock.verticalAlignment = VA_BOTTOM;
		textBlock.SetFont(cache.GetResource("Font","Fonts/Font.ttf"), graphics.width / 15);
		ui.root.AddChild(textBlock);
		
		finished = false;
		startPlay = false;
		
	}
 
 
	void Update(float timeStep)
	{
		//Base class  must be called first
		GameObject::Update(timeStep);

		if (finished)
				return;
				
	   if (input.mouseButtonDown[MOUSEB_LEFT] || input.numTouches > 0)
	   {
			finished = true;
			// log.Warning("touched");
			 
			 ui.root.RemoveChild(textBlock,0);
			
			 actionManager.AddAction( EaseIn( MoveBy(1.0f,  Vector3(-10, -2, -10)), 3),bigAircraft,CALLBACK(this.StartPlay));
			// actionManager.removeAllActions(rotor);
			
	   }
	}
	
	void StartPlay(ActionID @ actionID)
	{		
			startPlay = true;
	}

	void Stop()
	{
		//log.Warning("StartMenu stopped");
	}
}
