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

void finalize_urho3d_math_boundingbox(void *v)
{
    hl_urho3d_math_boundingbox *v_ptr = (hl_urho3d_math_boundingbox *)v;
    if (v_ptr)
    {
        if (v_ptr->ptr)
        {
            delete v_ptr->ptr;
            v_ptr->ptr = NULL;
        }
        v_ptr->finalizer = NULL;
    }
}

hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(const Urho3D::BoundingBox & box)
{
    hl_urho3d_math_boundingbox *p = (hl_urho3d_math_boundingbox *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_boundingbox));

    p->finalizer = (void *)finalize_urho3d_math_boundingbox;
    p->ptr = new Urho3D::BoundingBox(box);
    p->dyn_obj = NULL;
    return p;
}


hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(const Urho3D::Vector3 &a, const Urho3D::Vector3 &b)
{
    hl_urho3d_math_boundingbox *p = (hl_urho3d_math_boundingbox *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_boundingbox));

    p->finalizer = (void *)finalize_urho3d_math_boundingbox;
    p->ptr = new Urho3D::BoundingBox(a, b);
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(float x, float y)
{
    hl_urho3d_math_boundingbox *p = (hl_urho3d_math_boundingbox *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_boundingbox));

    printf("hl_alloc_urho3d_math_boundingbox %f %f \n",x,y);
    p->finalizer = (void *)finalize_urho3d_math_boundingbox;
    p->ptr = new Urho3D::BoundingBox(x, y);
    p->dyn_obj = NULL;
    return p;
}

HL_PRIM hl_urho3d_math_boundingbox *HL_NAME(_math_boundingbox_create_ff)(float x, float y)
{
    hl_urho3d_math_boundingbox *v = hl_alloc_urho3d_math_boundingbox(x, y);
    return v;
}

HL_PRIM hl_urho3d_math_boundingbox *HL_NAME(_math_boundingbox_create_v3_v3)(hl_urho3d_math_vector3 *a, hl_urho3d_math_vector3 *b)
{
    if (a && a->ptr && b && b->ptr)
    {
        hl_urho3d_math_boundingbox *v = hl_alloc_urho3d_math_boundingbox(*(a->ptr), *(b->ptr));
        return v;
    }

    return NULL;
}

HL_PRIM void HL_NAME(_math_boundingbox_set_min)(hl_urho3d_math_boundingbox *this_inst, hl_urho3d_math_tvector3 * vector )
{
    this_inst->ptr->min_ = *vector;
}

HL_PRIM hl_urho3d_math_tvector3 * HL_NAME(_math_boundingbox_get_min)( hl_urho3d_math_boundingbox *this_inst )
{
    Vector3 * vec = hl_alloc_urho3d_math_tvector3(this_inst->ptr->min_);
    return vec;
}

HL_PRIM void HL_NAME(_math_boundingbox_set_max)( hl_urho3d_math_boundingbox *this_inst, hl_urho3d_math_tvector3 * vector )
{
    this_inst->ptr->min_ = *vector;
}

HL_PRIM hl_urho3d_math_tvector3 * HL_NAME(_math_boundingbox_get_max)( hl_urho3d_math_boundingbox *this_inst )
{
    return hl_alloc_urho3d_math_tvector3(this_inst->ptr->max_);
}



DEFINE_PRIM(HL_URHO3D_BOUNDINGBOX, _math_boundingbox_create_ff, _F32 _F32);
DEFINE_PRIM(HL_URHO3D_BOUNDINGBOX, _math_boundingbox_create_v3_v3, HL_URHO3D_VECTOR3 HL_URHO3D_VECTOR3);

DEFINE_PRIM(_VOID, _math_boundingbox_set_min, HL_URHO3D_BOUNDINGBOX HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _math_boundingbox_get_min, HL_URHO3D_BOUNDINGBOX );

DEFINE_PRIM(_VOID, _math_boundingbox_set_max, HL_URHO3D_BOUNDINGBOX HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _math_boundingbox_get_max, HL_URHO3D_BOUNDINGBOX );
