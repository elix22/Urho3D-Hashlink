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


HL_PRIM hl_urho3d_math_boundingbox *HL_NAME(_graphics_zone_set_boundingbox)(urho3d_context * context,hl_urho3d_graphics_zone *zone,hl_urho3d_math_boundingbox * boundingbox)
{
    zone->ptr->SetBoundingBox(*(boundingbox->ptr));
    return boundingbox; 

  // BoundingBox box = zone->ptr->GetBoundingBox();
  //  printf("_graphics_zone_set_boundingbox %f %f %f %f \n", box.min_.x_,box.min_.y_,box.max_.x_,box.max_.y_);
    
}

HL_PRIM hl_urho3d_math_boundingbox *HL_NAME(_graphics_zone_get_boundingbox)(urho3d_context * context,hl_urho3d_graphics_zone *zone)
{
    return hl_alloc_urho3d_math_boundingbox(zone->ptr->GetBoundingBox());

}


HL_PRIM hl_urho3d_color *HL_NAME(_graphics_zone_set_ambient_color)(urho3d_context * context,hl_urho3d_graphics_zone *zone,hl_urho3d_color * color)
{
    zone->ptr->SetAmbientColor(*(color->ptr));
    return color;
}

HL_PRIM hl_urho3d_color *HL_NAME(_graphics_zone_get_ambient_color)(urho3d_context * context,hl_urho3d_graphics_zone *zone)
{
    return  hl_alloc_urho3d_color(zone->ptr->GetAmbientColor());
}

HL_PRIM hl_urho3d_color *HL_NAME(_graphics_zone_set_fog_color)(urho3d_context * context,hl_urho3d_graphics_zone *zone,hl_urho3d_color * color)
{
    zone->ptr->SetFogColor(*(color->ptr));
    return color;
}

HL_PRIM hl_urho3d_color *HL_NAME(_graphics_zone_get_fog_color)(urho3d_context * context,hl_urho3d_graphics_zone *zone)
{
    return  hl_alloc_urho3d_color(zone->ptr->GetFogColor());
}

HL_PRIM float HL_NAME(_graphics_zone_set_fog_start)(urho3d_context * context,hl_urho3d_graphics_zone *zone,float start)
{
    zone->ptr->SetFogStart(start);
    return start;
}

HL_PRIM float HL_NAME(_graphics_zone_get_fog_start)(urho3d_context * context,hl_urho3d_graphics_zone *zone)
{
    return zone->ptr->GetFogStart();
}


HL_PRIM float HL_NAME(_graphics_zone_set_fog_end)(urho3d_context * context,hl_urho3d_graphics_zone *zone,float start)
{
    zone->ptr->SetFogEnd(start);
    return start;
}

HL_PRIM float HL_NAME(_graphics_zone_get_fog_end)(urho3d_context * context,hl_urho3d_graphics_zone *zone)
{
    return zone->ptr->GetFogEnd();
}


DEFINE_PRIM(HL_URHO3D_ZONE, _graphics_zone_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_zone_cast_to_component, URHO3D_CONTEXT HL_URHO3D_ZONE);
DEFINE_PRIM(HL_URHO3D_ZONE, _graphics_zone_cast_from_component,URHO3D_CONTEXT HL_URHO3D_COMPONENT );
DEFINE_PRIM(HL_URHO3D_BOUNDINGBOX, _graphics_zone_set_boundingbox,URHO3D_CONTEXT HL_URHO3D_ZONE HL_URHO3D_BOUNDINGBOX);
DEFINE_PRIM(HL_URHO3D_BOUNDINGBOX, _graphics_zone_get_boundingbox,URHO3D_CONTEXT HL_URHO3D_ZONE);
DEFINE_PRIM(HL_URHO3D_COLOR, _graphics_zone_set_ambient_color,URHO3D_CONTEXT HL_URHO3D_ZONE HL_URHO3D_COLOR);
DEFINE_PRIM(HL_URHO3D_COLOR, _graphics_zone_get_ambient_color,URHO3D_CONTEXT HL_URHO3D_ZONE);
DEFINE_PRIM(HL_URHO3D_COLOR, _graphics_zone_set_fog_color,URHO3D_CONTEXT HL_URHO3D_ZONE HL_URHO3D_COLOR);
DEFINE_PRIM(HL_URHO3D_COLOR, _graphics_zone_get_fog_color,URHO3D_CONTEXT HL_URHO3D_ZONE);
DEFINE_PRIM(_F32, _graphics_zone_set_fog_start,URHO3D_CONTEXT HL_URHO3D_ZONE _F32);
DEFINE_PRIM(_F32, _graphics_zone_get_fog_start,URHO3D_CONTEXT HL_URHO3D_ZONE);
DEFINE_PRIM(_F32, _graphics_zone_set_fog_end,URHO3D_CONTEXT HL_URHO3D_ZONE _F32);
DEFINE_PRIM(_F32, _graphics_zone_get_fog_end,URHO3D_CONTEXT HL_URHO3D_ZONE);