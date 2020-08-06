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

/*
void finalize_urho3d_graphics_animation_state(void *v)
{
    hl_urho3d_graphics_animation_state *hl_ptr = (hl_urho3d_graphics_animation_state *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
        
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_graphics_animation_state *hl_alloc_urho3d_graphics_animation_state(urho3d_context *context,AnimatedModel* model, Animation* animation)
{
        hl_urho3d_graphics_animation_state *p = (hl_urho3d_graphics_animation_state *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_animation_state));
        memset(p, 0, sizeof(hl_urho3d_graphics_animation_state));
        p->finalizer = (void *)finalize_urho3d_graphics_animation_state;
        p->ptr = new Urho3D::AnimationState(model,animation);
        return p;
}

hl_urho3d_graphics_animation_state *hl_alloc_urho3d_graphics_animation_state(AnimationState *animationState)
{

    hl_urho3d_graphics_animation_state *p = (hl_urho3d_graphics_animation_state *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_animation_state));
    memset(p, 0, sizeof(hl_urho3d_graphics_animation_state));
    p->finalizer = (void *)finalize_urho3d_graphics_animation_state;
    p->ptr = animationState;
    return p;
}

HL_PRIM hl_urho3d_graphics_animation_state *HL_NAME(_graphics_animation_state_create)(urho3d_context *context,hl_urho3d_graphics_animatedmodel * model ,hl_urho3d_graphics_animation * animation)
{
    return hl_alloc_urho3d_graphics_animation_state(context,model->ptr,animation->ptr);
}

HL_PRIM void HL_NAME(_graphics_animation_state_set_weight)(urho3d_context *context,hl_urho3d_graphics_animation_state *state,float weight)
{
   state->ptr->SetWeight(weight);
}

HL_PRIM float HL_NAME(_graphics_animation_state_get_weight)(urho3d_context *context,hl_urho3d_graphics_animation_state *state)
{
   return state->ptr->GetWeight();
}

HL_PRIM void HL_NAME(_graphics_animation_state_set_time)(urho3d_context *context,hl_urho3d_graphics_animation_state *state,float time)
{
   state->ptr->SetTime(time);
}

HL_PRIM float HL_NAME(_graphics_animation_state_get_time)(urho3d_context *context,hl_urho3d_graphics_animation_state *state)
{
   return state->ptr->GetTime();
}

HL_PRIM void HL_NAME(_graphics_animation_state_set_looped)(urho3d_context *context,hl_urho3d_graphics_animation_state *state,bool looped)
{
   state->ptr->SetLooped(looped);
}

HL_PRIM bool HL_NAME(_graphics_animation_state_get_looped)(urho3d_context *context,hl_urho3d_graphics_animation_state *state)
{
   return state->ptr->IsLooped();
}

HL_PRIM void HL_NAME(_graphics_animation_state_add_time)(urho3d_context *context,hl_urho3d_graphics_animation_state *state,float time)
{
   state->ptr->AddTime(time);
}

HL_PRIM void HL_NAME(_graphics_animation_state_add_weight)(urho3d_context *context,hl_urho3d_graphics_animation_state *state,float weight)
{
   state->ptr->AddWeight(weight);
}

DEFINE_PRIM(HL_URHO3D_ANIMATION_STATE, _graphics_animation_state_create, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL HL_URHO3D_ANIMATION);
DEFINE_PRIM(_VOID, _graphics_animation_state_set_weight, URHO3D_CONTEXT HL_URHO3D_ANIMATION_STATE _F32);
DEFINE_PRIM(_F32, _graphics_animation_state_get_weight, URHO3D_CONTEXT HL_URHO3D_ANIMATION_STATE );
DEFINE_PRIM(_VOID, _graphics_animation_state_set_time, URHO3D_CONTEXT HL_URHO3D_ANIMATION_STATE _F32);
DEFINE_PRIM(_F32, _graphics_animation_state_get_time, URHO3D_CONTEXT HL_URHO3D_ANIMATION_STATE );
DEFINE_PRIM(_VOID, _graphics_animation_state_set_looped, URHO3D_CONTEXT HL_URHO3D_ANIMATION_STATE _BOOL);
DEFINE_PRIM(_BOOL, _graphics_animation_state_get_looped, URHO3D_CONTEXT HL_URHO3D_ANIMATION_STATE );
DEFINE_PRIM(_VOID, _graphics_animation_state_add_time, URHO3D_CONTEXT HL_URHO3D_ANIMATION_STATE _F32);
DEFINE_PRIM(_VOID, _graphics_animation_state_add_weight, URHO3D_CONTEXT HL_URHO3D_ANIMATION_STATE _F32);

*/
