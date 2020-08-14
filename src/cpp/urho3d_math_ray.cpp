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

void finalize_urho3d_math_ray(void *v)
{
    hl_urho3d_math_ray *uptr = (hl_urho3d_math_ray *)v;
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

hl_urho3d_math_ray *hl_alloc_urho3d_math_ray(const Vector3& origin, const Vector3& direction)
{
    hl_urho3d_math_ray *p = (hl_urho3d_math_ray *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_ray));

    p->finalizer = (void *)finalize_urho3d_math_ray;
    p->ptr = new Urho3D::Ray(origin,direction);
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_math_ray *hl_alloc_urho3d_math_ray(const Ray& ray)
{
    hl_urho3d_math_ray *p = (hl_urho3d_math_ray *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_ray));

    p->finalizer = (void *)finalize_urho3d_math_ray;
    p->ptr = new Urho3D::Ray(ray);
    p->dyn_obj = NULL;
    return p;
}


HL_PRIM hl_urho3d_math_ray *HL_NAME(_math_ray_create)(Urho3D::Vector3 *origin , Urho3D::Vector3 *direction)
{
    return hl_alloc_urho3d_math_ray(*origin,*direction);
}

DEFINE_PRIM(HL_URHO3D_RAY, _math_ray_create, HL_URHO3D_TVECTOR3 HL_URHO3D_TVECTOR3);