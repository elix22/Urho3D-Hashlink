#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

typedef void (* hl_finalizer)(void * v);

#define URHO3D_VECTOR2(v)((Urho3D::Vector2 *)v->ptr)

hl_urho3d_vector2 * hl_alloc_urho3d_vector2(hl_finalizer finalizer)
{
    hl_urho3d_vector2  * p= (hl_urho3d_vector2 *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_vector2));

    p->finalizer = finalizer?(void*)finalizer:0;
    Urho3D::Vector2 *v = new Urho3D::Vector2();
    p->ptr = v;

    return p;
}

void finalize(void * v)
{
    hl_urho3d_vector2  * v2ptr = (hl_urho3d_vector2  * )v;
    if(v2ptr)
    {
         Urho3D::Vector2 *vector2 = (Urho3D::Vector2 *)v2ptr->ptr;
         if(vector2)
         {
             delete vector2;
             v2ptr->ptr = NULL;
         }
         v2ptr->finalizer = NULL;
    }
    
}

HL_PRIM  hl_urho3d_vector2  * HL_NAME(_create_vector2)()
{
    hl_urho3d_vector2 * v =  hl_alloc_urho3d_vector2(finalize);
    return v;
}

HL_PRIM float HL_NAME(_set_x)(hl_urho3d_vector2 * hv, float x)
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

HL_PRIM float HL_NAME(_get_x)(hl_urho3d_vector2 * hv)
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

HL_PRIM float HL_NAME(_set_y)(hl_urho3d_vector2 * hv, float y)
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

HL_PRIM float HL_NAME(_get_y)(hl_urho3d_vector2 * hv)
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


DEFINE_PRIM(HL_URHO3D_VECTOR2, _create_vector2, _NO_ARG);
DEFINE_PRIM(_F32, _set_x,HL_URHO3D_VECTOR2 _F32);
DEFINE_PRIM(_F32, _get_x,HL_URHO3D_VECTOR2);
DEFINE_PRIM(_F32, _set_y,HL_URHO3D_VECTOR2 _F32);
DEFINE_PRIM(_F32, _get_y,HL_URHO3D_VECTOR2);
