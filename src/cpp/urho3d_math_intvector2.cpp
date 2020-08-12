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


void finalize_urho3d_intvector2(void * v)
{
    hl_urho3d_intvector2  * v2ptr = (hl_urho3d_intvector2  * )v;
    if(v2ptr)
    {
         Urho3D::IntVector2 *vector2 = (Urho3D::IntVector2 *)v2ptr->ptr;
         if(vector2)
         {
           //  printf("finalize_urho3d_vector2 %f:%f \n",vector2->x_,vector2->y_);
             delete vector2;
             v2ptr->ptr = NULL;
             
         }
         v2ptr->finalizer = NULL;
    }
    
}

hl_urho3d_intvector2 * hl_alloc_urho3d_intvector2(int x, int y)
{
    hl_urho3d_intvector2  * p= (hl_urho3d_intvector2 *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_intvector2));

    p->finalizer = (void*)finalize_urho3d_intvector2;
    Urho3D::IntVector2 *v = new Urho3D::IntVector2(x,y);
    p->ptr = v;

    return p;
}



HL_PRIM  hl_urho3d_intvector2  * HL_NAME(_create_intvector2)(int x, int y)
{
    hl_urho3d_intvector2 * v =  hl_alloc_urho3d_intvector2(x,y);
    return v;
}

HL_PRIM int HL_NAME(_intvector2_set_x)(hl_urho3d_intvector2 * hv, int x)
{
    Urho3D::IntVector2 *  v = (Urho3D::IntVector2 *)hv->ptr;

    if(v != NULL)
    {
        v->x_ = x;
        return v->x_;
    }
    else
        return 0.0f;
}

HL_PRIM int HL_NAME(_intvector2_get_x)(hl_urho3d_intvector2 * hv)
{
    Urho3D::IntVector2 *  v = (Urho3D::IntVector2 *)hv->ptr;

    if(v != NULL)
    {
        return v->x_;
    }
    else
    {
        return 0.0f;
    }
}

HL_PRIM int HL_NAME(_intvector2_set_y)(hl_urho3d_intvector2 * hv, int y)
{
     Urho3D::IntVector2 *  v = (Urho3D::IntVector2 *)hv->ptr;
    if(v != NULL)
    {
        v->y_ = y;
        return v->y_;
    }
    else
        return 0.0f;
}

HL_PRIM int HL_NAME(_intvector2_get_y)(hl_urho3d_intvector2 * hv)
{
     Urho3D::IntVector2 *  v = (Urho3D::IntVector2 *)hv->ptr;
    if(v != NULL)
    {
        return v->y_;
    }
    else
    {
        return 0.0f;
    }
}


DEFINE_PRIM(HL_URHO3D_INTVECTOR2, _create_intvector2, _I32 _I32);
DEFINE_PRIM(_I32, _intvector2_set_x,HL_URHO3D_INTVECTOR2 _I32);
DEFINE_PRIM(_I32, _intvector2_get_x,HL_URHO3D_INTVECTOR2);
DEFINE_PRIM(_I32, _intvector2_set_y,HL_URHO3D_INTVECTOR2 _I32);
DEFINE_PRIM(_I32, _intvector2_get_y,HL_URHO3D_INTVECTOR2);
