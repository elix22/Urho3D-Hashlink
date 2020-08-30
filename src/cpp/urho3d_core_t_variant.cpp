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


HL_PRIM void HL_NAME(_tvariant_set_bool)(hl_urho3d_tvariant *variant, bool i)
{

    if (variant != NULL)
    {
        *variant = i;
    }
}

HL_PRIM bool HL_NAME(_tvariant_get_bool)(hl_urho3d_tvariant *variant)
{

    if (variant != NULL)
    {
        return variant->GetBool();
    }

    return false;
}

//////////
HL_PRIM void HL_NAME(_tvariant_set_int)(hl_urho3d_tvariant *variant, int i)
{

    if (variant != NULL)
    {
        *variant = i;
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

HL_PRIM void HL_NAME(_tvariant_set_t_color)(hl_urho3d_tvariant *variant, Urho3D::Color *color)
{

    if (variant != NULL && color != NULL)
    {
        *variant = *color;
    }
}

HL_PRIM Urho3D::Color * HL_NAME(_tvariant_get_t_color)(hl_urho3d_tvariant *variant)
{
    if (variant != NULL)
    {
        return hl_alloc_urho3d_math_tcolor(variant->GetColor());
    }
}


HL_PRIM Urho3D::Object * HL_NAME(_tvariant_get_object)(hl_urho3d_tvariant * variant)
{

    if(variant != NULL)
    {
        return (Urho3D::Object *)variant->GetPtr();
    }
    else
    {
        return NULL;
    }
}

HL_PRIM void  HL_NAME(_tvariant_set_object)(hl_urho3d_tvariant * variant,Urho3D::Object *object)
{

    if(variant != NULL)
    {
        *variant = object;
    }
    
}

HL_PRIM void HL_NAME(_t_variant_set_vector_buffer)(hl_urho3d_tvariant * variant,Urho3D::VectorBuffer *vb)
{
    if(variant != NULL)
    {
         *variant = *vb;
    }
}


HL_PRIM Urho3D::VectorBuffer * HL_NAME(_t_variant_get_vector_buffer)(hl_urho3d_tvariant * variant)
{

    if(variant != NULL)
    {
        VectorBuffer v = variant->GetVectorBuffer();
        return hl_alloc_urho3d_io_t_vector_buffer(v);
    }
    else
    {
        return NULL;
    } 
}


HL_PRIM void HL_NAME(_t_variant_set_string)(hl_urho3d_tvariant * variant, vstring *vstr)
{
    const char *str = (char *)hl_to_utf8(vstr->bytes);
    *variant = String(str);
}

HL_PRIM vbyte *HL_NAME(_t_variant_get_string)(hl_urho3d_tvariant * variant)
{
    return HLCreateVBString(variant->GetString());
}


HL_PRIM Urho3D::RefCounted *HL_NAME(_t_variant_get_pointer)(hl_urho3d_tvariant * variant)
{
    return variant->GetPtr();
}

DEFINE_PRIM(URHO3D_REFCOUNTED, _t_variant_get_pointer, HL_URHO3D_TVARIANT);


DEFINE_PRIM(_VOID, _t_variant_set_string, HL_URHO3D_TVARIANT _STRING);
DEFINE_PRIM(_BYTES, _t_variant_get_string, HL_URHO3D_TVARIANT);


DEFINE_PRIM(HL_URHO3D_TVARIANT, _math_tvariant_cast_from_variant, HL_URHO3D_VARIANT);
DEFINE_PRIM(HL_URHO3D_VARIANT, _math_tvariant_cast_to_variant, HL_URHO3D_TVARIANT);

DEFINE_PRIM(HL_URHO3D_TVARIANT, _create_tvariant, _NO_ARG);

DEFINE_PRIM(_VOID, _tvariant_set_bool, HL_URHO3D_TVARIANT _BOOL);
DEFINE_PRIM(_BOOL, _tvariant_get_bool, HL_URHO3D_TVARIANT);
DEFINE_PRIM(_VOID, _tvariant_set_int, HL_URHO3D_TVARIANT _I32);
DEFINE_PRIM(_I32, _tvariant_get_int, HL_URHO3D_TVARIANT);
DEFINE_PRIM(_VOID, _tvariant_set_float, HL_URHO3D_TVARIANT _F32);
DEFINE_PRIM(_F32, _tvariant_get_float, HL_URHO3D_TVARIANT);
DEFINE_PRIM(_VOID, _tvariant_set_vector2, HL_URHO3D_TVARIANT HL_URHO3D_VECTOR2);
DEFINE_PRIM(_VOID, _tvariant_set_t_color, HL_URHO3D_TVARIANT HL_URHO3D_TCOLOR);
DEFINE_PRIM(HL_URHO3D_TCOLOR, _tvariant_get_t_color, HL_URHO3D_TVARIANT );
DEFINE_PRIM(HL_URHO3D_VECTOR2, _tvariant_get_vector2, HL_URHO3D_TVARIANT);
DEFINE_PRIM(_VOID, _tvariant_set_tvector2, HL_URHO3D_TVARIANT HL_URHO3D_TVECTOR2);
DEFINE_PRIM(HL_URHO3D_TVECTOR2, _tvariant_get_tvector2, HL_URHO3D_TVARIANT);
DEFINE_PRIM(_VOID, _tvariant_set_tintvector2, HL_URHO3D_TVARIANT HL_URHO3D_TINTVECTOR2);
DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _tvariant_get_tintvector2, HL_URHO3D_TVARIANT);

DEFINE_PRIM(_VOID, _tvariant_set_object, HL_URHO3D_TVARIANT HL_URHO3D_OBJECT);
DEFINE_PRIM(HL_URHO3D_OBJECT, _tvariant_get_object, HL_URHO3D_TVARIANT);

DEFINE_PRIM(_VOID, _t_variant_set_vector_buffer, HL_URHO3D_TVARIANT HL_URHO3D_T_VECTOR_BUFFER);
DEFINE_PRIM(HL_URHO3D_T_VECTOR_BUFFER, _t_variant_get_vector_buffer, HL_URHO3D_TVARIANT);
