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
class MoveByObject
{
	private int tag;
	private float duration;
	Vector3 PositionDelta;

	int Tag 
	{ 
		get
		{
           return tag;
		}	
	   
		set
		{	   
	      tag = value;
		}   
	}

	float Duration 
	{
		get 
		{
			return duration;
		}
		set 
		{
			float newDuration = value;

			// Prevent division by 0
			if (newDuration == 0)
			{
				newDuration = 0.0000001f;
			}

			duration = newDuration;
		}
	}
		
	MoveByObject()
	{
		tag = -1;
	}

	MoveByObject (float duration)
	{
		Duration = duration;
	}

	MoveByObject (float duration, Vector3 position) 
	{
		Duration = duration;
		PositionDelta = position;
	}
	
	MoveByObject @ Reverse()
	{
		return this;
	}
	
	MoveByStatebject @ StartAction (Node @ target) 
	{
		return  MoveByStatebject (this, target);
	}
}

class MoveByStatebject
{
	Vector3 PositionDelta;
	Vector3 EndPosition;
	Vector3 StartPosition;
	Vector3 PreviousPosition;
	private bool firstTick;
	private float duration;
	private float elapsed ;

	Node @ Target;
	Node @ OriginalTarget;
	MoveByObject  Action;
	
	float Duration { get{return duration;} set{duration = value;} }
	float Elapsed { get{return elapsed;}  set{elapsed = value;} }

	MoveByStatebject (MoveByObject @ action, Node @ tar)
	{ 
		Action = action;
		Target = tar;
		OriginalTarget = tar;
		Duration = action.Duration;
		Elapsed = 0.0f;
		firstTick = true;
		PositionDelta = action.PositionDelta;
		PreviousPosition =  tar.position;
		StartPosition = tar.position;
		
	}
	
	bool IsDone 
	{
		get
		{
			return Elapsed >= Duration;
		}

	}	

    void Stop()
	{
		Target = null;
	}

	void Update (float time) 
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

