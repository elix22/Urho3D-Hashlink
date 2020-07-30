#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


void finalize_urho3d_variant(void * v)
{
    hl_urho3d_variant  * hlt = (hl_urho3d_variant  * )v;
    if(hlt)
    {
         Urho3D::Variant *urho3D_Type = (Urho3D::Variant *)hlt->ptr;
         if(urho3D_Type)
         {
             delete urho3D_Type;
             hlt->ptr = NULL;
         }
         hlt->finalizer = NULL;
    } 
}


hl_urho3d_variant * hl_alloc_urho3d_variant()
{
    hl_urho3d_variant  * p= (hl_urho3d_variant *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_variant));
    p->finalizer = (void*)finalize_urho3d_variant;
    Urho3D::Variant *v = new Urho3D::Variant();
    p->ptr = v;
    return p;
}

hl_urho3d_variant * hl_alloc_urho3d_variant(Variant & rhs)
{
    hl_urho3d_variant  * p= (hl_urho3d_variant *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_variant));
    p->finalizer = (void*)finalize_urho3d_variant;
    Urho3D::Variant *v = new Urho3D::Variant(rhs);
    p->ptr = v;
    return p;
}




HL_PRIM  hl_urho3d_variant  * HL_NAME(_create_variant)()
{
    hl_urho3d_variant * v =  hl_alloc_urho3d_variant();
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

    return 0;
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

    return 0.0;
}


HL_PRIM void HL_NAME(_variant_set_vector2)(hl_urho3d_variant * hl_var , hl_urho3d_math_vector2 * hl_vec)
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;
     Urho3D::Vector2 *  vector2 = (Urho3D::Vector2 *)hl_vec->ptr;

    if(variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
        // printf("variant set  vector:%f:%f\n",variant->GetVector2().x_,variant->GetVector2().y_);
    }
}

HL_PRIM  hl_urho3d_math_vector2 * HL_NAME(_variant_get_vector2)(hl_urho3d_variant * hl_var )
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;

    if(variant != NULL )
    {
        return hl_alloc_urho3d_math_vector2(variant->GetVector2());
    }
    else
    {
        return NULL;
    }
    
}


HL_PRIM void HL_NAME(_variant_set_tvector2)(hl_urho3d_variant * hl_var , Urho3D::Vector2 *  vector2)
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;

    if(variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
    }
}

HL_PRIM Urho3D::Vector2 * HL_NAME(_variant_get_tvector2)(hl_urho3d_variant * hl_var , Urho3D::Vector2 *  vector2)
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;

    if(variant != NULL && vector2 != NULL)
    {
         return hl_alloc_urho3d_math_tvector2(variant->GetVector2());
    }
    else
    {
       return NULL;
    }
    
}


HL_PRIM void HL_NAME(_variant_set_tintvector2)(hl_urho3d_variant * hl_var , Urho3D::IntVector2 *  vector2)
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;

    if(variant != NULL && vector2 != NULL)
    {
        *variant = *vector2;
    }
}

HL_PRIM Urho3D::IntVector2 * HL_NAME(_variant_get_tintvector2)(hl_urho3d_variant * hl_var)
{
     Urho3D::Variant *  variant = (Urho3D::Variant *)hl_var->ptr;

    if(variant != NULL)
    {
        return hl_alloc_urho3d_math_tintvector2(variant->GetIntVector2());
    }
    else
    {
        return NULL;
    }
    
}


DEFINE_PRIM(HL_URHO3D_VARIANT, _create_variant, _NO_ARG);
DEFINE_PRIM(_VOID, _variant_set_int, HL_URHO3D_VARIANT _I32);
DEFINE_PRIM(_I32, _variant_get_int, HL_URHO3D_VARIANT );
DEFINE_PRIM(_VOID, _variant_set_float, HL_URHO3D_VARIANT _F32);
DEFINE_PRIM(_F32, _variant_get_float, HL_URHO3D_VARIANT );
DEFINE_PRIM(_VOID, _variant_set_vector2, HL_URHO3D_VARIANT HL_URHO3D_VECTOR2);
DEFINE_PRIM(HL_URHO3D_VECTOR2, _variant_get_vector2, HL_URHO3D_VARIANT );
DEFINE_PRIM(_VOID, _variant_set_tvector2, HL_URHO3D_VARIANT HL_URHO3D_TVECTOR2);
DEFINE_PRIM(HL_URHO3D_TVECTOR2, _variant_get_tvector2, HL_URHO3D_VARIANT );
DEFINE_PRIM(_VOID, _variant_set_tintvector2, HL_URHO3D_VARIANT HL_URHO3D_TINTVECTOR2);
DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _variant_get_tintvector2, HL_URHO3D_VARIANT );
