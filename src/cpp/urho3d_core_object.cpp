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

/*
typedef Urho3D::Object  hl_urho3d_core_object;
#define HL_URHO3D_OBJECT _ABSTRACT(hl_urho3d_core_object)

*/


HL_PRIM hl_urho3d_scene_component *HL_NAME(_core_object_cast_to_component)(urho3d_context *context, Urho3D::Object *obj)
{
    Urho3D::Component *componet = dynamic_cast<Component *>(obj);
    if (componet)
    {
        return hl_alloc_urho3d_scene_component(dynamic_cast<Component *>(obj));
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_core_object *HL_NAME(_core_object_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return dynamic_cast<Object *>(cmp);
}


HL_PRIM hl_urho3d_scene_node *HL_NAME(_core_object_cast_to_node)(urho3d_context *context, Urho3D::Object *ptr)
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

HL_PRIM hl_urho3d_core_object *HL_NAME(_core_object_cast_from_node)(urho3d_context *context, hl_urho3d_scene_node *node)
{
    Node *obj = node->ptr;
    return dynamic_cast<Object *>(obj);
}


DEFINE_PRIM(HL_URHO3D_COMPONENT, _core_object_cast_to_component, URHO3D_CONTEXT HL_URHO3D_OBJECT);
DEFINE_PRIM(HL_URHO3D_OBJECT, _core_object_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);

DEFINE_PRIM(HL_URHO3D_NODE, _core_object_cast_to_node, URHO3D_CONTEXT HL_URHO3D_OBJECT);
DEFINE_PRIM(HL_URHO3D_OBJECT, _core_object_cast_from_node, URHO3D_CONTEXT HL_URHO3D_NODE);

