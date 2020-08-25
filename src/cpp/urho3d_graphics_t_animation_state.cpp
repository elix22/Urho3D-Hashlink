#define HL_NAME(n) Urho3D_##n
extern "C"
{
#if defined(URHO3D_HAXE_HASHLINK)
#include <hashlink/hl.h>
#else
#include <hl.h>
#endif
}

#include "global_types.inc"


HL_PRIM void HL_NAME(_graphics_tanimation_state_set_weight)(Urho3D::AnimationState * state,float weight)
{
   (state)->SetWeight(weight);
}

HL_PRIM float HL_NAME(_graphics_tanimation_state_get_weight)(Urho3D::AnimationState * state)
{
   return (state)->GetWeight();
}

HL_PRIM void HL_NAME(_graphics_tanimation_state_set_time)(Urho3D::AnimationState * state,float time)
{
   (state)->SetTime(time);
}

HL_PRIM float HL_NAME(_graphics_tanimation_state_get_time)(Urho3D::AnimationState * state)
{
   return (state)->GetTime();
}

HL_PRIM void HL_NAME(_graphics_tanimation_state_set_looped)(Urho3D::AnimationState * state,bool looped)
{
   (state)->SetLooped(looped);
}

HL_PRIM bool HL_NAME(_graphics_tanimation_state_get_looped)(Urho3D::AnimationState * state)
{
   return (state)->IsLooped();
}

HL_PRIM void HL_NAME(_graphics_tanimation_state_add_time)(Urho3D::AnimationState * state,float time)
{
   (state)->AddTime(time);
}

HL_PRIM void HL_NAME(_graphics_tanimation_state_add_weight)(Urho3D::AnimationState * state,float weight)
{
   (state)->AddWeight(weight);
}


DEFINE_PRIM(_VOID, _graphics_tanimation_state_set_weight,  HL_URHO3D_TANIMATION_STATE _F32);
DEFINE_PRIM(_F32, _graphics_tanimation_state_get_weight,  HL_URHO3D_TANIMATION_STATE );
DEFINE_PRIM(_VOID, _graphics_tanimation_state_set_time,  HL_URHO3D_TANIMATION_STATE _F32);
DEFINE_PRIM(_F32, _graphics_tanimation_state_get_time,  HL_URHO3D_TANIMATION_STATE );
DEFINE_PRIM(_VOID, _graphics_tanimation_state_set_looped,  HL_URHO3D_TANIMATION_STATE _BOOL);
DEFINE_PRIM(_BOOL, _graphics_tanimation_state_get_looped,  HL_URHO3D_TANIMATION_STATE );
DEFINE_PRIM(_VOID, _graphics_tanimation_state_add_time,  HL_URHO3D_TANIMATION_STATE _F32);
DEFINE_PRIM(_VOID, _graphics_tanimation_state_add_weight,  HL_URHO3D_TANIMATION_STATE _F32);
