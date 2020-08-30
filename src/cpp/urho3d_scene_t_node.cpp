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

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_t_node_cast_to_node)(urho3d_context *context, Urho3D::Node *ptr)
{
    Urho3D::Node *obj = dynamic_cast<Node *>(ptr);
    if (obj)
    {
        return hl_alloc_urho3d_scene_node(context,obj);
    }
    else
    {
        return NULL;
    }
}

HL_PRIM Urho3D::Node *HL_NAME(_scene_t_node_cast_from_node)(urho3d_context *context, hl_urho3d_scene_node * this_node)
{

    if (this_node->ptr)
    {
        return this_node->ptr;
    }
    else
    {
        return NULL;
    }
}

DEFINE_PRIM(HL_URHO3D_NODE, _scene_t_node_cast_to_node, URHO3D_CONTEXT HL_URHO3D_T_NODE);
DEFINE_PRIM(HL_URHO3D_T_NODE, _scene_t_node_cast_from_node, URHO3D_CONTEXT HL_URHO3D_NODE );
