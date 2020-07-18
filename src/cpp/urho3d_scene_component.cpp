#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_scene_component(void *v)
{
    hl_urho3d_scene_component *hl_ptr = (hl_urho3d_scene_component *)v;
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

hl_urho3d_scene_component *hl_alloc_urho3d_scene_component(urho3d_context *context)
{

    hl_urho3d_scene_component *p = (hl_urho3d_scene_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_component));
    memset(p,0,sizeof(hl_urho3d_scene_component));
    p->finalizer = (void *)finalize_urho3d_scene_component;
    p->ptr = new Component(context);
    return p;
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_create_scene_component)(urho3d_context *context)
{
    hl_urho3d_scene_component *v = hl_alloc_urho3d_scene_component(context);
    return v;
}


DEFINE_PRIM(HL_URHO3D_COMPONENT, _create_scene_component, URHO3D_CONTEXT);