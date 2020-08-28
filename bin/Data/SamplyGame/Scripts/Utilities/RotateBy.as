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
class RotateBy : FiniteTimeAction
{
		 float AngleX ;
		 float AngleY ;
		 float AngleZ ;
		RotateBy (float duration, float deltaAngleX, float deltaAngleY, float deltaAngleZ)
		{
		    super (duration);
			AngleX = deltaAngleX;
			AngleY = deltaAngleY;
			AngleZ = deltaAngleZ;
		}

		RotateBy (float duration, float deltaAngle) 
		{
			 RotateBy (duration, deltaAngle, deltaAngle, deltaAngle);
		}
		

	
		FiniteTimeActionState @ StartAction (Node @ target) override
		{
			return  RotateByState (this, target);

		}

		FiniteTimeAction @ Reverse () override
		{
			return  RotateBy (Duration, -AngleX, -AngleY, -AngleZ);
		}
		
		
}

class RotateByState : FiniteTimeActionState
{
		 Quaternion StartAngles;

		 float AngleX ;

		 float AngleY;

		 float AngleZ;
		 
		 
		RotateByState(RotateBy @ action, Node @ target)		
		{ 
		    super(action, target);
			AngleX = action.AngleX;
			AngleY = action.AngleY;
			AngleZ = action.AngleZ;
			StartAngles = target.rotation;
		}


		void Step(float dt) override
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
	
		void Update (float time) override
		{
		   
			if (Target !is null)
			{
			
			   // log.Warning("Update");
			   StartAngles = Target.rotation;
				Quaternion newRot = StartAngles * Quaternion(AngleX * time, AngleY * time, AngleZ * time);
				newRot.Normalize();
				Target.rotation = newRot;
			}
		}		 
}