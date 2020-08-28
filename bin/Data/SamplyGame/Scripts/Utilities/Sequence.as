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
class Sequence : FiniteTimeAction
{
	Array<FiniteTimeAction@> Actions ;

	Sequence (FiniteTimeAction @ action1, FiniteTimeAction @ action2) 
	{
	    super(action1.Duration + action2.Duration);
		InitSequence (action1, action2);
	}

	Sequence (Array<FiniteTimeAction@> actions)
	{
		super();

		FiniteTimeAction @  prev = actions [0];

		// Can't call base(duration) because we need to calculate duration here
		float combinedDuration = 0.0f;
		for(uint i = 0 ; i < actions.length;i++)
		{
			combinedDuration += actions[i].Duration;
		}
		
		Duration = combinedDuration;

		if (actions.length == 1)
		{
			InitSequence (prev,  ExtraAction ());
		}
		else
		{
			// Basically what we are doing here is creating a whole bunch of 
			// nested Sequences from the actions.
			for (uint i = 1; i < actions.length - 1; i++)
			{
				prev =  Sequence (prev, actions [i]);
			}

			InitSequence (prev, actions [actions.length - 1]);
		}

	}

	void InitSequence (FiniteTimeAction @ actionOne, FiniteTimeAction @ actionTwo)
	{
		Actions.Push(actionOne);
		Actions.Push(actionTwo);
	}


	FiniteTimeActionState @ StartAction (Node @ target) override
	{
		return  SequenceState (this, target);

	}

	FiniteTimeAction @ Reverse () override
	{
		return  Sequence (Actions[1].Reverse(), Actions[0].Reverse());
	}
}

class SequenceState : FiniteTimeActionState
{
	int last;
	Array<FiniteTimeAction@> actionSequences;
	FiniteTimeActionState @[] actionStates(2);
	//Array<FiniteTimeActionState@>actionStates;
	float split;
	bool hasInfiniteAction = false;

	
	SequenceState (Sequence @ action, Node @target)
	{ 
	    super (action, target);
		actionSequences = action.Actions;
		hasInfiniteAction = (actionSequences[0].isRepeatForever == true) || (actionSequences[1].isRepeatForever == true);
		split = actionSequences [0].Duration / Duration;
		last = -1;
		
	}

	
	  bool IsDone {
		get 
		{
			if (hasInfiniteAction && actionSequences[last].isRepeatForever == true)
			{
				return false;
			}
			
			return Elapsed >= Duration;
			//return FiniteTimeActionState::IsDone;
		}
	}


	void Stop () override
	{
		// Issue #1305
		if (last != -1)
		{
			actionStates[last].Stop();
		}
	}

	void Step (float dt) override
	{
		if (last > -1 && (actionSequences[last].isRepeatForever == true))
		{
			actionStates[last].Step(dt);
		}
		else
		{
			FiniteTimeActionState::Step (dt);
		}
	}

	void Update (float time) override
	{
		int found;
		float new_t;

		if (time < split)
		{
			// action[0]
			found = 0;
			if (split != 0)
				new_t = time / split;
			else
				new_t = 1;
		}
		else
		{
			// action[1]
			found = 1;
			if (split == 1)
				new_t = 1;
			else
				new_t = (time - split) / (1 - split);
		}

		if (found == 1)
		{
			if (last == -1)
			{
				// action[0] was skipped, execute it.
				actionStates [0] = actionSequences[0].StartAction(Target);
				actionStates [0].Update(1.0f);
				actionStates [0].Stop();
			}
			else if (last == 0)
			{
				actionStates [0].Update(1.0f);
				actionStates [0].Stop();
			}
		}
		else if (found == 0 && last == 1)
		{
			// Reverse mode ?
			// XXX: Bug. this case doesn't contemplate when _last==-1, found=0 and in "reverse mode"
			// since it will require a hack to know if an action is on reverse mode or not.
			// "step" should be overriden, and the "reverseMode" value propagated to inner Sequences.
			actionStates[1].Update(0);
			actionStates[1].Stop();

		}

		// Last action found and it is done.
		if (found == last && actionStates[found].IsDone)
		{
			return;
		}


		// Last action found and it is done
		if (found != last)
		{
			actionStates [found] = actionSequences[found].StartAction(Target);
		}

		actionStates [found].Update(new_t);
		last = found;

	}


}