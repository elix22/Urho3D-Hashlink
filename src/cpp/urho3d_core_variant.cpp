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

void finalize_urho3d_variant(void *v)
{
    hl_urho3d_variant *hlt = (hl_urho3d_variant *)v;
    if (hlt)
    {
        Urho3D::Variant *urho3D_Type = (Urho3D::Variant *)hlt->ptr;
        if (urho3D_Type)
        {
            delete urho3D_Type;
            hlt->ptr = NULL;
        }
        hlt->finalizer = NULL;
    }
}

hl_urho3d_variant *hl_alloc_urho3d_variant()
{
    hl_urho3d_variant *p = (hl_urho3d_variant *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_variant));
    p->finalizer = (void *)finalize_urho3d_variant;
    Urho3D::Variant *v = new Urho3D::Variant();
    p->ptr = v;
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_variant *hl_alloc_urho3d_variant(const Variant &rhs)
{
    hl_urho3d_variant *p = (hl_urho3d_variant *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_variant));
    p->finalizer = (void *)finalize_urho3d_variant;
    Urho3D::Variant *v = new Urho3D::Variant(rhs);
    p->ptr = v;
    p->dyn_obj = NULL;
    return p;
}

HL_PRIM hl_urho3d_variant *HL_NAME(_create_variant)()
{
    hl_urho3d_variant *v = hl_alloc_urho3d_variant();
    return v;
}

HL_PRIM void HL_NAME(_variant_set_bool)(hl_urho3d_variant *hl_var, bool i)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        *variant = i;
    }
}

HL_PRIM bool HL_NAME(_variant_get_bool)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        return variant->GetBool();
    }

    return false;
}

HL_PRIM void HL_NAME(_variant_set_int)(hl_urho3d_variant *hl_var, int i)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        *variant = i;
    }
}

HL_PRIM int HL_NAME(_variant_get_int)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        return variant->GetInt();
    }

    return 0;
}

HL_PRIM void HL_NAME(_variant_set_float)(hl_urho3d_variant *hl_var, float val)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        *variant = val;

        // printf("variant set  float :%f\n",variant->GetFloat());
    }
}

HL_PRIM float HL_NAME(_variant_get_float)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        // printf("variant get  float :%f\n",variant->GetFloat());
        return variant->GetFloat();
    }

    return 0.0;
}

HL_PRIM void HL_NAME(_variant_set_vector2)(hl_urho3d_variant *hl_var, hl_urho3d_math_vector2 *hl_vec)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;
    Urho3D::Vector2 *vector2 = (Urho3D::Vector2 *)hl_vec->ptr;

    if (variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
        // printf("variant set  vector:%f:%f\n",variant->GetVector2().x_,variant->GetVector2().y_);
    }
}

HL_PRIM hl_urho3d_math_vector2 *HL_NAME(_variant_get_vector2)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        return hl_alloc_urho3d_math_vector2(variant->GetVector2());
    }
    else
    {
        return NULL;
    }
}

HL_PRIM void HL_NAME(_variant_set_tvector2)(hl_urho3d_variant *hl_var, Urho3D::Vector2 *vector2)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
    }
}

HL_PRIM Urho3D::Vector2 *HL_NAME(_variant_get_tvector2)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        return hl_alloc_urho3d_math_tvector2(variant->GetVector2());
    }
    else
    {
        return NULL;
    }
}

HL_PRIM void HL_NAME(_variant_set_tintvector2)(hl_urho3d_variant *hl_var, Urho3D::IntVector2 *vector2)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
    }
}

HL_PRIM Urho3D::IntVector2 *HL_NAME(_variant_get_tintvector2)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        return hl_alloc_urho3d_math_tintvector2(variant->GetIntVector2());
    }
    else
    {
        return NULL;
    }
}

HL_PRIM Urho3D::Object *HL_NAME(_variant_get_object)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        return (Urho3D::Object *)variant->GetPtr();
    }
    else
    {
        return NULL;
    }
}

HL_PRIM void HL_NAME(_variant_set_object)(hl_urho3d_variant *hl_var, Urho3D::Object *object)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        *variant = object;
    }
}

HL_PRIM void HL_NAME(_variant_set_vector_buffer)(hl_urho3d_variant *hl_var, Urho3D::VectorBuffer *vb)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        *variant = *vb;
    }
}

HL_PRIM Urho3D::VectorBuffer *HL_NAME(_variant_get_vector_buffer)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;

    if (variant != NULL)
    {
        VectorBuffer v = variant->GetVectorBuffer();
        return hl_alloc_urho3d_io_t_vector_buffer(v);
    }
    else
    {
        return NULL;
    }
}

HL_PRIM void HL_NAME(_variant_set_string)(hl_urho3d_variant *hl_var, vstring *vstr)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;
    const char *str = (char *)hl_to_utf8(vstr->bytes);
    *variant = String(str);
}

HL_PRIM vbyte *HL_NAME(_variant_get_string)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;
    return HLCreateVBString(variant->GetString());
}


HL_PRIM Urho3D::RefCounted *HL_NAME(_variant_get_pointer)(hl_urho3d_variant *hl_var)
{
    Urho3D::Variant *variant = (Urho3D::Variant *)hl_var->ptr;
    return variant->GetPtr();
}

DEFINE_PRIM(URHO3D_REFCOUNTED, _variant_get_pointer, HL_URHO3D_VARIANT);


DEFINE_PRIM(_VOID, _variant_set_string, HL_URHO3D_VARIANT _STRING);
DEFINE_PRIM(_BYTES, _variant_get_string, HL_URHO3D_VARIANT);

DEFINE_PRIM(HL_URHO3D_VARIANT, _create_variant, _NO_ARG);
DEFINE_PRIM(_VOID, _variant_set_bool, HL_URHO3D_VARIANT _BOOL);
DEFINE_PRIM(_BOOL, _variant_get_bool, HL_URHO3D_VARIANT);
DEFINE_PRIM(_VOID, _variant_set_int, HL_URHO3D_VARIANT _I32);
DEFINE_PRIM(_I32, _variant_get_int, HL_URHO3D_VARIANT);
DEFINE_PRIM(_VOID, _variant_set_float, HL_URHO3D_VARIANT _F32);
DEFINE_PRIM(_F32, _variant_get_float, HL_URHO3D_VARIANT);
DEFINE_PRIM(_VOID, _variant_set_vector2, HL_URHO3D_VARIANT HL_URHO3D_VECTOR2);
DEFINE_PRIM(HL_URHO3D_VECTOR2, _variant_get_vector2, HL_URHO3D_VARIANT);
DEFINE_PRIM(_VOID, _variant_set_tvector2, HL_URHO3D_VARIANT HL_URHO3D_TVECTOR2);
DEFINE_PRIM(HL_URHO3D_TVECTOR2, _variant_get_tvector2, HL_URHO3D_VARIANT);
DEFINE_PRIM(_VOID, _variant_set_tintvector2, HL_URHO3D_VARIANT HL_URHO3D_TINTVECTOR2);
DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _variant_get_tintvector2, HL_URHO3D_VARIANT);

DEFINE_PRIM(_VOID, _variant_set_object, HL_URHO3D_VARIANT HL_URHO3D_OBJECT);
DEFINE_PRIM(HL_URHO3D_OBJECT, _variant_get_object, HL_URHO3D_VARIANT);

DEFINE_PRIM(_VOID, _variant_set_vector_buffer, HL_URHO3D_VARIANT HL_URHO3D_T_VECTOR_BUFFER);
DEFINE_PRIM(HL_URHO3D_T_VECTOR_BUFFER, _variant_get_vector_buffer, HL_URHO3D_VARIANT);
