#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_scene_node(void *v)
{
    hl_urho3d_scene_node *hl_ptr = (hl_urho3d_scene_node *)v;
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

hl_urho3d_scene_node *hl_alloc_urho3d_scene_node(urho3d_context *context)
{

    hl_urho3d_scene_node *p = (hl_urho3d_scene_node *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_node));
    memset(p, 0, sizeof(hl_urho3d_scene_node));
    p->finalizer = (void *)finalize_urho3d_scene_node;
    p->ptr = new Node(context);
    return p;
}

hl_urho3d_scene_node *hl_alloc_urho3d_scene_node(urho3d_context *context, Node *node)
{

    if (node)
    {
        hl_urho3d_scene_node *p = (hl_urho3d_scene_node *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_node));
        memset(p, 0, sizeof(hl_urho3d_scene_node));
        p->finalizer = (void *)finalize_urho3d_scene_node;
        p->ptr = node;
        return p;
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_scene_node *HL_NAME(_create_scene_node)(urho3d_context *context)
{
    hl_urho3d_scene_node *v = hl_alloc_urho3d_scene_node(context);
    return v;
}

DEFINE_PRIM(HL_URHO3D_NODE, _create_scene_node, URHO3D_CONTEXT);