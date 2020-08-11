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

void finalize_urho3d_graphics_skybox(void *v)
{
    hl_urho3d_graphics_skybox *hl_ptr = (hl_urho3d_graphics_skybox *)v;
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

hl_urho3d_graphics_skybox *hl_alloc_urho3d_graphics_skybox(urho3d_context *context)
{

    hl_urho3d_graphics_skybox *p = (hl_urho3d_graphics_skybox *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_skybox));
    memset(p, 0, sizeof(hl_urho3d_graphics_skybox));
    p->finalizer = (void *)finalize_urho3d_graphics_skybox;
    p->ptr = new Skybox(context);
    return p;
}

hl_urho3d_graphics_skybox *hl_alloc_urho3d_graphics_skybox(Urho3D::Skybox *obj)
{

    hl_urho3d_graphics_skybox *p = (hl_urho3d_graphics_skybox *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_skybox));
    memset(p, 0, sizeof(hl_urho3d_graphics_skybox));
    p->finalizer = (void *)finalize_urho3d_graphics_skybox;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_graphics_skybox *HL_NAME(_graphics_skybox_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_skybox(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_skybox_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_skybox *t)
{
    return hl_alloc_urho3d_scene_component(t->ptr);
}

HL_PRIM hl_urho3d_graphics_skybox *HL_NAME(_graphics_skybox_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return hl_alloc_urho3d_graphics_skybox(dynamic_cast<Skybox *>(cmp));
}


HL_PRIM hl_urho3d_graphics_staticmodel *HL_NAME(_graphics_skybox_cast_to_staticmodel)(urho3d_context *context, hl_urho3d_graphics_skybox *t)
{
    return hl_alloc_urho3d_graphics_staticmodel(t->ptr);
}

HL_PRIM hl_urho3d_graphics_skybox *HL_NAME(_graphics_skybox_cast_from_staticmodel)(urho3d_context *context, hl_urho3d_graphics_staticmodel *component)
{
    StaticModel *cmp = component->ptr;
    return hl_alloc_urho3d_graphics_skybox(dynamic_cast<Skybox *>(cmp));
}


DEFINE_PRIM(HL_URHO3D_SKYBOX, _graphics_skybox_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_skybox_cast_to_component, URHO3D_CONTEXT HL_URHO3D_SKYBOX);
DEFINE_PRIM(HL_URHO3D_SKYBOX, _graphics_skybox_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);

DEFINE_PRIM(HL_URHO3D_STATICMODEL, _graphics_skybox_cast_to_staticmodel, URHO3D_CONTEXT HL_URHO3D_SKYBOX);
DEFINE_PRIM(HL_URHO3D_SKYBOX, _graphics_skybox_cast_from_staticmodel, URHO3D_CONTEXT HL_URHO3D_STATICMODEL);