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

float BackIn(float time)
{
	const float overshoot = 1.70158f;
	
	return time * time * ((overshoot + 1) * time - overshoot);
}

float BackOut(float time)
{
	const float overshoot = 1.70158f;

	time = time - 1;
	return time * time * ((overshoot + 1) * time + overshoot) + 1;
}

float BackInOut(float time)
{
	const float overshoot = 1.70158f * 1.525f;

	time = time * 2;
	if (time < 1)
	{
		return (time * time * ((overshoot + 1) * time - overshoot)) / 2;
	}
	else
	{
		time = time - 2;
		return (time * time * ((overshoot + 1) * time + overshoot)) / 2 + 1;
	}
}

float BounceOut(float time)
{
	if (time < 1 / 2.75)
	{
		return 7.5625f * time * time;
	}
	else if (time < 2 / 2.75)
	{
		time -= 1.5f / 2.75f;
		return 7.5625f * time * time + 0.75f;
	}
	else if (time < 2.5 / 2.75)
	{
		time -= 2.25f / 2.75f;
		return 7.5625f * time * time + 0.9375f;
	}

	time -= 2.625f / 2.75f;
	return 7.5625f * time * time + 0.984375f;
}

float BounceIn(float time)
{
	return 1.0f - BounceOut(1.0f - time);
}

float BounceInOut(float time)
{
	if (time < 0.5f)
	{
		time = time * 2;
		return (1 - BounceOut(1 - time)) * 0.5f;
	}
	return BounceOut(time * 2 - 1) * 0.5f + 0.5f;
}

float SineOut(float time)
{
	return  Sin(time * M_HALF_PI);
}

float SineIn(float time)
{
	return -1.0f * Cos(time * M_HALF_PI) + 1.0f;
}

float SineInOut(float time)
{
	return -0.5f * (Cos(M_PI * time) - 1.0f);
}

float ExponentialOut(float time)
{
	return time == 1.0f ? 1.0f : (-Pow(2.0f, -10.0f * time / 1.0f) + 1.0f);
}

float ExponentialIn(float time)
{
	return time == 0.0f ? 0.0f : Pow(2.0f, 10.0f * (time / 1.0f - 1.0f)) - 1.0f * 0.001f;
}

float ExponentialInOut(float time)
{
	time /= 0.5f;
	if (time < 1)
	{
		return 0.5f * Pow(2.0f, 10.0f * (time - 1.0f));
	}
	else
	{
		return 0.5f * (-Pow(2.0f, -10.0f * (time - 1.0f)) + 2.0f);
	}
}

float ElasticIn(float time, float period)
{
	if (time == 0 || time == 1)
	{
		return time;
	}
	else
	{
		float s = period / 4;
		time = time - 1;
		return -(Pow(2, 10 * time) * Sin((time - s) * M_PI * 2.0f / period));
	}
}

float ElasticOut(float time, float period)
{
	if (time == 0 || time == 1)
	{
		return time;
	}
	else
	{
		float s = period / 4;
		return (Pow(2, -10 * time) * Sin((time - s) * M_PI * 2.0f / period) + 1);
	}
}

float ElasticInOut(float time, float period)
{
	if (time == 0 || time == 1)
	{
		return time;
	}
	else
	{
		time = time * 2;
		if (period == 0)
		{
			period = 0.3f * 1.5f;
		}

		float s = period / 4;

		time = time - 1;
		if (time < 0)
		{
			return (-0.5f * Pow(2, 10 * time) * Sin((time - s) * 2.0f*M_PI / period));
		}
		else
		{
			return (Pow(2, -10 * time) * Sin((time - s) * 2.0f*M_PI / period) * 0.5f + 1);
		}
	}
}

Vector2 CardinalSplineAt(Vector2 p0, Vector2 p1, Vector2 p2, Vector2 p3, float tension, float t)
{
	if (tension < 0.0f)
	{
		tension = 0.0f;
	}
	if (tension > 1.0f)
	{
		tension = 1.0f;
	}
	float t2 = t * t;
	float t3 = t2 * t;

	/*
	 * Formula: s(-ttt + 2tt - t)P1 + s(-ttt + tt)P2 + (2ttt - 3tt + 1)P2 + s(ttt - 2tt + t)P3 + (-2ttt + 3tt)P3 + s(ttt - tt)P4
	 */
	float s = (1 - tension) / 2;

	float b1 = s * ((-t3 + (2 * t2)) - t); // s(-t3 + 2 t2 - t)P1
	float b2 = s * (-t3 + t2) + (2 * t3 - 3 * t2 + 1); // s(-t3 + t2)P2 + (2 t3 - 3 t2 + 1)P2
	float b3 = s * (t3 - 2 * t2 + t) + (-2 * t3 + 3 * t2); // s(t3 - 2 t2 + t)P3 + (-2 t3 + 3 t2)P3
	float b4 = s * (t3 - t2); // s(t3 - t2)P4

	float x = (p0.x * b1 + p1.x * b2 + p2.x * b3 + p3.x * b4);
	float y = (p0.y * b1 + p1.y * b2 + p2.y * b3 + p3.y * b4);

	return Vector2(x, y);
}


float CubicBezier(float a, float b, float c, float d, float t)
{
	float t1 = 1.0f - t;
	return ((t1 * t1 * t1) * a + 3.0f * t * (t1 * t1) * b + 3.0f * (t * t) * (t1) * c + (t * t * t) * d);
}

float QuadBezier(float a, float b, float c, float t)
{
	float t1 = 1.0f - t;
	return (t1 * t1) * a + 2.0f * (t1) * t * b + (t * t) * c;
	
}

float DegreesToRadians(float degrees)
{
	const float degToRad = M_PI / 180.0f;
	return degrees * degToRad;
}


float RadiansToDegrees(float radians)
{
	const float radToDeg = 180.0f /  M_PI ;
	return radians * radToDeg;
}