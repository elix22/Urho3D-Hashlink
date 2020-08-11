#define HL_NAME(n) Urho3D_##n
extern "C"
{
#if defined(URHO3D_HAXE_HASHLINK)
#include <hashlink/hl.h>
#else
#include <hl.h>
#endif
}

#include "global_types.h"

void finalize_urho3d_physics_collision_shape(void *v)
{
    hl_urho3d_physics_collision_shape *hl_ptr = (hl_urho3d_physics_collision_shape *)v;
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

hl_urho3d_physics_collision_shape *hl_alloc_urho3d_physics_collision_shape(urho3d_context *context)
{

        hl_urho3d_physics_collision_shape *p = (hl_urho3d_physics_collision_shape *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_physics_collision_shape));
        memset(p, 0, sizeof(hl_urho3d_physics_collision_shape));
        p->finalizer = (void *)finalize_urho3d_physics_collision_shape;
        p->ptr = new Urho3D::CollisionShape(context);
        return p;

}

hl_urho3d_physics_collision_shape *hl_alloc_urho3d_physics_collision_shape(Urho3D::CollisionShape *obj)
{

    hl_urho3d_physics_collision_shape *p = (hl_urho3d_physics_collision_shape *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_physics_collision_shape));
    memset(p, 0, sizeof(hl_urho3d_physics_collision_shape));
    p->finalizer = (void *)finalize_urho3d_physics_collision_shape;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_physics_collision_shape *HL_NAME(_physics_collision_shape_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_physics_collision_shape(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_physics_collision_shape_cast_to_component)(urho3d_context *context, hl_urho3d_physics_collision_shape *t)
{
    return hl_alloc_urho3d_scene_component(t->ptr);
}

HL_PRIM hl_urho3d_physics_collision_shape *HL_NAME(_physics_collision_shape_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return hl_alloc_urho3d_physics_collision_shape(dynamic_cast<CollisionShape *>(cmp));
}

//SetBox(const Vector3& size, const Vector3& position, const Quaternion& rotation)
HL_PRIM void HL_NAME(_physics_collision_shape_set_box)(urho3d_context *context, hl_urho3d_physics_collision_shape *t,Urho3D::Vector3 *size,Urho3D::Vector3 *position,Urho3D::Quaternion *rotation)
{
    t->ptr->SetBox(*size,*position,*rotation);
}

DEFINE_PRIM(HL_URHO3D_COLLISION_SHAPE, _physics_collision_shape_create, URHO3D_CONTEXT );
DEFINE_PRIM(HL_URHO3D_COMPONENT, _physics_collision_shape_cast_to_component, URHO3D_CONTEXT HL_URHO3D_COLLISION_SHAPE);
DEFINE_PRIM(HL_URHO3D_COLLISION_SHAPE, _physics_collision_shape_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);
DEFINE_PRIM(_VOID, _physics_collision_shape_set_box, URHO3D_CONTEXT HL_URHO3D_COLLISION_SHAPE HL_URHO3D_TVECTOR3 HL_URHO3D_TVECTOR3 HL_URHO3D_TQUATERNION);


