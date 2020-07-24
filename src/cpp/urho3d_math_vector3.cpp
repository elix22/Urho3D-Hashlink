#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_math_vector3(void *v)
{
    hl_urho3d_math_vector3 *uptr = (hl_urho3d_math_vector3 *)v;
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

hl_urho3d_math_vector3 *hl_alloc_urho3d_math_vector3(const Urho3D::Vector3 &rhs)
{
    hl_urho3d_math_vector3 *p = (hl_urho3d_math_vector3 *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_vector3));

    p->finalizer = (void *)finalize_urho3d_math_vector3;
    Urho3D::Vector3 *v = new Urho3D::Vector3(rhs);
    p->ptr = v;

    return p;
}

hl_urho3d_math_vector3 *hl_alloc_urho3d_math_vector3(float x, float y, float z)
{
    hl_urho3d_math_vector3 *p = (hl_urho3d_math_vector3 *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_vector3));

    p->finalizer = (void *)finalize_urho3d_math_vector3;
    Urho3D::Vector3 *v = new Urho3D::Vector3(x, y, z);
    p->ptr = v;

    return p;
}

HL_PRIM hl_urho3d_math_vector3 *HL_NAME(_math_vector3_create)(float x, float y, float z)
{
    hl_urho3d_math_vector3 *v = hl_alloc_urho3d_math_vector3(x, y, z);
    return v;
}

HL_PRIM float HL_NAME(_math_vector3_set_x)(hl_urho3d_math_vector3 *hv, float x)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;

    if (v != NULL)
    {
        v->x_ = x;
        return v->x_;
    }
    else
        return 0.0f;
}

HL_PRIM float HL_NAME(_math_vector3_get_x)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;

    if (v != NULL)
    {
        return v->x_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_math_vector3_set_y)(hl_urho3d_math_vector3 *hv, float y)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        v->y_ = y;
        return v->y_;
    }
    else
        return 0.0f;
}

HL_PRIM float HL_NAME(_math_vector3_get_y)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        return v->y_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_math_vector3_set_z)(hl_urho3d_math_vector3 *hv, float z)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        v->z_ = z;
        return v->z_;
    }
    else
        return 0.0f;
}

HL_PRIM float HL_NAME(_math_vector3_get_z)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        return v->z_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM void HL_NAME(_math_vector3_normalize)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        v->Normalize();
    }
}

HL_PRIM float HL_NAME(_math_vector3_length)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        return v->Length();
    }
    return 0.0;
}

HL_PRIM float HL_NAME(_math_vector3_length_squared)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        return v->LengthSquared();
    }
    return 0.0;
}

HL_PRIM float HL_NAME(_math_vector3_dot_product)(hl_urho3d_math_vector3 *hv, hl_urho3d_math_vector3 *rhs)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    Urho3D::Vector3 *v2 = (Urho3D::Vector3 *)rhs->ptr;
    if (v != NULL && v2 != NULL)
    {
        return v->DotProduct(*v2);
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_math_vector3_abs_dot_product)(hl_urho3d_math_vector3 *hv, hl_urho3d_math_vector3 *rhs)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    Urho3D::Vector3 *v2 = (Urho3D::Vector3 *)rhs->ptr;
    if (v != NULL && v2 != NULL)
    {
        return v->AbsDotProduct(*v2);
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_math_vector3_project_onto_axis)(hl_urho3d_math_vector3 *hv, hl_urho3d_math_vector3 *haxis)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    Urho3D::Vector3 *axis = (Urho3D::Vector3 *)haxis->ptr;
    if (v != NULL && axis != NULL)
    {
        return v->ProjectOntoAxis(*axis);
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_math_vector3_angle)(hl_urho3d_math_vector3 *hv, hl_urho3d_math_vector3 *haxis)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    Urho3D::Vector3 *axis = (Urho3D::Vector3 *)haxis->ptr;
    if (v != NULL && axis != NULL)
    {
        return v->Angle(*axis);
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM hl_urho3d_math_vector3 *HL_NAME(_math_vector3_abs)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        return hl_alloc_urho3d_math_vector3(v->Abs());
    }

    return NULL;
}

HL_PRIM hl_urho3d_math_vector3 *HL_NAME(_math_vector3_lerp)(hl_urho3d_math_vector3 *hv, hl_urho3d_math_vector3 *haxis, float t)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    Urho3D::Vector3 *axis = (Urho3D::Vector3 *)haxis->ptr;
    if (v != NULL && axis != NULL)
    {
        Vector3 temp = v->Lerp(*axis, t);
        return hl_alloc_urho3d_math_vector3(temp);
    }

    return NULL;
}

HL_PRIM bool HL_NAME(_math_vector3_equals)(hl_urho3d_math_vector3 *hv, hl_urho3d_math_vector3 *hv2)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    Urho3D::Vector3 *rhs = (Urho3D::Vector3 *)hv2->ptr;
    if (v != NULL && rhs != NULL)
    {
        return v->Equals(*rhs);
    }
    else
    {
        return false;
    }
}

HL_PRIM bool HL_NAME(_math_vector3_is_nan)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        return v->IsNaN();
    }
    return false;
}

HL_PRIM bool HL_NAME(_math_vector3_is_inf)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        return v->IsInf();
    }
    return false;
}

HL_PRIM hl_urho3d_math_vector3 *HL_NAME(_math_vector3_normalized)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    if (v != NULL)
    {
        return hl_alloc_urho3d_math_vector3(v->Normalized());
    }

    return NULL;
}

HL_PRIM hl_urho3d_math_vector3 *HL_NAME(_math_vector3_normalized_or_default)(hl_urho3d_math_vector3 *hv, hl_urho3d_math_vector3 *hv2, float eps)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    Urho3D::Vector3 *rhs = (Urho3D::Vector3 *)hv2->ptr;
    if (v != NULL && rhs != NULL)
    {
        Vector3 temp = v->NormalizedOrDefault(*rhs, eps);
        return hl_alloc_urho3d_math_vector3(temp);
    }

    return NULL;
}

HL_PRIM hl_urho3d_math_vector3 *HL_NAME(_math_vector3_renormalized)(hl_urho3d_math_vector3 *hv, float minLength, float maxLength, hl_urho3d_math_vector3 *defaultValue, float eps)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;
    Urho3D::Vector3 *rhs = (Urho3D::Vector3 *)defaultValue->ptr;
    if (v != NULL && rhs != NULL)
    {
        Vector3 temp = v->ReNormalized(minLength, maxLength, *rhs, eps);
        return hl_alloc_urho3d_math_vector3(temp);
    }

    return NULL;
}

DEFINE_PRIM(HL_URHO3D_VECTOR3, _math_vector3_create, _F32 _F32 _F32);
DEFINE_PRIM(_F32, _math_vector3_set_x, HL_URHO3D_VECTOR3 _F32);
DEFINE_PRIM(_F32, _math_vector3_get_x, HL_URHO3D_VECTOR3);
DEFINE_PRIM(_F32, _math_vector3_set_y, HL_URHO3D_VECTOR3 _F32);
DEFINE_PRIM(_F32, _math_vector3_get_y, HL_URHO3D_VECTOR3);
DEFINE_PRIM(_F32, _math_vector3_set_z, HL_URHO3D_VECTOR3 _F32);
DEFINE_PRIM(_F32, _math_vector3_get_z, HL_URHO3D_VECTOR3);
DEFINE_PRIM(_VOID, _math_vector3_normalize, HL_URHO3D_VECTOR3);
DEFINE_PRIM(_F32, _math_vector3_length, HL_URHO3D_VECTOR3);
DEFINE_PRIM(_F32, _math_vector3_length_squared, HL_URHO3D_VECTOR3);
DEFINE_PRIM(_F32, _math_vector3_dot_product, HL_URHO3D_VECTOR3 HL_URHO3D_VECTOR3);
DEFINE_PRIM(_F32, _math_vector3_abs_dot_product, HL_URHO3D_VECTOR3 HL_URHO3D_VECTOR3);
DEFINE_PRIM(_F32, _math_vector3_project_onto_axis, HL_URHO3D_VECTOR3 HL_URHO3D_VECTOR3);
DEFINE_PRIM(_F32, _math_vector3_angle, HL_URHO3D_VECTOR3 HL_URHO3D_VECTOR3);
DEFINE_PRIM(HL_URHO3D_VECTOR3, _math_vector3_abs, HL_URHO3D_VECTOR3);
DEFINE_PRIM(HL_URHO3D_VECTOR3, _math_vector3_lerp, HL_URHO3D_VECTOR3 HL_URHO3D_VECTOR3 _F32);
DEFINE_PRIM(_BOOL, _math_vector3_equals, HL_URHO3D_VECTOR3 HL_URHO3D_VECTOR3);
DEFINE_PRIM(_BOOL, _math_vector3_is_nan, HL_URHO3D_VECTOR3);
DEFINE_PRIM(_BOOL, _math_vector3_is_inf, HL_URHO3D_VECTOR3);
DEFINE_PRIM(HL_URHO3D_VECTOR3, _math_vector3_normalized, HL_URHO3D_VECTOR3);
DEFINE_PRIM(HL_URHO3D_VECTOR3, _math_vector3_normalized_or_default, HL_URHO3D_VECTOR3 HL_URHO3D_VECTOR3 _F32);
DEFINE_PRIM(HL_URHO3D_VECTOR3, _math_vector3_renormalized, HL_URHO3D_VECTOR3 _F32 _F32 HL_URHO3D_VECTOR3 _F32);
