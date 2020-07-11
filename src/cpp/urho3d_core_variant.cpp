#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

#define Urho3D_Type Urho3D::Variant
#define hl_urho3d_type hl_urho3d_variant
#define hl_alloc_urho3d hl_alloc_urho3d_variant
#define finalize_urho3d finalize_urho3d_variant
#define HL_URHO3D_TYPE HL_URHO3D_VARIANT

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


hl_urho3d_type * hl_alloc_urho3d()
{
    hl_urho3d_type  * p= (hl_urho3d_type *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_type));
    p->finalizer = (void*)finalize_urho3d;
    Urho3D_Type *v = new Urho3D_Type();
    p->ptr = v;
    return p;
}




HL_PRIM  hl_urho3d_type  * HL_NAME(_create_variant)()
{
    hl_urho3d_type * v =  hl_alloc_urho3d();
    return v;
}



HL_PRIM void HL_NAME(_variant_set_int)(hl_urho3d_variant * hl_var , int i)
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;

    if(variant != NULL) 
    {
        *variant = i;

       // printf("variant set  int:%d\n",variant->GetInt());
    }
}

HL_PRIM int HL_NAME(_variant_get_int)(hl_urho3d_variant * hl_var)
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;

    if(variant != NULL) 
    {
        return variant->GetInt();
    }
}

HL_PRIM void HL_NAME(_variant_set_float)(hl_urho3d_variant * hl_var , float val)
{
    Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;

    if(variant != NULL) 
    {
        *variant = val;

       // printf("variant set  float :%f\n",variant->GetFloat());
    }
}

HL_PRIM float HL_NAME(_variant_get_float)(hl_urho3d_variant * hl_var)
{
    Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;

    if(variant != NULL) 
    {
        // printf("variant get  float :%f\n",variant->GetFloat());
        return variant->GetFloat();
    }
}


HL_PRIM void HL_NAME(_variant_set_vector2)(hl_urho3d_variant * hl_var , hl_urho3d_vector2 * hl_vec)
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;
     Urho3D::Vector2 *  vector2 = (Urho3D::Vector2 *)hl_vec->ptr;

    if(variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
        // printf("variant set  vector:%f:%f\n",variant->GetVector2().x_,variant->GetVector2().y_);
    }
}

HL_PRIM void HL_NAME(_variant_get_vector2)(hl_urho3d_variant * hl_var , hl_urho3d_vector2 * hl_vec)
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;
     Urho3D::Vector2 *  vector2 = (Urho3D::Vector2 *)hl_vec->ptr;

    if(variant != NULL && vector2 != NULL)
    {
        *vector2 = variant->GetVector2();
    }
}


DEFINE_PRIM(HL_URHO3D_TYPE, _create_variant, _NO_ARG);
DEFINE_PRIM(_VOID, _variant_set_int, HL_URHO3D_VARIANT _I32);
DEFINE_PRIM(_I32, _variant_get_int, HL_URHO3D_VARIANT );
DEFINE_PRIM(_VOID, _variant_set_float, HL_URHO3D_VARIANT _F32);
DEFINE_PRIM(_F32, _variant_get_float, HL_URHO3D_VARIANT );
DEFINE_PRIM(_VOID, _variant_set_vector2, HL_URHO3D_VARIANT HL_URHO3D_VECTOR2);
DEFINE_PRIM(_VOID, _variant_get_vector2, HL_URHO3D_VARIANT HL_URHO3D_VECTOR2);
