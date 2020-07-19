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

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_node_create)(urho3d_context *context)
{
    hl_urho3d_scene_node *v = hl_alloc_urho3d_scene_node(context);
    return v;
}

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_node_create_child)(urho3d_context *context, hl_urho3d_scene_node *this_node, vstring *vname, int mode, int id, bool temporary)
{
    const char *name = (char *)hl_to_utf8(vname->bytes);
    Node *child = this_node->ptr->CreateChild(String(name), (CreateMode)mode, id, temporary);
    if (child)
    {
        return hl_alloc_urho3d_scene_node(context, child);
    }
    return NULL;
}

HL_PRIM hl_urho3d_scene_component * HL_NAME(_scene_node_create_component)(urho3d_context *context, hl_urho3d_scene_node *this_node, vstring *vtype, int mode, unsigned id)
{
    const char *type = (char *)hl_to_utf8(vtype->bytes);
    Component *component = this_node->ptr->CreateComponent(StringHash(String(type)), (CreateMode)mode, id);
    if (component)
    {
        return hl_alloc_urho3d_scene_component(component);
    }
    else
    {
        return NULL;
    }
}

DEFINE_PRIM(HL_URHO3D_NODE, _scene_node_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_NODE, _scene_node_create_child, URHO3D_CONTEXT HL_URHO3D_NODE _STRING _I32 _I32 _BOOL);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_node_create_component, URHO3D_CONTEXT HL_URHO3D_NODE _STRING _I32 _I32);