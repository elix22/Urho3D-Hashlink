
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

HL_PRIM hl_urho3d_scene_component *HL_NAME(_physics_physics_world_cast_to_component)(urho3d_context *context, Urho3D::PhysicsWorld *world)
{
    return hl_alloc_urho3d_scene_component(world);
}

HL_PRIM Urho3D::PhysicsWorld *HL_NAME(_physics_physics_world_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    if (cmp)
        return dynamic_cast<PhysicsWorld *>(cmp);
    else
    {
        return NULL;
    }
}

HL_PRIM void HL_NAME(_physics_physics_world_set_gravity)(urho3d_context *context, Urho3D::PhysicsWorld *world, Urho3D::Vector3 * gravity)
{
    world->SetGravity(*gravity);
}

HL_PRIM Urho3D::Vector3 * HL_NAME(_physics_physics_world_get_gravity)(urho3d_context *context, Urho3D::PhysicsWorld *world)
{
    return hl_alloc_urho3d_math_tvector3(world->GetGravity());
}


DEFINE_PRIM(HL_URHO3D_PHYSICS_RAYCAST_RESULT, _physics_physics_world_raycast_single, URHO3D_CONTEXT HL_URHO3D_PHYSICS_WORLD HL_URHO3D_T_RAY _F32 _I32);

DEFINE_PRIM(HL_URHO3D_COMPONENT, _physics_physics_world_cast_to_component, URHO3D_CONTEXT HL_URHO3D_PHYSICS_WORLD);
DEFINE_PRIM(HL_URHO3D_PHYSICS_WORLD, _physics_physics_world_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);

DEFINE_PRIM(_VOID, _physics_physics_world_set_gravity, URHO3D_CONTEXT HL_URHO3D_PHYSICS_WORLD HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _physics_physics_world_get_gravity, URHO3D_CONTEXT HL_URHO3D_PHYSICS_WORLD );