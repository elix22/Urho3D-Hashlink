
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


HL_PRIM Urho3D::Node * HL_NAME(_container_refcounted_cast_to_t_node)(urho3d_context *context, Urho3D::RefCounted *ptr)
{
    Urho3D::Node *obj = dynamic_cast<Node *>(ptr);
    if (obj)
    {
        return obj;
    }
    else
    {
        return NULL;
    }
}

//HL_URHO3D_T_RIGID_BODY
HL_PRIM Urho3D::RigidBody * HL_NAME(_container_refcounted_cast_to_t_rigid_body)(urho3d_context *context, Urho3D::RefCounted *ptr)
{
    Urho3D::RigidBody *obj = dynamic_cast<RigidBody *>(ptr);
    if (obj)
    {
        return obj;
    }
    else
    {
        return NULL;
    }
}

DEFINE_PRIM(HL_URHO3D_T_NODE, _container_refcounted_cast_to_t_node, URHO3D_CONTEXT URHO3D_REFCOUNTED);
DEFINE_PRIM(HL_URHO3D_T_RIGID_BODY, _container_refcounted_cast_to_t_rigid_body, URHO3D_CONTEXT URHO3D_REFCOUNTED);
