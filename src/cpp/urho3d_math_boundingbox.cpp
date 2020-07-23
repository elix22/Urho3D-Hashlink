#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

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

    return p;
}


hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(const Urho3D::Vector3 &a, const Urho3D::Vector3 &b)
{
    hl_urho3d_math_boundingbox *p = (hl_urho3d_math_boundingbox *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_boundingbox));

    p->finalizer = (void *)finalize_urho3d_math_boundingbox;
    p->ptr = new Urho3D::BoundingBox(a, b);

    return p;
}

hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(float x, float y)
{
    hl_urho3d_math_boundingbox *p = (hl_urho3d_math_boundingbox *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_boundingbox));

    printf("hl_alloc_urho3d_math_boundingbox %f %f \n",x,y);
    p->finalizer = (void *)finalize_urho3d_math_boundingbox;
    p->ptr = new Urho3D::BoundingBox(x, y);

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



DEFINE_PRIM(HL_URHO3D_BOUNDINGBOX, _math_boundingbox_create_ff, _F32 _F32);
DEFINE_PRIM(HL_URHO3D_BOUNDINGBOX, _math_boundingbox_create_v3_v3, HL_URHO3D_VECTOR3 HL_URHO3D_VECTOR3);
