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

void finalize_urho3d_graphics_animation_controller(void *v)
{
    hl_urho3d_graphics_animation_controller *hl_ptr = (hl_urho3d_graphics_animation_controller *)v;
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

hl_urho3d_graphics_animation_controller *hl_alloc_urho3d_graphics_animation_controller(urho3d_context *context)
{

    hl_urho3d_graphics_animation_controller *p = (hl_urho3d_graphics_animation_controller *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_animation_controller));
    memset(p, 0, sizeof(hl_urho3d_graphics_animation_controller));
    p->finalizer = (void *)finalize_urho3d_graphics_animation_controller;
    p->ptr = new Urho3D::AnimationController(context);
    p->dyn_obj = NULL;
    p->hash = hl_hash_utf8("hl_urho3d_graphics_animation_controller");
    return p;
}

hl_urho3d_graphics_animation_controller *hl_alloc_urho3d_graphics_animation_controller(AnimationController *animationController)
{

    hl_urho3d_graphics_animation_controller *p = (hl_urho3d_graphics_animation_controller *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_animation_controller));
    memset(p, 0, sizeof(hl_urho3d_graphics_animation_controller));
    p->finalizer = (void *)finalize_urho3d_graphics_animation_controller;
    p->ptr = animationController;
    p->dyn_obj = NULL;
    p->hash = hl_hash_utf8("hl_urho3d_graphics_animation_controller");
    return p;
}

HL_PRIM hl_urho3d_graphics_animation_controller *HL_NAME(_graphics_animation_controller_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_animation_controller(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_animation_controller_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_animation_controller *t)
{
    return hl_alloc_urho3d_scene_component(t->ptr);
}

HL_PRIM hl_urho3d_graphics_animation_controller *HL_NAME(_graphics_animation_controller_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return hl_alloc_urho3d_graphics_animation_controller(dynamic_cast<AnimationController *>(cmp));
}

HL_PRIM bool HL_NAME(_graphics_animation_controller_play_exclusive)(urho3d_context *context, hl_urho3d_graphics_animation_controller *t, vstring *vname, int layer, bool looped, float fadeTime)
{
    const char *name = (char *)hl_to_utf8(vname->bytes);
    return t->ptr->PlayExclusive(String(name),layer,looped,fadeTime);
}


HL_PRIM bool HL_NAME(_graphics_animation_controller_set_speed)(urho3d_context *context, hl_urho3d_graphics_animation_controller *t, vstring *vname, float speed)
{
    const char *name = (char *)hl_to_utf8(vname->bytes);
    return t->ptr->SetSpeed(name,speed);
}

HL_PRIM float HL_NAME(_graphics_animation_controller_get_speed)(urho3d_context *context, hl_urho3d_graphics_animation_controller *t, vstring *vname)
{
    const char *name = (char *)hl_to_utf8(vname->bytes);
    return t->ptr->GetSpeed(name);
}



DEFINE_PRIM(HL_URHO3D_ANIMATION_CONTROLLER, _graphics_animation_controller_create, URHO3D_CONTEXT);

DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_animation_controller_cast_to_component, URHO3D_CONTEXT HL_URHO3D_ANIMATION_CONTROLLER);
DEFINE_PRIM(HL_URHO3D_ANIMATION_CONTROLLER, _graphics_animation_controller_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);

DEFINE_PRIM(_BOOL, _graphics_animation_controller_play_exclusive, URHO3D_CONTEXT HL_URHO3D_ANIMATION_CONTROLLER _STRING _I32 _BOOL _F32);

DEFINE_PRIM(_BOOL, _graphics_animation_controller_set_speed, URHO3D_CONTEXT HL_URHO3D_ANIMATION_CONTROLLER _STRING _F32);
DEFINE_PRIM(_F32, _graphics_animation_controller_get_speed, URHO3D_CONTEXT HL_URHO3D_ANIMATION_CONTROLLER _STRING );