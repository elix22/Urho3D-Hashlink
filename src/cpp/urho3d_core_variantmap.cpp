#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

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
    return p;
}

hl_urho3d_type *hl_alloc_urho3d()
{
    hl_urho3d_type *p = (hl_urho3d_type *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_type));
    p->finalizer = (void *)finalize_urho3d;
    Urho3D_Type *v = new Urho3D_Type();
    v->Clear();
    p->ptr = v;
    return p;
}

HL_PRIM hl_urho3d_type *HL_NAME(_create_variantmap)()
{
    hl_urho3d_type *v = hl_alloc_urho3d();
    return v;
}

HL_PRIM hl_urho3d_tvariant *HL_NAME(_set_key_value)(hl_urho3d_variantmap *type, hl_urho3d_tstringhash *sh, hl_urho3d_tvariant *variant)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;

    if (vm != NULL && sh != NULL && variant != NULL)
    {
        (*vm)[*sh] = *variant;
    }
    return variant;
}

HL_PRIM hl_urho3d_tvariant *HL_NAME(_get_value)(hl_urho3d_variantmap *type, hl_urho3d_tstringhash *sh)
{
    Urho3D::VariantMap *vm = (Urho3D::VariantMap *)type->ptr;

    hl_urho3d_tvariant *vr = hl_alloc_urho3d_tvariant();

    *vr = (*vm)[*sh];

    return vr;
}

DEFINE_PRIM(HL_URHO3D_TYPE, _create_variantmap, _NO_ARG);
DEFINE_PRIM(HL_URHO3D_TVARIANT, _set_key_value, HL_URHO3D_VARIANTMAP HL_URHO3D_TSTRINGHASH HL_URHO3D_TVARIANT);
DEFINE_PRIM(HL_URHO3D_TVARIANT, _get_value, HL_URHO3D_VARIANTMAP HL_URHO3D_TSTRINGHASH);