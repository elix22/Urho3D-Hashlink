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
class ScaleTo : FiniteTimeAction
{
	 float EndScaleX ;
	 float EndScaleY ;
	 float EndScaleZ ;


	ScaleTo (float _duration, float scale)
	{
		super(_duration);
		EndScaleX = scale;
		EndScaleY = scale;
		EndScaleZ = scale;
	}

	ScaleTo (float _duration, float scaleX, float scaleY, float scaleZ) 
	{
		super(_duration);
		EndScaleX = scaleX;
		EndScaleY = scaleY;
		EndScaleZ = scaleZ;
	}


	FiniteTimeAction @ Reverse () override
	{
		return ScaleTo (duration, EndScaleX);
	}

	FiniteTimeActionState @ StartAction (Node @ target) override
	{
		return  ScaleToState (this, target);
	}
}


class ScaleToState : FiniteTimeActionState
{
	 float DeltaX;
	 float DeltaY;
	 float DeltaZ;
	 float EndScaleX;
	 float EndScaleY;
	 float EndScaleZ;
	 float StartScaleX;
	 float StartScaleY;
	 float StartScaleZ;

	ScaleToState (ScaleTo @ action, Node @ target)
	{
		super(action, target);
		Vector3 scale = target.scale;
		StartScaleX = scale.x;
		StartScaleY = scale.y;
		StartScaleZ = scale.z;
		EndScaleX = action.EndScaleX;
		EndScaleY = action.EndScaleY;
		EndScaleZ = action.EndScaleZ;
		DeltaX = EndScaleX - StartScaleX;
		DeltaY = EndScaleY - StartScaleY;
		DeltaZ = EndScaleZ - StartScaleZ;
	}

	void Update (float time) override
	{
		if (Target !is null)
		{
			Target.scale =  Vector3(StartScaleX + DeltaX * time, StartScaleY + DeltaY * time, StartScaleZ + DeltaZ * time);
		}
	}
}