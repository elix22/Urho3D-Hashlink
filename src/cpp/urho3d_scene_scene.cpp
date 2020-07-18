#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_scene_scene(void *v)
{
    hl_urho3d_scene_scene *hl_ptr = (hl_urho3d_scene_scene *)v;
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

hl_urho3d_scene_scene *hl_alloc_urho3d_scene_scene(urho3d_context *context)
{

    hl_urho3d_scene_scene *p = (hl_urho3d_scene_scene *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_scene));
    memset(p,0,sizeof(hl_urho3d_scene_scene));
    p->finalizer = (void *)finalize_urho3d_scene_scene;
    p->ptr = new Scene(context);
    return p;
}

HL_PRIM hl_urho3d_scene_scene *HL_NAME(_create_scene_scene)(urho3d_context *context)
{
    hl_urho3d_scene_scene *v = hl_alloc_urho3d_scene_scene(context);
    return v;
}

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_cast_scene_to_node)(urho3d_context *context, hl_urho3d_scene_scene * scene)
{
    hl_urho3d_scene_node * hl_node = hl_alloc_urho3d_scene_node(context, scene->ptr);
    return hl_node;
}


DEFINE_PRIM(HL_URHO3D_SCENE, _create_scene_scene, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_NODE, _scene_cast_scene_to_node, URHO3D_CONTEXT HL_URHO3D_SCENE);