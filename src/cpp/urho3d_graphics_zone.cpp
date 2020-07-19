#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_graphics_zone(void *v)
{
    hl_urho3d_graphics_zone *hl_ptr = (hl_urho3d_graphics_zone *)v;
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

hl_urho3d_graphics_zone *hl_alloc_urho3d_graphics_zone(urho3d_context *context)
{

    hl_urho3d_graphics_zone *p = (hl_urho3d_graphics_zone *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_zone));
    memset(p,0,sizeof(hl_urho3d_graphics_zone));
    p->finalizer = (void *)finalize_urho3d_graphics_zone;
    p->ptr = new Zone(context);
    return p;
}

hl_urho3d_graphics_zone *hl_alloc_urho3d_graphics_zone(Zone *zone)
{

    hl_urho3d_graphics_zone *p = (hl_urho3d_graphics_zone *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_zone));
    memset(p,0,sizeof(hl_urho3d_graphics_zone));
    p->finalizer = (void *)finalize_urho3d_graphics_zone;
    p->ptr = zone;
    return p;
}

HL_PRIM hl_urho3d_graphics_zone *HL_NAME(_graphics_zone_create)(urho3d_context *context)
{
    hl_urho3d_graphics_zone *v = hl_alloc_urho3d_graphics_zone(context);
    return v;
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_zone_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_zone * zone)
{
    hl_urho3d_scene_component * hl_u3d_obj = hl_alloc_urho3d_scene_component(zone->ptr);
    return hl_u3d_obj;
}


HL_PRIM hl_urho3d_graphics_zone *HL_NAME(_graphics_zone_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component * component)
{
    Component * cmp = component->ptr;
    hl_urho3d_graphics_zone * hl_u3d_obj = hl_alloc_urho3d_graphics_zone(dynamic_cast<Zone*>(cmp));
    return hl_u3d_obj;
}



DEFINE_PRIM(HL_URHO3D_ZONE, _graphics_zone_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_zone_cast_to_component, URHO3D_CONTEXT HL_URHO3D_ZONE);
DEFINE_PRIM(HL_URHO3D_ZONE, _graphics_zone_cast_from_component,URHO3D_CONTEXT HL_URHO3D_COMPONENT );