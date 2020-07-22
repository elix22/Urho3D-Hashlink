#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_graphics_staticmodel(void *v)
{
    hl_urho3d_graphics_staticmodel *hl_ptr = (hl_urho3d_graphics_staticmodel *)v;
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

hl_urho3d_graphics_staticmodel *hl_alloc_urho3d_graphics_staticmodel(urho3d_context *context)
{

    hl_urho3d_graphics_staticmodel *p = (hl_urho3d_graphics_staticmodel *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_staticmodel));
    memset(p,0,sizeof(hl_urho3d_graphics_staticmodel));
    p->finalizer = (void *)finalize_urho3d_graphics_staticmodel;
    p->ptr = new StaticModel(context);
    return p;
}

hl_urho3d_graphics_staticmodel *hl_alloc_urho3d_graphics_staticmodel(StaticModel *model)
{

    hl_urho3d_graphics_staticmodel *p = (hl_urho3d_graphics_staticmodel *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_staticmodel));
    memset(p,0,sizeof(hl_urho3d_graphics_staticmodel));
    p->finalizer = (void *)finalize_urho3d_graphics_staticmodel;
    p->ptr = model;
    return p;
}

HL_PRIM hl_urho3d_graphics_staticmodel *HL_NAME(_graphics_staticmodel_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_staticmodel(context);

}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_staticmodel_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_staticmodel * t)
{
    return  hl_alloc_urho3d_scene_component(t->ptr);
}


HL_PRIM hl_urho3d_graphics_staticmodel *HL_NAME(_graphics_staticmodel_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component * component)
{
    Component * cmp = component->ptr;
    return  hl_alloc_urho3d_graphics_staticmodel(dynamic_cast<StaticModel*>(cmp));
}

DEFINE_PRIM(HL_URHO3D_STATICMODEL, _graphics_staticmodel_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_staticmodel_cast_to_component, URHO3D_CONTEXT HL_URHO3D_STATICMODEL);
DEFINE_PRIM(HL_URHO3D_STATICMODEL, _graphics_staticmodel_cast_from_component,URHO3D_CONTEXT HL_URHO3D_COMPONENT );