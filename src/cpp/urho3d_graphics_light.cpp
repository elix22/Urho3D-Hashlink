#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_graphics_light(void *v)
{
    hl_urho3d_graphics_light *hl_ptr = (hl_urho3d_graphics_light *)v;
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

hl_urho3d_graphics_light *hl_alloc_urho3d_graphics_light(urho3d_context *context)
{

    hl_urho3d_graphics_light *p = (hl_urho3d_graphics_light *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_light));
    memset(p, 0, sizeof(hl_urho3d_graphics_light));
    p->finalizer = (void *)finalize_urho3d_graphics_light;
    p->ptr = new Light(context);
    return p;
}

hl_urho3d_graphics_light *hl_alloc_urho3d_graphics_light(Light *t)
{

    hl_urho3d_graphics_light *p = (hl_urho3d_graphics_light *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_light));
    memset(p, 0, sizeof(hl_urho3d_graphics_light));
    p->finalizer = (void *)finalize_urho3d_graphics_light;
    p->ptr = t;
    return p;
}

HL_PRIM hl_urho3d_graphics_light *HL_NAME(_graphics_light_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_light(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_light_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return hl_alloc_urho3d_scene_component(t->ptr);
}

HL_PRIM hl_urho3d_graphics_light *HL_NAME(_graphics_light_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return hl_alloc_urho3d_graphics_light(dynamic_cast<Light *>(cmp));
}

HL_PRIM void HL_NAME(_graphics_light_set_light_type)(urho3d_context *context, hl_urho3d_graphics_light *t, int type)
{
    t->ptr->SetLightType((LightType)type);
}

HL_PRIM int HL_NAME(_graphics_light_get_light_type)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetLightType();
}

HL_PRIM void HL_NAME(_graphics_light_set_range)(urho3d_context *context, hl_urho3d_graphics_light *t, float range)
{
    t->ptr->SetRange(range);
}

HL_PRIM float HL_NAME(_graphics_light_get_range)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetRange();
}

DEFINE_PRIM(HL_URHO3D_LIGHT, _graphics_light_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_light_cast_to_component, URHO3D_CONTEXT HL_URHO3D_LIGHT);
DEFINE_PRIM(HL_URHO3D_LIGHT, _graphics_light_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);


DEFINE_PRIM(_VOID, _graphics_light_set_light_type, URHO3D_CONTEXT HL_URHO3D_LIGHT _I32);
DEFINE_PRIM(_I32, _graphics_light_get_light_type, URHO3D_CONTEXT HL_URHO3D_LIGHT );

DEFINE_PRIM(_VOID, _graphics_light_set_range, URHO3D_CONTEXT HL_URHO3D_LIGHT _F64);
DEFINE_PRIM(_F64, _graphics_light_get_range, URHO3D_CONTEXT HL_URHO3D_LIGHT );