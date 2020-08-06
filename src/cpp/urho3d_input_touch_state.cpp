#define HL_NAME(n) Urho3D_##n
extern "C"
{
#if defined(URHO3D_HAXE_HASHLINK)
#include <hashlink/hl.h>
#else
#include <hl.h>
#endif
}

#include "global_types.h"


static Urho3D::TouchState touch_state_stack[TOUCHSTATE_STACK_SIZE] = {0};
static int index_touch_state_stack = 0;



HL_PRIM Urho3D::TouchState* HL_NAME(_input_touch_state_get)(urho3d_context *context, int stateIndex)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        TouchState *state = input->GetTouch(stateIndex);
        if (state)
        {
            Urho3D::TouchState *t = &(touch_state_stack[(++index_touch_state_stack) % TOUCHSTATE_STACK_SIZE]);
            *t = *state;
            return t;
        }
        else
        {
            return NULL;
        }
    }
    else
    {
        return NULL;
    }
}

HL_PRIM int HL_NAME(_input_touch_state_get_id)(Urho3D::TouchState *state)
{

    if (state)
    {
        return state->touchID_;
    }
    else
    {
        return -1;
    }
}

HL_PRIM Urho3D::IntVector2 * HL_NAME(_input_touch_state_get_position)(Urho3D::TouchState*state)
{

        if (state)
        {
            return &(state->position_);
        }
        else
        {
            return NULL;
        }

}
HL_PRIM Urho3D::IntVector2 * HL_NAME(_input_touch_state_get_last_position)(Urho3D::TouchState*state)
{

        if (state)
        {
            return &(state->lastPosition_);
        }
        else
        {
            return NULL;
        }

}

HL_PRIM Urho3D::IntVector2 * HL_NAME(_input_touch_state_get_delta)(Urho3D::TouchState*state)
{

        if (state)
        {
            return &(state->delta_);
        }
        else
        {
            return NULL;
        }

}

HL_PRIM float HL_NAME(_input_touch_state_get_pressure)(Urho3D::TouchState*state)
{

        if (state)
        {
            return (state->pressure_);
        }
        else
        {
            return 0.0;
        }

}

DEFINE_PRIM(HL_URHO3D_TOUCH_STATE, _input_touch_state_get, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_I32, _input_touch_state_get_id, HL_URHO3D_TOUCH_STATE);
DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _input_touch_state_get_position, HL_URHO3D_TOUCH_STATE);
DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _input_touch_state_get_last_position, HL_URHO3D_TOUCH_STATE);
DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _input_touch_state_get_delta, HL_URHO3D_TOUCH_STATE);
DEFINE_PRIM(_F32, _input_touch_state_get_pressure, HL_URHO3D_TOUCH_STATE);
