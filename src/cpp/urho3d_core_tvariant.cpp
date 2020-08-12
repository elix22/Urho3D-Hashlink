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

static Urho3D::Variant tvariant_stack[TVARIANT_STACK_SIZE] = {Urho3D::Variant()};
static int index_tvariant_stack = 0;

hl_urho3d_tvariant *hl_alloc_urho3d_tvariant()
{
    Urho3D::Variant *v = &(tvariant_stack[(++index_tvariant_stack) % TVARIANT_STACK_SIZE]);
    return v;
}

hl_urho3d_tvariant *hl_alloc_urho3d_tvariant(Variant &rhs)
{
    Urho3D::Variant *v = &(tvariant_stack[(++index_tvariant_stack) % TVARIANT_STACK_SIZE]);
    *v = rhs;
    return v;
}

HL_PRIM hl_urho3d_tvariant *HL_NAME(_create_tvariant)()
{
    hl_urho3d_tvariant *v = hl_alloc_urho3d_tvariant();
    return v;
}

HL_PRIM Urho3D::Variant * HL_NAME(_math_tvariant_cast_from_variant)(hl_urho3d_variant *hv)
{
    Urho3D::Variant *v = (Urho3D::Variant *)hv->ptr;

    if (v != NULL)
    {
        return hl_alloc_urho3d_tvariant(*v);
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_variant * HL_NAME(_math_tvariant_cast_to_variant)(Urho3D::Variant *v)
{

    if (v != NULL)
    {
        return hl_alloc_urho3d_variant(*v);
    }
    else
    {
        return NULL;
    }
}


HL_PRIM void HL_NAME(_tvariant_set_int)(hl_urho3d_tvariant *variant, int i)
{

    if (variant != NULL)
    {
        *variant = i;
        // printf("variant set  int:%d\n",variant->GetInt());
    }
}

HL_PRIM int HL_NAME(_tvariant_get_int)(hl_urho3d_tvariant *variant)
{

    if (variant != NULL)
    {
        return variant->GetInt();
    }

    return 0;
}

HL_PRIM void HL_NAME(_tvariant_set_float)(hl_urho3d_tvariant *variant, float val)
{

    if (variant != NULL)
    {
        *variant = val;

        // printf("variant set  float :%f\n",variant->GetFloat());
    }
}

HL_PRIM float HL_NAME(_tvariant_get_float)(hl_urho3d_tvariant *variant)
{
    if (variant != NULL)
    {
        // printf("variant get  float :%f\n",variant->GetFloat());
        return variant->GetFloat();
    }
    return 0.0;
}

HL_PRIM void HL_NAME(_tvariant_set_vector2)(hl_urho3d_tvariant *variant, hl_urho3d_math_vector2 *hl_vec)
{
    Urho3D::Vector2 *vector2 = (Urho3D::Vector2 *)hl_vec->ptr;

    if (variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
        // printf("variant set  vector:%f:%f\n",variant->GetVector2().x_,variant->GetVector2().y_);
    }
}

HL_PRIM hl_urho3d_math_vector2 *HL_NAME(_tvariant_get_vector2)(hl_urho3d_tvariant *variant)
{

    if (variant != NULL)
    {
        return hl_alloc_urho3d_math_vector2(variant->GetVector2());
    }
    else
    {
        return NULL;
    }
}

HL_PRIM void HL_NAME(_tvariant_set_tvector2)(hl_urho3d_tvariant *variant, Urho3D::Vector2 *vector2)
{

    if (variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
    }
}

HL_PRIM Urho3D::Vector2 *HL_NAME(_tvariant_get_tvector2)(hl_urho3d_tvariant *variant, Urho3D::Vector2 *vector2)
{

    if (variant != NULL && vector2 != NULL)
    {
        return hl_alloc_urho3d_math_tvector2(variant->GetVector2());
    }
    else
    {
        return NULL;
    }
}

HL_PRIM void HL_NAME(_tvariant_set_tintvector2)(hl_urho3d_tvariant *variant, Urho3D::IntVector2 *vector2)
{

    if (variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
    }
}

HL_PRIM Urho3D::IntVector2 *HL_NAME(_tvariant_get_tintvector2)(hl_urho3d_tvariant *variant)
{

    if (variant != NULL)
    {
        return hl_alloc_urho3d_math_tintvector2(variant->GetIntVector2());
    }
    else
    {
        return NULL;
    }
}

DEFINE_PRIM(HL_URHO3D_TVARIANT, _math_tvariant_cast_from_variant, HL_URHO3D_VARIANT);
DEFINE_PRIM(HL_URHO3D_VARIANT, _math_tvariant_cast_to_variant, HL_URHO3D_TVARIANT);

DEFINE_PRIM(HL_URHO3D_TVARIANT, _create_tvariant, _NO_ARG);
DEFINE_PRIM(_VOID, _tvariant_set_int, HL_URHO3D_TVARIANT _I32);
DEFINE_PRIM(_I32, _tvariant_get_int, HL_URHO3D_TVARIANT);
DEFINE_PRIM(_VOID, _tvariant_set_float, HL_URHO3D_TVARIANT _F32);
DEFINE_PRIM(_F32, _tvariant_get_float, HL_URHO3D_TVARIANT);
DEFINE_PRIM(_VOID, _tvariant_set_vector2, HL_URHO3D_TVARIANT HL_URHO3D_VECTOR2);
DEFINE_PRIM(HL_URHO3D_VECTOR2, _tvariant_get_vector2, HL_URHO3D_TVARIANT);
DEFINE_PRIM(_VOID, _tvariant_set_tvector2, HL_URHO3D_TVARIANT HL_URHO3D_TVECTOR2);
DEFINE_PRIM(HL_URHO3D_TVECTOR2, _tvariant_get_tvector2, HL_URHO3D_TVARIANT);
DEFINE_PRIM(_VOID, _tvariant_set_tintvector2, HL_URHO3D_TVARIANT HL_URHO3D_TINTVECTOR2);
DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _tvariant_get_tintvector2, HL_URHO3D_TVARIANT);

//
//
