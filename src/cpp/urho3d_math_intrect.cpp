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

void finalize_urho3d_math_intrect(void *v)
{
    hl_urho3d_math_intrect *uptr = (hl_urho3d_math_intrect *)v;
    if (uptr)
    {
        if (uptr->ptr)
        {
            delete uptr->ptr;
            uptr->ptr = NULL;
        }
        uptr->finalizer = NULL;
    }
}


hl_urho3d_math_intrect *hl_alloc_urho3d_math_intrect(int left, int top, int right, int bottom)
{
    hl_urho3d_math_intrect *p = (hl_urho3d_math_intrect *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_intrect));

    p->finalizer = (void *)finalize_urho3d_math_intrect;
    p->ptr = new Urho3D::IntRect(left,top,right,bottom);

    return p;
}


HL_PRIM hl_urho3d_math_intrect *HL_NAME(_math_intrect_create)(int left, int top, int right, int bottom)
{
    return hl_alloc_urho3d_math_intrect(left,top,right,bottom);
}

DEFINE_PRIM(HL_URHO3D_INTRECT, _math_intrect_create, _I32 _I32 _I32 _I32);