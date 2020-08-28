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
class BezierConfig
{
	 Vector3 ControlPoint1;
	 Vector3 ControlPoint2;
	 Vector3 EndPosition;
}

 class BezierBy : FiniteTimeAction
	{
		BezierConfig BezierConfig ;


		BezierBy (float t, BezierConfig config) 
		{
			super (t);
			BezierConfig = config;
		}


		FiniteTimeActionState @ StartAction (Node @ target) override
		{
			return  BezierByState (this, target);

		}

		FiniteTimeAction @ Reverse () override
		{
			BezierConfig r;

			r.EndPosition = -BezierConfig.EndPosition;
			r.ControlPoint1 = BezierConfig.ControlPoint2 + -BezierConfig.EndPosition;
			r.ControlPoint2 = BezierConfig.ControlPoint1 + -BezierConfig.EndPosition;

			return BezierBy (Duration, r);
		}
	}

	 class BezierByState : FiniteTimeActionState
	{
		BezierConfig BezierConfig ;

		Vector3 StartPosition ;

		Vector3 PreviousPosition ;


		BezierByState (BezierBy  @ action, Node @ target)
		{ 
			super(action, target);
			BezierConfig = action.BezierConfig;
			PreviousPosition = target.position;
			StartPosition = target.position;
		}

		void Update (float time) override
		{
			if (Target !is null)
			{
				float xa = 0;
				float xb = BezierConfig.ControlPoint1.x;
				float xc = BezierConfig.ControlPoint2.x;
				float xd = BezierConfig.EndPosition.x;

				float ya = 0;
				float yb = BezierConfig.ControlPoint1.y;
				float yc = BezierConfig.ControlPoint2.y;
				float yd = BezierConfig.EndPosition.y;

				float za = 0;
				float zb = BezierConfig.ControlPoint1.z;
				float zc = BezierConfig.ControlPoint2.z;
				float zd = BezierConfig.EndPosition.z;

				float x = CubicBezier (xa, xb, xc, xd, time);
				float y = CubicBezier (ya, yb, yc, yd, time);
				float z = CubicBezier (za, zb, zc, zd, time);

				Vector3 currentPos = Target.position;
				Vector3 diff = currentPos - PreviousPosition;
				StartPosition = StartPosition + diff;

				Vector3 newPos = StartPosition +  Vector3 (x, y, z);
				Target.position = newPos;

				PreviousPosition = newPos;
			}
		}

	}
