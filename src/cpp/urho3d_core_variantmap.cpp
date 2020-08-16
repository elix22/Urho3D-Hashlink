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

#define Urho3D_Type Urho3D::VariantMap
#define hl_urho3d_type hl_urho3d_variantmap
#define hl_alloc_urho3d hl_alloc_urho3d_variantmap
#define finalize_urho3d finalize_urho3d_variantmap
#define HL_URHO3D_TYPE HL_URHO3D_VARIANTMAP

hl_urho3d_variant *hl_alloc_urho3d_variant();

void finalize_urho3d(void *v)
{
    hl_urho3d_type *hlt = (hl_urho3d_type *)v;
    if (hlt)
    {
        Urho3D_Type *urho3D_Type = (Urho3D_Type *)hlt->ptr;
        if (urho3D_Type)
        {
            delete urho3D_Type;
            hlt->ptr = NULL;
        }
        hlt->finalizer = NULL;
    }
}

hl_urho3d_variantmap *hl_alloc_urho3d_variantmap_no_finlizer()
{
    hl_urho3d_type *p = (hl_urho3d_type *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_type));
    p->finalizer = (void *)0;
    p->ptr = NULL;
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_type *hl_alloc_urho3d()
{
    hl_urho3d_type *p = (hl_urho3d_type *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_type));
    p->finalizer = (void *)finalize_urho3d;
    Urho3D_Type *v = new Urho3D_Type();
    v->Clear();
    p->ptr = v;
    p->dyn_obj = NULL;
    return p;
}

HL_PRIM hl_urho3d_type *HL_NAME(_core_variantmap_create)()
{
    hl_urho3d_type *v = hl_alloc_urho3d();
    return v;
}

HL_PRIM hl_urho3d_tvariant *HL_NAME(_core_variantmap_set_key_value)(hl_urho3d_variantmap *type, hl_urho3d_tstringhash *sh, hl_urho3d_tvariant *variant)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;

    if (vm != NULL && sh != NULL && variant != NULL)
    {
        (*vm)[*sh] = *variant;
    }
    return variant;
}

HL_PRIM hl_urho3d_tvariant *HL_NAME(_core_variantmap_get_value)(hl_urho3d_variantmap *type, hl_urho3d_tstringhash *sh)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;

    hl_urho3d_tvariant *vr = hl_alloc_urho3d_tvariant();

    *vr = (*vm)[*sh];

    return vr;
}


HL_PRIM void HL_NAME(_core_variantmap_set_key_string_value)(hl_urho3d_variantmap *type, vstring *str, hl_urho3d_tvariant *variant)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;
    const char *ch = (char*)hl_to_utf8(str->bytes);

    if (vm != NULL && variant != NULL)
    {
        (*vm)[StringHash(ch)] = *variant;
    }
}

HL_PRIM hl_urho3d_tvariant *HL_NAME(_core_variantmap_get_key_string_value)(hl_urho3d_variantmap *type, vstring *str)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;
    const char *ch = (char*)hl_to_utf8(str->bytes);

    hl_urho3d_tvariant *vr = hl_alloc_urho3d_tvariant();

    *vr = (*vm)[StringHash(ch)];

    return vr;
}

HL_PRIM void HL_NAME(_core_variantmap_set_key_string_float)(hl_urho3d_variantmap *type, vstring *str, float value)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;
    const char *ch = (char*)hl_to_utf8(str->bytes);

    if (vm != NULL)
    {
        (*vm)[StringHash(ch)] = value;
    }
}

HL_PRIM float HL_NAME(_core_variantmap_get_key_string_float)(hl_urho3d_variantmap *type, vstring *str)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;
    const char *ch = (char*)hl_to_utf8(str->bytes);

    return  (*vm)[StringHash(ch)].GetFloat();
}

HL_PRIM void HL_NAME(_core_variantmap_set_key_string_int)(hl_urho3d_variantmap *type, vstring *str, int value)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;
    const char *ch = (char*)hl_to_utf8(str->bytes);

    if (vm != NULL)
    {
        (*vm)[StringHash(ch)] = value;
    }
}

HL_PRIM int HL_NAME(_core_variantmap_get_key_string_int)(hl_urho3d_variantmap *type, vstring *str)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;
    const char *ch = (char*)hl_to_utf8(str->bytes);

    return  (*vm)[StringHash(ch)].GetInt();
}

HL_PRIM void HL_NAME(_core_variantmap_clear)(hl_urho3d_variantmap *m)
{
    m->ptr->Clear();
}

DEFINE_PRIM(HL_URHO3D_TYPE, _core_variantmap_create, _NO_ARG);
DEFINE_PRIM(HL_URHO3D_TVARIANT, _core_variantmap_set_key_value, HL_URHO3D_VARIANTMAP HL_URHO3D_TSTRINGHASH HL_URHO3D_TVARIANT);
DEFINE_PRIM(HL_URHO3D_TVARIANT, _core_variantmap_get_value, HL_URHO3D_VARIANTMAP HL_URHO3D_TSTRINGHASH);

DEFINE_PRIM(_VOID, _core_variantmap_set_key_string_value, HL_URHO3D_VARIANTMAP _STRING HL_URHO3D_TVARIANT);
DEFINE_PRIM(HL_URHO3D_TVARIANT, _core_variantmap_get_key_string_value, HL_URHO3D_VARIANTMAP _STRING);

DEFINE_PRIM(_VOID, _core_variantmap_set_key_string_float, HL_URHO3D_VARIANTMAP _STRING _F32);
DEFINE_PRIM(_F32, _core_variantmap_get_key_string_float, HL_URHO3D_VARIANTMAP _STRING);

DEFINE_PRIM(_VOID, _core_variantmap_set_key_string_int, HL_URHO3D_VARIANTMAP _STRING _I32);
DEFINE_PRIM(_I32, _core_variantmap_get_key_string_int, HL_URHO3D_VARIANTMAP _STRING);

DEFINE_PRIM(_VOID, _core_variantmap_clear, HL_URHO3D_VARIANTMAP);


