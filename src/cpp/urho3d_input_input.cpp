#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

HL_PRIM hl_urho3d_intvector2 *HL_NAME(_input_get_mousemove)(urho3d_context *context)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        IntVector2 mouse = input->GetMouseMove();

        return hl_alloc_urho3d_intvector2(mouse.x_, mouse.y_);
    }
    else
    {
        return NULL;
    }
}

HL_PRIM int HL_NAME(_input_get_mousemove_x)(urho3d_context *context)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        return input->GetMouseMove().x_;
    }
    else
    {
        return 0;
    }
}

HL_PRIM int HL_NAME(_input_get_mousemove_y)(urho3d_context *context)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        return input->GetMouseMove().y_;
    }
    else
    {
        return 0;
    }
}

HL_PRIM int HL_NAME(_input_get_touch_id)(urho3d_context *context, int stateIndex)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        TouchState *state = input->GetTouch(stateIndex);
        if (state)
        {
            return state->touchID_;
        }
        else
        {
            return -1;
        }
    }
    else
    {
        return -1;
    }
}

HL_PRIM int HL_NAME(_input_get_touch_position_x)(urho3d_context *context, int stateIndex)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        TouchState *state = input->GetTouch(stateIndex);
        if (state)
        {
            return state->position_.x_;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

HL_PRIM int HL_NAME(_input_get_touch_position_y)(urho3d_context *context, int stateIndex)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        TouchState *state = input->GetTouch(stateIndex);
        if (state)
        {
            return state->position_.y_;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

HL_PRIM int HL_NAME(_input_get_touch_last_position_x)(urho3d_context *context, int stateIndex)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        TouchState *state = input->GetTouch(stateIndex);
        if (state)
        {
            return state->lastPosition_.x_;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

HL_PRIM int HL_NAME(_input_get_touch_last_position_y)(urho3d_context *context, int stateIndex)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        TouchState *state = input->GetTouch(stateIndex);
        if (state)
        {
            return state->lastPosition_.y_;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

HL_PRIM int HL_NAME(_input_get_touch_delta_x)(urho3d_context *context, int stateIndex)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        TouchState *state = input->GetTouch(stateIndex);
        if (state)
        {
            return state->delta_.x_;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

HL_PRIM int HL_NAME(_input_get_touch_delta_y)(urho3d_context *context, int stateIndex)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        TouchState *state = input->GetTouch(stateIndex);
        if (state)
        {
            return state->delta_.y_;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

HL_PRIM int HL_NAME(_input_get_num_touches)(urho3d_context *context)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        return input->GetNumTouches();

    }
    else
    {
        return 0;
    }
}

HL_PRIM float HL_NAME(_input_get_touch_pressure)(urho3d_context *context, int stateIndex)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        TouchState *state = input->GetTouch(stateIndex);
        if (state)
        {
            return state->pressure_;
        }
        else
        {
            return 0.0;
        }
    }
    else
    {
        return 0.0;
    }
}


HL_PRIM bool HL_NAME(_input_get_key_down)(urho3d_context *context, int keycode)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        return input->GetKeyDown((Urho3D::Key)keycode);
    }
}

HL_PRIM bool HL_NAME(_input_get_key_press)(urho3d_context *context, int keycode)
{
    Input *input = context->GetSubsystem<Input>();
    if (input)
    {
        return input->GetKeyPress((Urho3D::Key)keycode);
    }
}

DEFINE_PRIM(_BOOL, _input_get_key_down, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_BOOL, _input_get_key_press, URHO3D_CONTEXT _I32);

DEFINE_PRIM(HL_URHO3D_INTVECTOR2, _input_get_mousemove, URHO3D_CONTEXT);
DEFINE_PRIM(_I32, _input_get_mousemove_x, URHO3D_CONTEXT);
DEFINE_PRIM(_I32, _input_get_mousemove_y, URHO3D_CONTEXT);

DEFINE_PRIM(_I32, _input_get_touch_id, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_I32, _input_get_touch_position_x, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_I32, _input_get_touch_position_y, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_I32, _input_get_touch_last_position_x, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_I32, _input_get_touch_last_position_y, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_I32, _input_get_touch_delta_x, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_I32, _input_get_touch_delta_y, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_I32, _input_get_num_touches, URHO3D_CONTEXT );
DEFINE_PRIM(_F32, _input_get_touch_pressure, URHO3D_CONTEXT _I32);



