#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


void finalize_urho3d_vector2(void * v)
{
    hl_urho3d_vector2  * v2ptr = (hl_urho3d_vector2  * )v;
    if(v2ptr)
    {
         Urho3D::Vector2 *vector2 = (Urho3D::Vector2 *)v2ptr->ptr;
         if(vector2)
         {
           //  printf("finalize_urho3d_vector2 %f:%f \n",vector2->x_,vector2->y_);
             delete vector2;
             v2ptr->ptr = NULL;
             
         }
         v2ptr->finalizer = NULL;
    }
    
}


hl_urho3d_vector2 * hl_alloc_urho3d_vector2(const Urho3D::Vector2 & rhs)
{
    hl_urho3d_vector2  * p= (hl_urho3d_vector2 *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_vector2));

    p->finalizer = (void*)finalize_urho3d_vector2;
    Urho3D::Vector2 *v = new Urho3D::Vector2(rhs);
    p->ptr = v;

    return p;

}

hl_urho3d_vector2 * hl_alloc_urho3d_vector2(float x, float y)
{
    hl_urho3d_vector2  * p= (hl_urho3d_vector2 *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_vector2));

    p->finalizer = (void*)finalize_urho3d_vector2;
    Urho3D::Vector2 *v = new Urho3D::Vector2(x,y);
    p->ptr = v;

    return p;
}



HL_PRIM  hl_urho3d_vector2  * HL_NAME(_create_vector2)(float x, float y)
{
    hl_urho3d_vector2 * v =  hl_alloc_urho3d_vector2(x,y);
    return v;
}

HL_PRIM float HL_NAME(_vector2_set_x)(hl_urho3d_vector2 * hv, float x)
{
    Urho3D::Vector2 *  v = (Urho3D::Vector2 *)hv->ptr;

    if(v != NULL)
    {
        v->x_ = x;
        return v->x_;
    }
    else
        return 0.0f;
}

HL_PRIM float HL_NAME(_vector2_get_x)(hl_urho3d_vector2 * hv)
{
    Urho3D::Vector2 *  v = (Urho3D::Vector2 *)hv->ptr;

    if(v != NULL)
    {
        return v->x_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM float HL_NAME(_vector2_set_y)(hl_urho3d_vector2 * hv, float y)
{
     Urho3D::Vector2 *  v = (Urho3D::Vector2 *)hv->ptr;
    if(v != NULL)
    {
        v->y_ = y;
        return v->y_;
    }
    else
        return 0.0f;
}

HL_PRIM float HL_NAME(_vector2_get_y)(hl_urho3d_vector2 * hv)
{
     Urho3D::Vector2 *  v = (Urho3D::Vector2 *)hv->ptr;
    if(v != NULL)
    {
        return v->y_;
    }
    else
    {
        return 0.0f;
    }
}


DEFINE_PRIM(HL_URHO3D_VECTOR2, _create_vector2, _F32 _F32);
DEFINE_PRIM(_F32, _vector2_set_x,HL_URHO3D_VECTOR2 _F32);
DEFINE_PRIM(_F32, _vector2_get_x,HL_URHO3D_VECTOR2);
DEFINE_PRIM(_F32, _vector2_set_y,HL_URHO3D_VECTOR2 _F32);
DEFINE_PRIM(_F32, _vector2_get_y,HL_URHO3D_VECTOR2);
