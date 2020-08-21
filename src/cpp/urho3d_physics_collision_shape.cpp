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

HL_PRIM void HL_NAME(_physics_collision_shape_set_box)(urho3d_context *context, hl_urho3d_physics_collision_shape *t, Urho3D::Vector3 *size, Urho3D::Vector3 *position, Urho3D::Quaternion *rotation)
{
    t->ptr->SetBox(*size, *position, *rotation);
}

HL_PRIM void HL_NAME(_physics_collision_shape_set_sphere)(urho3d_context *context, hl_urho3d_physics_collision_shape *t, float diameter, Urho3D::Vector3 *position, Urho3D::Quaternion *rotation)
{
    t->ptr->SetSphere(diameter, *position, *rotation);
}

HL_PRIM void HL_NAME(_physics_collision_shape_set_static_plane)(urho3d_context *context, hl_urho3d_physics_collision_shape *t, Urho3D::Vector3 *position, Urho3D::Quaternion *rotation)
{
    t->ptr->SetStaticPlane(*position, *rotation);
}

HL_PRIM void HL_NAME(_physics_collision_shape_set_cylinder)(urho3d_context *context, hl_urho3d_physics_collision_shape *t, float diameter, float height, Urho3D::Vector3 *position, Urho3D::Quaternion *rotation)
{
    t->ptr->SetCylinder(diameter, height, *position, *rotation);
}

HL_PRIM void HL_NAME(_physics_collision_shape_set_capsule)(urho3d_context *context, hl_urho3d_physics_collision_shape *t, float diameter, float height, Urho3D::Vector3 *position, Urho3D::Quaternion *rotation)
{
    t->ptr->SetCapsule(diameter, height, *position, *rotation);
}

HL_PRIM void HL_NAME(_physics_collision_shape_set_triangle_mesh)(urho3d_context *context, hl_urho3d_physics_collision_shape *t, hl_urho3d_graphics_model *model, int lodLevel, Urho3D::Vector3 *scale, Urho3D::Vector3 *position, Urho3D::Quaternion *rotation)
{
    if (model && model->ptr)
        t->ptr->SetTriangleMesh(model->ptr, lodLevel, *scale, *position, *rotation);
}

DEFINE_PRIM(HL_URHO3D_COLLISION_SHAPE, _physics_collision_shape_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _physics_collision_shape_cast_to_component, URHO3D_CONTEXT HL_URHO3D_COLLISION_SHAPE);
DEFINE_PRIM(HL_URHO3D_COLLISION_SHAPE, _physics_collision_shape_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);
DEFINE_PRIM(_VOID, _physics_collision_shape_set_box, URHO3D_CONTEXT HL_URHO3D_COLLISION_SHAPE HL_URHO3D_TVECTOR3 HL_URHO3D_TVECTOR3 HL_URHO3D_TQUATERNION);

DEFINE_PRIM(_VOID, _physics_collision_shape_set_sphere, URHO3D_CONTEXT HL_URHO3D_COLLISION_SHAPE _F32 HL_URHO3D_TVECTOR3 HL_URHO3D_TQUATERNION);
DEFINE_PRIM(_VOID, _physics_collision_shape_set_static_plane, URHO3D_CONTEXT HL_URHO3D_COLLISION_SHAPE HL_URHO3D_TVECTOR3 HL_URHO3D_TQUATERNION);
DEFINE_PRIM(_VOID, _physics_collision_shape_set_cylinder, URHO3D_CONTEXT HL_URHO3D_COLLISION_SHAPE _F32 _F32 HL_URHO3D_TVECTOR3 HL_URHO3D_TQUATERNION);
DEFINE_PRIM(_VOID, _physics_collision_shape_set_capsule, URHO3D_CONTEXT HL_URHO3D_COLLISION_SHAPE _F32 _F32 HL_URHO3D_TVECTOR3 HL_URHO3D_TQUATERNION);


DEFINE_PRIM(_VOID, _physics_collision_shape_set_triangle_mesh, URHO3D_CONTEXT HL_URHO3D_COLLISION_SHAPE HL_URHO3D_MODEL _I32 HL_URHO3D_TVECTOR3 HL_URHO3D_TVECTOR3 HL_URHO3D_TQUATERNION);