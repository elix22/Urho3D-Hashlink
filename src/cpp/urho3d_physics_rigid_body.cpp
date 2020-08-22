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

void finalize_urho3d_physics_rigid_body(void *v)
{
    hl_urho3d_physics_rigid_body *hl_ptr = (hl_urho3d_physics_rigid_body *)v;
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

hl_urho3d_physics_rigid_body *hl_alloc_urho3d_physics_rigid_body(urho3d_context *context)
{

    hl_urho3d_physics_rigid_body *p = (hl_urho3d_physics_rigid_body *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_physics_rigid_body));
    memset(p, 0, sizeof(hl_urho3d_physics_rigid_body));
    p->finalizer = (void *)finalize_urho3d_physics_rigid_body;
    p->ptr = new Urho3D::RigidBody(context);
    return p;
}

hl_urho3d_physics_rigid_body *hl_alloc_urho3d_physics_rigid_body(Urho3D::RigidBody *obj)
{

    hl_urho3d_physics_rigid_body *p = (hl_urho3d_physics_rigid_body *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_physics_rigid_body));
    memset(p, 0, sizeof(hl_urho3d_physics_rigid_body));
    p->finalizer = (void *)finalize_urho3d_physics_rigid_body;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_physics_rigid_body *HL_NAME(_physics_rigid_body_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_physics_rigid_body(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_physics_rigid_body_cast_to_component)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return hl_alloc_urho3d_scene_component(t->ptr);
}

HL_PRIM hl_urho3d_physics_rigid_body *HL_NAME(_physics_rigid_body_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return hl_alloc_urho3d_physics_rigid_body(dynamic_cast<RigidBody *>(cmp));
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_mass)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, float mass)
{
    t->ptr->SetMass(mass);
}

HL_PRIM float HL_NAME(_physics_rigid_body_get_mass)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetMass();
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_friction)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, float friction)
{
    t->ptr->SetFriction(friction);
}

HL_PRIM float HL_NAME(_physics_rigid_body_get_friction)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetFriction();
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_rolling_friction)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, float friction)
{
    t->ptr->SetRollingFriction(friction);
}

HL_PRIM float HL_NAME(_physics_rigid_body_get_rolling_friction)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetRollingFriction();
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_linear_velocity)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, Urho3D::Vector3 *v)
{
    t->ptr->SetLinearVelocity(*v);
}

HL_PRIM Urho3D::Vector3 *HL_NAME(_physics_rigid_body_get_linear_velocity)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return hl_alloc_urho3d_math_tvector3(t->ptr->GetLinearVelocity());
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_trigger)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, bool b)
{
    t->ptr->SetTrigger(b);
}

HL_PRIM bool HL_NAME(_physics_rigid_body_get_trigger)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->IsTrigger();
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_linear_dumping)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, float f)
{
    t->ptr->SetLinearDamping(f);
}

HL_PRIM float HL_NAME(_physics_rigid_body_get_linear_dumping)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetLinearDamping();
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_linear_rest_threshold)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, float f)
{
    t->ptr->SetLinearRestThreshold(f);
}

HL_PRIM float HL_NAME(_physics_rigid_body_get_linear_rest_threshold)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetLinearRestThreshold();
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_angular_dumping)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, float f)
{
    t->ptr->SetAngularDamping(f);
}

HL_PRIM float HL_NAME(_physics_rigid_body_get_angular_dumping)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetAngularDamping();
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_angular_rest_threshold)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, float f)
{
    t->ptr->SetAngularRestThreshold(f);
}

HL_PRIM float HL_NAME(_physics_rigid_body_get_angular_rest_threshold)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetAngularRestThreshold();
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_collision_layer)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, int i)
{
    t->ptr->SetCollisionLayer(i);
}

HL_PRIM int HL_NAME(_physics_rigid_body_get_collision_layer)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetCollisionLayer();
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_collision_mask)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, int i)
{
    t->ptr->SetCollisionMask(i);
}

HL_PRIM int HL_NAME(_physics_rigid_body_get_collision_mask)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetCollisionMask();
}


HL_PRIM void HL_NAME(_physics_rigid_body_apply_impulse)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, Urho3D::Vector3 *impulse, Urho3D::Vector3 *position)
{
    if (*position != Vector3::ZERO)
    {
        t->ptr->ApplyImpulse(*impulse, *position);
    }
    else
    {
        t->ptr->ApplyImpulse(*impulse);
    }
}

HL_PRIM void HL_NAME(_physics_rigid_body_set_angular_factor)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, Urho3D::Vector3 *v)
{
    t->ptr->SetAngularFactor(*v);
}

HL_PRIM Urho3D::Vector3 *HL_NAME(_physics_rigid_body_get_angular_factor)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return hl_alloc_urho3d_math_tvector3(t->ptr->GetAngularFactor());
}


HL_PRIM void HL_NAME(_physics_rigid_body_set_collision_event_mode)(urho3d_context *context, hl_urho3d_physics_rigid_body *t, int i)
{
    t->ptr->SetCollisionEventMode(CollisionEventMode(i));
}

HL_PRIM int HL_NAME(_physics_rigid_body_get_collision_event_mode)(urho3d_context *context, hl_urho3d_physics_rigid_body *t)
{
    return t->ptr->GetCollisionEventMode();
}

DEFINE_PRIM(HL_URHO3D_RIGID_BODY, _physics_rigid_body_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _physics_rigid_body_cast_to_component, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);
DEFINE_PRIM(HL_URHO3D_RIGID_BODY, _physics_rigid_body_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_mass, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_rigid_body_get_mass, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_friction, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_rigid_body_get_friction, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_rolling_friction, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_rigid_body_get_rolling_friction, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_linear_velocity, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _physics_rigid_body_get_linear_velocity, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_trigger, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _BOOL);
DEFINE_PRIM(_BOOL, _physics_rigid_body_get_trigger, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_linear_dumping, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_rigid_body_get_linear_dumping, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_linear_rest_threshold, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_rigid_body_get_linear_rest_threshold, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_angular_dumping, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_rigid_body_get_angular_dumping, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_angular_rest_threshold, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _F32);
DEFINE_PRIM(_F32, _physics_rigid_body_get_angular_rest_threshold, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_collision_layer, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _I32);
DEFINE_PRIM(_I32, _physics_rigid_body_get_collision_layer, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_collision_mask, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _I32);
DEFINE_PRIM(_I32, _physics_rigid_body_get_collision_mask, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);

DEFINE_PRIM(_VOID, _physics_rigid_body_apply_impulse, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY HL_URHO3D_TVECTOR3 HL_URHO3D_TVECTOR3);

DEFINE_PRIM(_VOID, _physics_rigid_body_set_angular_factor, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _physics_rigid_body_get_angular_factor, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);


DEFINE_PRIM(_VOID, _physics_rigid_body_set_collision_event_mode, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY _I32);
DEFINE_PRIM(_I32, _physics_rigid_body_get_collision_event_mode, URHO3D_CONTEXT HL_URHO3D_RIGID_BODY);