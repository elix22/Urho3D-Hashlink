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
enum ActionTag
{
	//! Default tag
	Invalid = -1
}


class FiniteTimeAction
{
	float duration;
	private int tag;
    bool isRepeatForever = false;
	
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

		FiniteTimeAction() 
		{
			isRepeatForever = false;
		}

		FiniteTimeAction (float duration)
		{
			Duration = duration;
			isRepeatForever = false;
		}
		
		
		
		FiniteTimeAction @ Reverse()
		{
			return this;
		}
		
		FiniteTimeActionState @  StartAction (Node @ target) 
		{
			return  FiniteTimeActionState (this, target);
		}
		
		FiniteTimeActionState @ StartActionState (Node @ target) 
		{
			return  FiniteTimeActionState (this, target);		
		}
		
		
}

class FiniteTimeActionState 
{


	bool firstTick;
	float duration;
	float elapsed ;
	Node @ Target;
	Node @ OriginalTarget;
	
	Array<FiniteTimeAction @> Action;

	float Duration { get{return duration;} set{duration = value;} }
	float Elapsed { get{return elapsed;}  set{elapsed = value;} }
    
	
	bool IsDone 
	{
		get
		{
			return Elapsed >= Duration || Target is null;
		}
	
	}
	
	 FiniteTimeActionState (FiniteTimeAction @ action, Node @ target)
	 {
		Action.Push(action);
		Target = target;
		OriginalTarget = target;
		Duration = action.Duration;
		Elapsed = 0.0f;
		firstTick = true;
	 }
	 
	 void Update (float time) 
	 {
	 
	 
	 
	 }
	 
	void Step(float dt)
	{
		//log.Warning("Step");
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
	
	void Stop ()
	{
		Target = null;
		
	}
	
}
