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
class Parallel : FiniteTimeAction
{
	Array<FiniteTimeAction@>  Actions ;

	Parallel ( Array<FiniteTimeAction@> actions)
	{
		super();
		// Can't call base(duration) because max action duration needs to be determined here
		float maxDuration = 0.0f;
		
		for(uint i = 0 ; i < actions.length;i++)
		{
			if (actions[i].Duration > maxDuration)
			{
				maxDuration = actions[i].Duration;
			}
			
		}
		
	
		Duration = maxDuration;

		Actions = actions;

		for(uint i = 0 ; i < actions.length;i++)
		{
			float actionDuration = Actions[i].Duration;
			if (actionDuration < Duration)
			{
				Array<FiniteTimeAction@> tmp_actions;
				tmp_actions.Push(Actions [i]);
				tmp_actions.Push(DelayTime (Duration - actionDuration));
				//Sequence(tmp_actions);
				Actions.Erase(i);
				Actions.Insert(i,Sequence(tmp_actions));
				//Actions[i] =  Sequence (Actions [i], DelayTime (Duration - actionDuration));
			}
		}
	}
	
	FiniteTimeActionState @ StartAction (Node @ target) override
	{
		return  ParallelState (this, target);

	}

	FiniteTimeAction @ Reverse () override
	{
		Array<FiniteTimeAction@>  rev(Actions.length);
		for (uint i = 0; i < Actions.length; i++)
		{
			rev[i] = Actions [i].Reverse();
		}

		return  Parallel (rev);
	}
}

class ParallelState : FiniteTimeActionState
{

	Array<FiniteTimeAction@> Actions ;

	Array<FiniteTimeActionState@> ActionStates ;

	ParallelState (Parallel @action, Node@ target)
	{  
		super (action, target);	
		Actions = action.Actions;
		ActionStates.Resize(Actions.length);

		for (uint i = 0; i < Actions.length; i++)
		{
			ActionStates[i] = Actions[i].StartAction (target);
		}
	}

	void Stop () override
	{
		for (uint i = 0; i < Actions.length; i++)
		{
			ActionStates[i].Stop ();
		}
		
		FiniteTimeActionState::Stop();
	}

	
	void Update (float time) override
	{
		for (uint i = 0; i < Actions.length; i++)
		{
			ActionStates[i].Update(time);
		}
	}
}
