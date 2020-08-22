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


HL_PRIM hl_urho3d_physics_rigid_body *HL_NAME(_physics_t_rigid_body_cast_to_rigid_body)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return hl_alloc_urho3d_physics_rigid_body(t);
}

HL_PRIM  Urho3D::RigidBody *HL_NAME(_physics_t_rigid_body_cast_from_rigid_body)(urho3d_context *context, hl_urho3d_physics_rigid_body *rigid_body)
{
    return rigid_body->ptr;
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_mass)(urho3d_context *context,  Urho3D::RigidBody *t, float mass)
{
    t->SetMass(mass);
}

HL_PRIM float HL_NAME(_physics_t_rigid_body_get_mass)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetMass();
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_friction)(urho3d_context *context,  Urho3D::RigidBody *t, float friction)
{
    t->SetFriction(friction);
}

HL_PRIM float HL_NAME(_physics_t_rigid_body_get_friction)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetFriction();
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_rolling_friction)(urho3d_context *context,  Urho3D::RigidBody *t, float friction)
{
    t->SetRollingFriction(friction);
}

HL_PRIM float HL_NAME(_physics_t_rigid_body_get_rolling_friction)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetRollingFriction();
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_linear_velocity)(urho3d_context *context,  Urho3D::RigidBody *t, Urho3D::Vector3 *v)
{
    t->SetLinearVelocity(*v);
}

HL_PRIM Urho3D::Vector3 *HL_NAME(_physics_t_rigid_body_get_linear_velocity)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return hl_alloc_urho3d_math_tvector3(t->GetLinearVelocity());
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_trigger)(urho3d_context *context,  Urho3D::RigidBody *t, bool b)
{
    t->SetTrigger(b);
}

HL_PRIM bool HL_NAME(_physics_t_rigid_body_get_trigger)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->IsTrigger();
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_linear_dumping)(urho3d_context *context,  Urho3D::RigidBody *t, float f)
{
    t->SetLinearDamping(f);
}

HL_PRIM float HL_NAME(_physics_t_rigid_body_get_linear_dumping)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetLinearDamping();
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_linear_rest_threshold)(urho3d_context *context,  Urho3D::RigidBody *t, float f)
{
    t->SetLinearRestThreshold(f);
}

HL_PRIM float HL_NAME(_physics_t_rigid_body_get_linear_rest_threshold)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetLinearRestThreshold();
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_angular_dumping)(urho3d_context *context,  Urho3D::RigidBody *t, float f)
{
    t->SetAngularDamping(f);
}

HL_PRIM float HL_NAME(_physics_t_rigid_body_get_angular_dumping)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetAngularDamping();
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_angular_rest_threshold)(urho3d_context *context,  Urho3D::RigidBody *t, float f)
{
    t->SetAngularRestThreshold(f);
}

HL_PRIM float HL_NAME(_physics_t_rigid_body_get_angular_rest_threshold)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetAngularRestThreshold();
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_collision_layer)(urho3d_context *context,  Urho3D::RigidBody *t, int i)
{
    t->SetCollisionLayer(i);
}

HL_PRIM int HL_NAME(_physics_t_rigid_body_get_collision_layer)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetCollisionLayer();
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_collision_mask)(urho3d_context *context,  Urho3D::RigidBody *t, int i)
{
    t->SetCollisionMask(i);
}

HL_PRIM int HL_NAME(_physics_t_rigid_body_get_collision_mask)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetCollisionMask();
}


HL_PRIM void HL_NAME(_physics_t_rigid_body_apply_impulse)(urho3d_context *context,  Urho3D::RigidBody *t, Urho3D::Vector3 *impulse, Urho3D::Vector3 *position)
{
    if (*position != Vector3::ZERO)
    {
        t->ApplyImpulse(*impulse, *position);
    }
    else
    {
        t->ApplyImpulse(*impulse);
    }
}

HL_PRIM void HL_NAME(_physics_t_rigid_body_set_angular_factor)(urho3d_context *context,  Urho3D::RigidBody *t, Urho3D::Vector3 *v)
{
    t->SetAngularFactor(*v);
}

HL_PRIM Urho3D::Vector3 *HL_NAME(_physics_t_rigid_body_get_angular_factor)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return hl_alloc_urho3d_math_tvector3(t->GetAngularFactor());
}


HL_PRIM void HL_NAME(_physics_t_rigid_body_set_collision_event_mode)(urho3d_context *context,  Urho3D::RigidBody *t, int i)
{
    t->SetCollisionEventMode(CollisionEventMode(i));
}

HL_PRIM int HL_NAME(_physics_t_rigid_body_get_collision_event_mode)(urho3d_context *context,  Urho3D::RigidBody *t)
{
    return t->GetCollisionEventMode();
}

DEFINE_PRIM(HL_URHO3D_RIGID_BODY, _physics_t_rigid_body_cast_to_rigid_body, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);
//TBD ELI
DEFINE_PRIM(HL_URHO3D_T_RIGID_BODY, _physics_t_rigid_body_cast_from_rigid_body, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_mass, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_t_rigid_body_get_mass, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_friction, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_t_rigid_body_get_friction, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_rolling_friction, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_t_rigid_body_get_rolling_friction, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_linear_velocity, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _physics_t_rigid_body_get_linear_velocity, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_trigger, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _BOOL);
DEFINE_PRIM(_BOOL, _physics_t_rigid_body_get_trigger, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_linear_dumping, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_t_rigid_body_get_linear_dumping, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_linear_rest_threshold, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_t_rigid_body_get_linear_rest_threshold, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_angular_dumping, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_t_rigid_body_get_angular_dumping, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_angular_rest_threshold, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_t_rigid_body_get_angular_rest_threshold, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_collision_layer, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _I32);
DEFINE_PRIM(_I32, _physics_t_rigid_body_get_collision_layer, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_collision_mask, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _I32);
DEFINE_PRIM(_I32, _physics_t_rigid_body_get_collision_mask, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_apply_impulse, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY HL_URHO3D_TVECTOR3 HL_URHO3D_TVECTOR3);

DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_angular_factor, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _physics_t_rigid_body_get_angular_factor, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);


DEFINE_PRIM(_VOID, _physics_t_rigid_body_set_collision_event_mode, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY _I32);
DEFINE_PRIM(_I32, _physics_t_rigid_body_get_collision_event_mode, URHO3D_CONTEXT HL_URHO3D_T_RIGID_BODY);