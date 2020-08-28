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
 	
class RotateByScript: GameObject
{
   
    ActionID actionID;
	
	void DelayedStart()
	{
		//log.Warning("RotateByScript::Start ");
		
	
		//actionManager.addAction(ActionDef(RepeatForever(RotateBy(1.0f, 1.0, 1.0f, 1.0f)),node));
		//actionManager.AddAction(RepeatForever( Sequence( RotateBy(1.0f, 0.0f, 0.0f, 5.0f),  RotateBy(1.0f, 0.0f, 0.0f, -5.0f))),node);
		//actionManager.AddAction((EaseIn(MoveBy(1.0f,  Vector3(-1, -1, -1)), 2)),node,CALLBACK(this.actionDone));
		
		
		//actionManager.addAction(RepeatForever(RotateBy(1.0f, 1.0, 1.0f, 1.0f)),node);
		
		BezierConfig	bezierConfig;
		float direction = 1.0f;
		bezierConfig.ControlPoint1 = Vector3(0, 3.0f * direction, 0);		
		bezierConfig.ControlPoint2 = Vector3(Random(-3.0f, 3.0f), 5 * direction, 0);
		bezierConfig.EndPosition =  Vector3(0, 1 * direction, 0);
		
		ActionGroup group;
		
		group.Push(BezierBy(3,bezierConfig),node);
		group.Push(DelayTime(1.0f),node);
		//actionID = actionManager.AddActions(group,CALLBACK(this.actionGroupDone));
		
		Array<FiniteTimeAction@> actions;
		actions.Push(MoveBy(1.0f,  Vector3(-1, -1, -1)));
		actions.Push(RotateBy(duration: 1.0f, deltaAngleX: 0, deltaAngleY: 360 * 5, deltaAngleZ: 0));
		actions.Push(MoveBy(1.0f,  Vector3(-1, 2, -1)));
		actionManager.AddAction(Parallel(actions),node);
		
	}
 
 


	void actionGroupDone(ActionID @ actionID)
	{
		//log.Warning("actionGroupDone actionID = " + actionID.id);
		//actionID.deleteTargets();
	}
	
	void actionDone(ActionID @ actionID)
	{
		//log.Warning("Easein actionDone actionID = " + actionID.id);
	    //actionID.deleteTargets();
		//actdef.Target.Remove();
		actionManager.AddAction((EaseIn(MoveBy(1.0f,  Vector3(1, 1, 1)), 2)),node,CALLBACK(this.actionDone2));
	}	
	
	void actionDone2(ActionID @ actionID)
	{
		//log.Warning("Easein actionDone2 actionID = " + actionID.id);
		actionManager.AddAction((EaseIn(MoveBy(1.0f,  Vector3(-1, -1, -1)), 2)),node,CALLBACK(this.actionDone));
	}
}
