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

void finalize_urho3d_scene_value_animation(void *v)
{
    hl_urho3d_scene_value_animation *hl_ptr = (hl_urho3d_scene_value_animation *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_scene_value_animation *hl_alloc_urho3d_scene_value_animation(urho3d_context *context)
{

    hl_urho3d_scene_value_animation *p = (hl_urho3d_scene_value_animation *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_value_animation));
    memset(p, 0, sizeof(hl_urho3d_scene_value_animation));
    p->finalizer = (void *)finalize_urho3d_scene_value_animation;
    p->ptr = new ValueAnimation(context);
    return p;
}

hl_urho3d_scene_value_animation *hl_alloc_urho3d_scene_value_animation(urho3d_context *context, ValueAnimation * va)
{

    hl_urho3d_scene_value_animation *p = (hl_urho3d_scene_value_animation *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_value_animation));
    memset(p, 0, sizeof(hl_urho3d_scene_value_animation));
    p->finalizer = (void *)finalize_urho3d_scene_value_animation;
    p->ptr = va;
    return p;
}


HL_PRIM hl_urho3d_scene_value_animation *HL_NAME(_scene_value_animation_create)(urho3d_context *context)
{
    hl_urho3d_scene_value_animation *v = hl_alloc_urho3d_scene_value_animation(context);
    return v;
}

//bool SetKeyFrame(float time, const Variant& value);
HL_PRIM bool HL_NAME(_scene_value_animation_set_keyframe)(urho3d_context *context,hl_urho3d_scene_value_animation * v, float time,Urho3D::Variant * variant)
{
    return v->ptr->SetKeyFrame(time,*variant);
}

DEFINE_PRIM(HL_URHO3D_VALUE_ANIMATION, _scene_value_animation_create, URHO3D_CONTEXT );
DEFINE_PRIM(_BOOL, _scene_value_animation_set_keyframe, URHO3D_CONTEXT HL_URHO3D_VALUE_ANIMATION _F32 HL_URHO3D_TVARIANT );