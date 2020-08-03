#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"



hl_urho3d_variant *hl_alloc_urho3d_variant();

static Urho3D::VariantMap tvariantmap_stack[TVARIANTMAP_STACK_SIZE] = {Urho3D::VariantMap()};
static int index_tvariantmap_stack = 0;

hl_urho3d_tvariantmap *hl_alloc_urho3d_tvariantmap()
{
    Urho3D::VariantMap *v = &(tvariantmap_stack[(++index_tvariantmap_stack) % TVARIANT_STACK_SIZE]);
    v->Clear();
    return v;
}




HL_PRIM hl_urho3d_tvariantmap *HL_NAME(_core_tvariantmap_create)()
{
    return hl_alloc_urho3d_tvariantmap();
}

HL_PRIM hl_urho3d_tvariant *HL_NAME(_core_tvariantmap_set_key_value)(hl_urho3d_tvariantmap *vm, hl_urho3d_tstringhash *sh, hl_urho3d_tvariant *variant)
{
    if (vm != NULL && sh != NULL && variant != NULL)
    {
        (*vm)[*sh] = *variant;
    }
    return variant;
}

HL_PRIM hl_urho3d_tvariant *HL_NAME(_core_tvariantmap_get_value)(hl_urho3d_tvariantmap *vm, hl_urho3d_tstringhash *sh)
{

    hl_urho3d_tvariant *vr = hl_alloc_urho3d_tvariant();

    *vr = (*vm)[*sh];

    return vr;
}

DEFINE_PRIM(HL_URHO3D_TVARIANTMAP, _core_tvariantmap_create, _NO_ARG);
DEFINE_PRIM(HL_URHO3D_TVARIANT, _core_tvariantmap_set_key_value, HL_URHO3D_TVARIANTMAP HL_URHO3D_TSTRINGHASH HL_URHO3D_TVARIANT);
DEFINE_PRIM(HL_URHO3D_TVARIANT, _core_tvariantmap_get_value, HL_URHO3D_TVARIANTMAP HL_URHO3D_TSTRINGHASH);