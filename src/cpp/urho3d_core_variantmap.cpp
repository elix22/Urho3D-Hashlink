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

hl_urho3d_variant * hl_alloc_urho3d_variant();



void finalize_urho3d(void * v)
{
    hl_urho3d_type  * hlt = (hl_urho3d_type  * )v;
    if(hlt)
    {
         Urho3D_Type *urho3D_Type = (Urho3D_Type *)hlt->ptr;
         if(urho3D_Type)
         {
             delete urho3D_Type;
             hlt->ptr = NULL;
         }
         hlt->finalizer = NULL;
    } 
}



hl_urho3d_variantmap * hl_alloc_urho3d_variantmap_no_finlizer()
{
    hl_urho3d_type  * p= (hl_urho3d_type *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_type));
    p->finalizer = (void*)0;
    return p;
}

hl_urho3d_type * hl_alloc_urho3d()
{
    hl_urho3d_type  * p= (hl_urho3d_type *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_type));
    p->finalizer = (void*)finalize_urho3d;
    Urho3D_Type *v = new Urho3D_Type();
    p->ptr = v;
    return p;
}



HL_PRIM  hl_urho3d_type  * HL_NAME(_create_variantmap)()
{
    hl_urho3d_type * v =  hl_alloc_urho3d();
    return v;
}


HL_PRIM hl_urho3d_variant * HL_NAME(_set_key_value)(hl_urho3d_variantmap * type,hl_urho3d_stringhash  * stringhash, hl_urho3d_variant * variant)
{
    Urho3D::VariantMap *  vm = (Urho3D::VariantMap *)type->ptr;
    Urho3D::StringHash * sh = (Urho3D::StringHash *)stringhash->ptr;
    Urho3D::Variant * vr = (Urho3D::Variant *)variant->ptr;

    if(vm != NULL && sh != NULL && vr != NULL)
    {

        (*vm)[*sh]=*vr;

    }
    return variant;
}




HL_PRIM hl_urho3d_variant * HL_NAME(_get_value)(hl_urho3d_variantmap * type,hl_urho3d_stringhash  * stringhash)
{
    Urho3D::VariantMap *  vm = (Urho3D::VariantMap *)type->ptr;
    Urho3D::StringHash * sh = (Urho3D::StringHash *)stringhash->ptr;

    hl_urho3d_variant * hl_vr = hl_alloc_urho3d_variant();
    if(hl_vr)
    {
        Urho3D::Variant *vr =   (Urho3D::Variant *)hl_vr->ptr;
        if(vr)
        {
            *vr = (*vm)[*sh];
        }
    }
    return hl_vr;
}




DEFINE_PRIM(HL_URHO3D_TYPE, _create_variantmap, _NO_ARG);
DEFINE_PRIM(HL_URHO3D_VARIANT, _set_key_value, HL_URHO3D_VARIANTMAP HL_URHO3D_STRINGHASH HL_URHO3D_VARIANT);
DEFINE_PRIM(HL_URHO3D_VARIANT, _get_value, HL_URHO3D_VARIANTMAP HL_URHO3D_STRINGHASH );