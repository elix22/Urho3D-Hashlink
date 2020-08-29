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

static Urho3D::Quaternion tquaternion_stack[TQUATERNION_STACK_SIZE] = {Urho3D::Quaternion(0.0, 0.0, 0.0)};
static int index_t_quaternion_stack = 0;

Urho3D::Quaternion *hl_alloc_urho3d_math_tquaternion(float x, float y, float z)
{
    Urho3D::Quaternion *v = &(tquaternion_stack[(++index_t_quaternion_stack) % TQUATERNION_STACK_SIZE]);
    *v = Quaternion(x, y, z);
    return v;
}

Urho3D::Quaternion *hl_alloc_urho3d_math_tquaternion(float x, Vector3 & v3)
{
    Urho3D::Quaternion *v = &(tquaternion_stack[(++index_t_quaternion_stack) % TQUATERNION_STACK_SIZE]);
    *v = Quaternion(x, v3);
    return v;
}

hl_urho3d_math_tquaternion *hl_alloc_urho3d_math_tquaternion(const Urho3D::Quaternion &rhs)
{
    Urho3D::Quaternion *v = &(tquaternion_stack[(++index_t_quaternion_stack) % TQUATERNION_STACK_SIZE]);
    *v = rhs;
    return v;
}


HL_PRIM hl_urho3d_math_tquaternion *HL_NAME(_math_t_quaternion_create)(float x, float y, float z)
{
    return hl_alloc_urho3d_math_tquaternion(x, y, z);
}

HL_PRIM hl_urho3d_math_tquaternion *HL_NAME(_math_t_quaternion_create_fv)(float x, Vector3 *v)
{
    return hl_alloc_urho3d_math_tquaternion(x, *v);
}


HL_PRIM hl_urho3d_math_tquaternion * HL_NAME(_math_t_quaternion_cast_from_quaternion)(hl_urho3d_math_quaternion *hv)
{
    Urho3D::Quaternion *v = (Urho3D::Quaternion *)hv->ptr;

    if (v != NULL)
    {
        Urho3D::Quaternion *tv = &(tquaternion_stack[(++index_t_quaternion_stack) % TQUATERNION_STACK_SIZE]);
        *tv = *v;
        return tv;
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_math_quaternion * HL_NAME(_math_t_quaternion_cast_to_quaternion)(hl_urho3d_math_tquaternion *v)
{

    if (v != NULL)
    {
        return  hl_alloc_urho3d_math_quaternion(*v);
    }
    else
    {
        return NULL;
    }
}

//Vector3 operator *(const Vector3& rhs) const
HL_PRIM  Urho3D::Vector3 * HL_NAME(_math_t_quaternion_multiply_tvector3)(Urho3D::Quaternion *q , Urho3D::Vector3 * v)
{
    return  hl_alloc_urho3d_math_tvector3(*q * (*v));
}

HL_PRIM  Urho3D::Quaternion * HL_NAME(_math_t_quaternion_multiply_tquaternion)(Urho3D::Quaternion *q , Urho3D::Quaternion * v)
{
    return  hl_alloc_urho3d_math_tquaternion(*q * (*v));
}

HL_PRIM void HL_NAME(_math_t_quaternion_normalize)(Urho3D::Quaternion *q)
{

        q->Normalize();
    
}
DEFINE_PRIM(_VOID, _math_t_quaternion_normalize, HL_URHO3D_TQUATERNION);

DEFINE_PRIM(HL_URHO3D_TQUATERNION, _math_t_quaternion_create, _F32 _F32 _F32);
DEFINE_PRIM(HL_URHO3D_TQUATERNION, _math_t_quaternion_create_fv, _F32 HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TQUATERNION, _math_t_quaternion_cast_from_quaternion, HL_URHO3D_QUATERNION);
DEFINE_PRIM(HL_URHO3D_QUATERNION, _math_t_quaternion_cast_to_quaternion, HL_URHO3D_TQUATERNION);

DEFINE_PRIM(HL_URHO3D_TVECTOR3, _math_t_quaternion_multiply_tvector3, HL_URHO3D_TQUATERNION HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TQUATERNION, _math_t_quaternion_multiply_tquaternion, HL_URHO3D_TQUATERNION HL_URHO3D_TQUATERNION);