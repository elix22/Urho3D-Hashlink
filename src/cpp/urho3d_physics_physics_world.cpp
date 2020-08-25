
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


HL_PRIM Urho3D::PhysicsRaycastResult *HL_NAME(_physics_physics_world_raycast_single)(urho3d_context *context, Urho3D::PhysicsWorld *world, Urho3D::Ray *ray, float maxDistance, int collisionMask)
{
    Urho3D::PhysicsRaycastResult *r = hl_alloc_urho3d_physics_raycast_result();
    world->RaycastSingle(*r, *(ray), maxDistance, collisionMask);
    return r;
}

DEFINE_PRIM(HL_URHO3D_PHYSICS_RAYCAST_RESULT, _physics_physics_world_raycast_single, URHO3D_CONTEXT HL_URHO3D_PHYSICS_WORLD HL_URHO3D_T_RAY _F32 _I32 );