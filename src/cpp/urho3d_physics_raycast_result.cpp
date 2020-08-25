
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


#define PHYSICS_RAYCAST_RESULT_STACK_SIZE 50
static Urho3D::PhysicsRaycastResult physics_racast_result_stack[PHYSICS_RAYCAST_RESULT_STACK_SIZE] = {Urho3D::PhysicsRaycastResult()};
static int index_physics_racast_result_stack = 0;

Urho3D::PhysicsRaycastResult *hl_alloc_urho3d_physics_raycast_result()
{
    Urho3D::PhysicsRaycastResult *r = &(physics_racast_result_stack[(++index_physics_racast_result_stack) % PHYSICS_RAYCAST_RESULT_STACK_SIZE]);
    return r;
}



HL_PRIM hl_urho3d_math_tvector3 * HL_NAME(_physics_raycast_result_get_position)(Urho3D::PhysicsRaycastResult * result)
{
    return &(result->position_);
}


HL_PRIM hl_urho3d_math_tvector3 * HL_NAME(_physics_raycast_result_get_normal)(Urho3D::PhysicsRaycastResult * result)
{
    return &(result->normal_);
}


HL_PRIM float HL_NAME(_physics_raycast_result_get_distance)(Urho3D::PhysicsRaycastResult * result)
{
    return result->distance_;
}


HL_PRIM float HL_NAME(_physics_raycast_result_get_hit_friction)(Urho3D::PhysicsRaycastResult * result)
{
    return result->hitFraction_;
}


HL_PRIM Urho3D::RigidBody * HL_NAME(_physics_raycast_result_get_rigid_body)(Urho3D::PhysicsRaycastResult * result)
{
    return result->body_;
}

DEFINE_PRIM(HL_URHO3D_TVECTOR3 , _physics_raycast_result_get_position, HL_URHO3D_PHYSICS_RAYCAST_RESULT);
DEFINE_PRIM(HL_URHO3D_TVECTOR3 , _physics_raycast_result_get_normal, HL_URHO3D_PHYSICS_RAYCAST_RESULT);
DEFINE_PRIM(_F32 , _physics_raycast_result_get_distance, HL_URHO3D_PHYSICS_RAYCAST_RESULT);
DEFINE_PRIM(_F32 , _physics_raycast_result_get_hit_friction, HL_URHO3D_PHYSICS_RAYCAST_RESULT);
DEFINE_PRIM(HL_URHO3D_T_RIGID_BODY , _physics_raycast_result_get_rigid_body, HL_URHO3D_PHYSICS_RAYCAST_RESULT);

