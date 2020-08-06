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

void finalize_urho3d_math_vector2(void *v)
{
    hl_urho3d_math_vector2 *v2ptr = (hl_urho3d_math_vector2 *)v;
    if (v2ptr)
    {
        Urho3D::Vector2 *vector2 = (Urho3D::Vector2 *)v2ptr->ptr;
        if (vector2)
        {
            //  printf("finalize_urho3d_vector2 %f:%f \n",vector2->x_,vector2->y_);
            delete vector2;
            v2ptr->ptr = NULL;
        }
        v2ptr->finalizer = NULL;
    }
}

hl_urho3d_math_vector2 *hl_alloc_urho3d_math_vector2(const Urho3D::Vector2 &rhs)
{
    hl_urho3d_math_vector2 *p = (hl_urho3d_math_vector2 *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_vector2));

    p->finalizer = (void *)finalize_urho3d_math_vector2;
    Urho3D::Vector2 *v = new Urho3D::Vector2(rhs);
    p->ptr = v;

    return p;
}

hl_urho3d_math_vector2 *hl_alloc_urho3d_math_vector2(float x, float y)
{
    hl_urho3d_math_vector2 *p = (hl_urho3d_math_vector2 *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_vector2));

    p->finalizer = (void *)finalize_urho3d_math_vector2;
    Urho3D::Vector2 *v = new Urho3D::Vector2(x, y);
    p->ptr = v;

    return p;
}


HL_PRIM hl_urho3d_math_vector2 *HL_NAME(_math_vector2_create)(float x, float y)
{
    hl_urho3d_math_vector2 *v = hl_alloc_urho3d_math_vector2(x, y);
    return v;
}

HL_PRIM float HL_NAME(_math_vector2_set_x)(hl_urho3d_math_vector2 *hv, float x)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;

    if (v != NULL)
    {
        v->x_ = x;
        return v->x_;
    }
    else
        return 0.0f;
}

HL_PRIM float HL_NAME(_math_vector2_get_x)(hl_urho3d_math_vector2 *hv)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;

    if (v != NULL)
    {
        return v->x_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_math_vector2_set_y)(hl_urho3d_math_vector2 *hv, float y)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    if (v != NULL)
    {
        v->y_ = y;
        return v->y_;
    }
    else
        return 0.0f;
}

HL_PRIM float HL_NAME(_math_vector2_get_y)(hl_urho3d_math_vector2 *hv)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    if (v != NULL)
    {
        return v->y_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM void HL_NAME(_math_vector2_normalize)(hl_urho3d_math_vector2 *hv)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    if (v != NULL)
    {
        v->Normalize();
    }
}

HL_PRIM float HL_NAME(_math_vector2_length)(hl_urho3d_math_vector2 *hv)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    if (v != NULL)
    {
        return v->Length();
    }
    return 0.0;
}

HL_PRIM float HL_NAME(_math_vector2_length_squared)(hl_urho3d_math_vector2 *hv)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    if (v != NULL)
    {
        return v->LengthSquared();
    }
    return 0.0;
}

HL_PRIM float HL_NAME(_math_vector2_dot_product)(hl_urho3d_math_vector2 *hv, hl_urho3d_math_vector2 *rhs)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    Urho3D::Vector2 *v2 = (Urho3D::Vector2 *)rhs->ptr;
    if (v != NULL && v2 != NULL)
    {
        return v->DotProduct(*v2);
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_math_vector2_abs_dot_product)(hl_urho3d_math_vector2 *hv, hl_urho3d_math_vector2 *rhs)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    Urho3D::Vector2 *v2 = (Urho3D::Vector2 *)rhs->ptr;
    if (v != NULL && v2 != NULL)
    {
        return v->AbsDotProduct(*v2);
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_math_vector2_project_onto_axis)(hl_urho3d_math_vector2 *hv, hl_urho3d_math_vector2 *haxis)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    Urho3D::Vector2 *axis = (Urho3D::Vector2 *)haxis->ptr;
    if (v != NULL && axis != NULL)
    {
        return v->ProjectOntoAxis(*axis);
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_math_vector2_angle)(hl_urho3d_math_vector2 *hv, hl_urho3d_math_vector2 *haxis)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    Urho3D::Vector2 *axis = (Urho3D::Vector2 *)haxis->ptr;
    if (v != NULL && axis != NULL)
    {
        return v->Angle(*axis);
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM hl_urho3d_math_vector2 *HL_NAME(_math_vector2_abs)(hl_urho3d_math_vector2 *hv)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    if (v != NULL)
    {
        return hl_alloc_urho3d_math_vector2(v->Abs());
    }

    return NULL;
}

HL_PRIM hl_urho3d_math_vector2 *HL_NAME(_math_vector2_lerp)(hl_urho3d_math_vector2 *hv, hl_urho3d_math_vector2 *haxis, float t)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    Urho3D::Vector2 *axis = (Urho3D::Vector2 *)haxis->ptr;
    if (v != NULL && axis != NULL)
    {
        Vector2 temp = v->Lerp(*axis, t);
        return hl_alloc_urho3d_math_vector2(temp);
    }

    return NULL;
}

HL_PRIM bool HL_NAME(_math_vector2_equals)(hl_urho3d_math_vector2 *hv, hl_urho3d_math_vector2 *hv2)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    Urho3D::Vector2 *rhs = (Urho3D::Vector2 *)hv2->ptr;
    if (v != NULL && rhs != NULL)
    {
        return v->Equals(*rhs);
    }
    else
    {
        return false;
    }
}

HL_PRIM bool HL_NAME(_math_vector2_is_nan)(hl_urho3d_math_vector2 *hv)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    if (v != NULL)
    {
        return v->IsNaN();
    }
    return false;
}

HL_PRIM bool HL_NAME(_math_vector2_is_inf)(hl_urho3d_math_vector2 *hv)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    if (v != NULL)
    {
        return v->IsInf();
    }
    return false;
}

HL_PRIM hl_urho3d_math_vector2 *HL_NAME(_math_vector2_normalized)(hl_urho3d_math_vector2 *hv)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    if (v != NULL)
    {
        return hl_alloc_urho3d_math_vector2(v->Normalized());
    }

    return NULL;
}

HL_PRIM hl_urho3d_math_vector2 *HL_NAME(_math_vector2_normalized_or_default)(hl_urho3d_math_vector2 *hv, hl_urho3d_math_vector2 *hv2, float eps)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    Urho3D::Vector2 *rhs = (Urho3D::Vector2 *)hv2->ptr;
    if (v != NULL && rhs != NULL)
    {
        Vector2 temp = v->NormalizedOrDefault(*rhs, eps);
        return hl_alloc_urho3d_math_vector2(temp);
    }

    return NULL;
}

HL_PRIM hl_urho3d_math_vector2 *HL_NAME(_math_vector2_renormalized)(hl_urho3d_math_vector2 *hv, float minLength, float maxLength, hl_urho3d_math_vector2 *defaultValue, float eps)
{
    Urho3D::Vector2 *v = (Urho3D::Vector2 *)hv->ptr;
    Urho3D::Vector2 *rhs = (Urho3D::Vector2 *)defaultValue->ptr;
    if (v != NULL && rhs != NULL)
    {
        Vector2 temp = v->ReNormalized(minLength, maxLength, *rhs, eps);
        return hl_alloc_urho3d_math_vector2(temp);
    }

    return NULL;
}

DEFINE_PRIM(HL_URHO3D_VECTOR2, _math_vector2_create, _F32 _F32);
DEFINE_PRIM(_F32, _math_vector2_set_x, HL_URHO3D_VECTOR2 _F32);
DEFINE_PRIM(_F32, _math_vector2_get_x, HL_URHO3D_VECTOR2);
DEFINE_PRIM(_F32, _math_vector2_set_y, HL_URHO3D_VECTOR2 _F32);
DEFINE_PRIM(_F32, _math_vector2_get_y, HL_URHO3D_VECTOR2);
DEFINE_PRIM(_VOID, _math_vector2_normalize, HL_URHO3D_VECTOR2);
DEFINE_PRIM(_F32, _math_vector2_length, HL_URHO3D_VECTOR2);
DEFINE_PRIM(_F32, _math_vector2_length_squared, HL_URHO3D_VECTOR2);
DEFINE_PRIM(_F32, _math_vector2_dot_product, HL_URHO3D_VECTOR2 HL_URHO3D_VECTOR2);
DEFINE_PRIM(_F32, _math_vector2_abs_dot_product, HL_URHO3D_VECTOR2 HL_URHO3D_VECTOR2);
DEFINE_PRIM(_F32, _math_vector2_project_onto_axis, HL_URHO3D_VECTOR2 HL_URHO3D_VECTOR2);
DEFINE_PRIM(_F32, _math_vector2_angle, HL_URHO3D_VECTOR2 HL_URHO3D_VECTOR2);
DEFINE_PRIM(HL_URHO3D_VECTOR2, _math_vector2_abs, HL_URHO3D_VECTOR2);
DEFINE_PRIM(HL_URHO3D_VECTOR2, _math_vector2_lerp, HL_URHO3D_VECTOR2 HL_URHO3D_VECTOR2 _F32);
DEFINE_PRIM(_BOOL, _math_vector2_equals, HL_URHO3D_VECTOR2 HL_URHO3D_VECTOR2);
DEFINE_PRIM(_BOOL, _math_vector2_is_nan, HL_URHO3D_VECTOR2);
DEFINE_PRIM(_BOOL, _math_vector2_is_inf, HL_URHO3D_VECTOR2);
DEFINE_PRIM(HL_URHO3D_VECTOR2, _math_vector2_normalized, HL_URHO3D_VECTOR2);
DEFINE_PRIM(HL_URHO3D_VECTOR2, _math_vector2_normalized_or_default, HL_URHO3D_VECTOR2 HL_URHO3D_VECTOR2 _F32);
DEFINE_PRIM(HL_URHO3D_VECTOR2, _math_vector2_renormalized, HL_URHO3D_VECTOR2 _F32 _F32 HL_URHO3D_VECTOR2 _F32);

