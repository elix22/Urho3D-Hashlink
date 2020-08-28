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
class MoveBy : FiniteTimeAction
{
	Vector3 PositionDelta;
	
	
	MoveBy (float duration, Vector3 position) 
	{
		super (duration);
		PositionDelta = position;
	}

		
	FiniteTimeActionState @  StartAction (Node @ target) override
	{
		return  MoveByState (this, target);
	}
	
    FiniteTimeAction @ Reverse () override
	{
		return  MoveBy (Duration,  Vector3(-PositionDelta.x, -PositionDelta.y, -PositionDelta.z));
	}
	

}

class MoveByState : FiniteTimeActionState
{
	 Vector3 PositionDelta;
	 Vector3 EndPosition;
	 Vector3 StartPosition;
	 Vector3 PreviousPosition;
	
	MoveByState (MoveBy @ action, Node @ tar)
	{ 
		super(action, tar);
		PositionDelta = action.PositionDelta;
		PreviousPosition = tar.position;
		StartPosition = tar.position;
		
	}

	void Step(float dt) override
	{

		if (firstTick)
		{
			firstTick = false;
			elapsed = 0.0f;
		}
		else
		{
			elapsed += dt;
		}

		Update (Max (0.0f,Min (1.0f, Elapsed / Max (Duration, 0.0000001))));
	}
	
	void Update (float time) override
	{
	
		if (Target is null)
			return;
		
		Vector3 currentPos = Target.position;
		Vector3 diff = currentPos - PreviousPosition;
		StartPosition = StartPosition + diff;
		Vector3 newPos = StartPosition + PositionDelta * time;
		Target.position = newPos;
		PreviousPosition = newPos;			
			
	}
	
}
