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

void finalize_urho3d_math_quaternion(void *v)
{
    hl_urho3d_math_quaternion *uptr = (hl_urho3d_math_quaternion *)v;
    if (uptr)
    {
        if (uptr->ptr)
        {
            delete uptr->ptr;
            uptr->ptr = NULL;
        }
        uptr->finalizer = NULL;
    }
}

hl_urho3d_math_quaternion *hl_alloc_urho3d_math_quaternion(const Urho3D::Quaternion &rhs)
{
    hl_urho3d_math_quaternion *p = (hl_urho3d_math_quaternion *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_quaternion));

    p->finalizer = (void *)finalize_urho3d_math_quaternion;
    p->ptr = new Urho3D::Quaternion(rhs);

    return p;
}

hl_urho3d_math_quaternion *hl_alloc_urho3d_math_quaternion(float x, float y, float z)
{
    hl_urho3d_math_quaternion *p = (hl_urho3d_math_quaternion *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_quaternion));

    p->finalizer = (void *)finalize_urho3d_math_quaternion;
    p->ptr = new Urho3D::Quaternion(x, y, z);
    ;
    return p;
}

HL_PRIM hl_urho3d_math_quaternion *HL_NAME(_math_quaternion_create)(float x, float y, float z)
{
    return hl_alloc_urho3d_math_quaternion(x, y, z);
}



HL_PRIM void HL_NAME(_math_quaternion_set_w)(hl_urho3d_math_quaternion *hv, float w)
{
    if (hv->ptr != NULL)
    {
        hv->ptr->w_= w;
    }
}

HL_PRIM float HL_NAME(_math_quaternion_get_w)(hl_urho3d_math_quaternion *hv)
{
    if (hv->ptr != NULL)
    {
        return hv->ptr->w_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM void HL_NAME(_math_quaternion_set_x)(hl_urho3d_math_quaternion *hv, float x)
{
    if (hv->ptr != NULL)
    {
        hv->ptr->x_= x;
    }
}

HL_PRIM float HL_NAME(_math_quaternion_get_x)(hl_urho3d_math_quaternion *hv)
{
    if (hv->ptr != NULL)
    {
        return hv->ptr->x_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM void HL_NAME(_math_quaternion_set_y)(hl_urho3d_math_quaternion *hv, float y)
{
    if (hv->ptr != NULL)
    {
        hv->ptr->y_= y;
    }
}

HL_PRIM float HL_NAME(_math_quaternion_get_y)(hl_urho3d_math_quaternion *hv)
{
    if (hv->ptr != NULL)
    {
        return hv->ptr->y_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM void HL_NAME(_math_quaternion_set_z)(hl_urho3d_math_quaternion *hv, float z)
{
    if (hv->ptr != NULL)
    {
        hv->ptr->z_= z;
    }
}

HL_PRIM float HL_NAME(_math_quaternion_get_z)(hl_urho3d_math_quaternion *hv)
{
    if (hv->ptr != NULL)
    {
        return hv->ptr->z_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM void HL_NAME(_math_quaternion_set_euler_angles)(hl_urho3d_math_quaternion *hv,float x, float y, float z)
{
    if (hv->ptr != NULL)
    {
        *(hv->ptr) = Quaternion(x,y,z);
    }
}

DEFINE_PRIM(HL_URHO3D_QUATERNION, _math_quaternion_create, _F32 _F32 _F32);
DEFINE_PRIM(_VOID, _math_quaternion_set_w, HL_URHO3D_QUATERNION _F32 );
DEFINE_PRIM(_F32, _math_quaternion_get_w, HL_URHO3D_QUATERNION );
DEFINE_PRIM(_VOID, _math_quaternion_set_x, HL_URHO3D_QUATERNION _F32 );
DEFINE_PRIM(_F32, _math_quaternion_get_x, HL_URHO3D_QUATERNION );
DEFINE_PRIM(_VOID, _math_quaternion_set_y, HL_URHO3D_QUATERNION _F32 );
DEFINE_PRIM(_F32, _math_quaternion_get_y, HL_URHO3D_QUATERNION );
DEFINE_PRIM(_VOID, _math_quaternion_set_z, HL_URHO3D_QUATERNION _F32 );
DEFINE_PRIM(_F32, _math_quaternion_get_z, HL_URHO3D_QUATERNION );
DEFINE_PRIM(_VOID, _math_quaternion_set_euler_angles, HL_URHO3D_QUATERNION _F32 _F32 _F32);
