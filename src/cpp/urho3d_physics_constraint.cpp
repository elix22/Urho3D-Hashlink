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

void finalize_urho3d_physics_constraint(void *v)
{
    hl_urho3d_physics_constraint *hl_ptr = (hl_urho3d_physics_constraint *)v;
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

hl_urho3d_physics_constraint *hl_alloc_urho3d_physics_constraint(urho3d_context *context)
{

        hl_urho3d_physics_constraint *p = (hl_urho3d_physics_constraint *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_physics_constraint));
        memset(p, 0, sizeof(hl_urho3d_physics_constraint));
        p->finalizer = (void *)finalize_urho3d_physics_constraint;
        p->ptr = new Urho3D::Constraint(context);
        return p;

}

hl_urho3d_physics_constraint *hl_alloc_urho3d_physics_constraint(Urho3D::Constraint *obj)
{

    hl_urho3d_physics_constraint *p = (hl_urho3d_physics_constraint *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_physics_constraint));
    memset(p, 0, sizeof(hl_urho3d_physics_constraint));
    p->finalizer = (void *)finalize_urho3d_physics_constraint;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_physics_constraint *HL_NAME(_physics_constraint_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_physics_constraint(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_physics_constraint_cast_to_component)(urho3d_context *context, hl_urho3d_physics_constraint *t)
{
    return hl_alloc_urho3d_scene_component(t->ptr);
}

HL_PRIM hl_urho3d_physics_constraint *HL_NAME(_physics_constraint_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return hl_alloc_urho3d_physics_constraint(dynamic_cast<Constraint *>(cmp));
}



HL_PRIM void HL_NAME(_physics_constraint_set_type)(urho3d_context *context,hl_urho3d_physics_constraint * obj , int type)
{
    obj->ptr->SetConstraintType(ConstraintType(type));
}


HL_PRIM int  HL_NAME(_physics_constraint_get_type)(urho3d_context *context,hl_urho3d_physics_constraint * obj )
{
    return obj->ptr->GetConstraintType();
}



HL_PRIM void HL_NAME(_physics_constraint_set_disable_collision)(urho3d_context *context,hl_urho3d_physics_constraint * obj , bool disable)
{
    obj->ptr->SetDisableCollision(disable);
}



HL_PRIM bool HL_NAME(_physics_constraint_get_disable_collision)(urho3d_context *context,hl_urho3d_physics_constraint * obj)
{
    return obj->ptr->GetDisableCollision();
}



HL_PRIM void HL_NAME(_physics_constraint_set_other_body)(urho3d_context *context,hl_urho3d_physics_constraint * obj , hl_urho3d_physics_rigid_body * body)
{
    obj->ptr->SetOtherBody(body->ptr);
}



HL_PRIM hl_urho3d_physics_rigid_body * HL_NAME(_physics_constraint_get_other_body)(urho3d_context *context,hl_urho3d_physics_constraint * obj )
{
    return hl_alloc_urho3d_physics_rigid_body(obj->ptr->GetOtherBody());
}



HL_PRIM void HL_NAME(_physics_constraint_set_world_position)(urho3d_context *context,hl_urho3d_physics_constraint * obj ,Urho3D::Vector3 * position)
{
    obj->ptr->SetWorldPosition(*position);
}



HL_PRIM Urho3D::Vector3 *  HL_NAME(_physics_constraint_get_world_position)(urho3d_context *context,hl_urho3d_physics_constraint * obj )
{
    return hl_alloc_urho3d_math_tvector3(obj->ptr->GetWorldPosition());
}



HL_PRIM void HL_NAME(_physics_constraint_set_axis)(urho3d_context *context,hl_urho3d_physics_constraint * obj ,Urho3D::Vector3 * axis)
{
    obj->ptr->SetAxis(*axis);
}



HL_PRIM void HL_NAME(_physics_constraint_set_other_axis)(urho3d_context *context,hl_urho3d_physics_constraint * obj ,Urho3D::Vector3 * axis)
{
    obj->ptr->SetOtherAxis(*axis);
}



HL_PRIM void HL_NAME(_physics_constraint_set_high_limit)(urho3d_context *context,hl_urho3d_physics_constraint * obj ,Urho3D::Vector2 * limit)
{
    obj->ptr->SetHighLimit(*limit);
}



HL_PRIM Urho3D::Vector2 *  HL_NAME(_physics_constraint_get_high_limit)(urho3d_context *context,hl_urho3d_physics_constraint * obj )
{
    return hl_alloc_urho3d_math_tvector2(obj->ptr->GetHighLimit());
}



HL_PRIM void HL_NAME(_physics_constraint_set_low_limit)(urho3d_context *context,hl_urho3d_physics_constraint * obj ,Urho3D::Vector2 * limit)
{
    obj->ptr->SetLowLimit(*limit);
}



HL_PRIM Urho3D::Vector2 *  HL_NAME(_physics_constraint_get_low_limit)(urho3d_context *context,hl_urho3d_physics_constraint * obj )
{
    return hl_alloc_urho3d_math_tvector2(obj->ptr->GetLowLimit());
}



DEFINE_PRIM(HL_URHO3D_CONSTRAINT, _physics_constraint_create, URHO3D_CONTEXT );
DEFINE_PRIM(HL_URHO3D_COMPONENT, _physics_constraint_cast_to_component, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT);
DEFINE_PRIM(HL_URHO3D_CONSTRAINT, _physics_constraint_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);

DEFINE_PRIM(_VOID, _physics_constraint_set_type, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT _I32);
DEFINE_PRIM(_I32, _physics_constraint_get_type, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT );
DEFINE_PRIM(_VOID, _physics_constraint_set_disable_collision, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT _BOOL);
DEFINE_PRIM(_BOOL, _physics_constraint_get_disable_collision, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT );
DEFINE_PRIM(_VOID, _physics_constraint_set_other_body, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT HL_URHO3D_RIGID_BODY);
DEFINE_PRIM(HL_URHO3D_RIGID_BODY, _physics_constraint_get_other_body, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT );
DEFINE_PRIM(_VOID, _physics_constraint_set_world_position, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _physics_constraint_get_world_position, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT );
DEFINE_PRIM(_VOID, _physics_constraint_set_axis, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT HL_URHO3D_TVECTOR3);
DEFINE_PRIM(_VOID, _physics_constraint_set_other_axis, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT HL_URHO3D_TVECTOR3);
DEFINE_PRIM(_VOID, _physics_constraint_set_high_limit, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT HL_URHO3D_TVECTOR2);
DEFINE_PRIM(HL_URHO3D_TVECTOR2, _physics_constraint_get_high_limit, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT );
DEFINE_PRIM(_VOID, _physics_constraint_set_low_limit, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT HL_URHO3D_TVECTOR2);
DEFINE_PRIM(HL_URHO3D_TVECTOR2, _physics_constraint_get_low_limit, URHO3D_CONTEXT HL_URHO3D_CONSTRAINT );