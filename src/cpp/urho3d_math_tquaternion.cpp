#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

static Urho3D::Quaternion tquaternion_stack[TQUATERNION_STACK_SIZE] = {Urho3D::Quaternion(0.0, 0.0, 0.0)};
static int index_tquaternion_stack = 0;

Urho3D::Quaternion *hl_alloc_urho3d_math_tquaternion(float x, float y, float z)
{
    Urho3D::Quaternion *v = &(tquaternion_stack[(++index_tquaternion_stack) % TQUATERNION_STACK_SIZE]);
    *v = Quaternion(x, y, z);
    return v;
}

hl_urho3d_math_tquaternion *hl_alloc_urho3d_math_tquaternion(const Urho3D::Quaternion &rhs)
{
    Urho3D::Quaternion *v = &(tquaternion_stack[(++index_tquaternion_stack) % TQUATERNION_STACK_SIZE]);
    *v = rhs;
    return v;
}


HL_PRIM hl_urho3d_math_tquaternion *HL_NAME(_math_tquaternion_create)(float x, float y, float z)
{
    return hl_alloc_urho3d_math_tquaternion(x, y, z);
}

HL_PRIM hl_urho3d_math_tquaternion * HL_NAME(_math_tquaternion_cast_from_quaternion)(hl_urho3d_math_quaternion *hv)
{
    Urho3D::Quaternion *v = (Urho3D::Quaternion *)hv->ptr;

    if (v != NULL)
    {
        Urho3D::Quaternion *tv = &(tquaternion_stack[(++index_tquaternion_stack) % TQUATERNION_STACK_SIZE]);
        *tv = *v;
        return tv;
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_math_quaternion * HL_NAME(_math_tquaternion_cast_to_quaternion)(hl_urho3d_math_tquaternion *v)
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


DEFINE_PRIM(HL_URHO3D_TQUATERNION, _math_tquaternion_create, _F32 _F32 _F32);
DEFINE_PRIM(HL_URHO3D_TQUATERNION, _math_tquaternion_cast_from_quaternion, HL_URHO3D_QUATERNION);
DEFINE_PRIM(HL_URHO3D_QUATERNION, _math_tquaternion_cast_to_quaternion, HL_URHO3D_TQUATERNION);
