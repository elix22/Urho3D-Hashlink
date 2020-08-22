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

static Urho3D::Ray math_t_ray_stack[T_URHO3D_T_RAY_STACK_SIZE] = {Urho3D::Ray()};
static int index_math_t_ray_stack = 0;

Urho3D::Ray *hl_alloc_urho3d_math_t_ray(const Vector3 &origin, const Vector3 &direction)
{
    Urho3D::Ray *v = &(math_t_ray_stack[(++index_math_t_ray_stack) % T_URHO3D_T_RAY_STACK_SIZE]);
    v->Define(origin, direction);
    return v;
}

Urho3D::Ray *hl_alloc_urho3d_math_t_ray(const Ray &ray)
{
    Urho3D::Ray *v = &(math_t_ray_stack[(++index_math_t_ray_stack) % T_URHO3D_T_RAY_STACK_SIZE]);
    *v = ray;
    return v;
}

HL_PRIM Urho3D::Ray *HL_NAME(_math_t_ray_create)(Urho3D::Vector3 *origin, Urho3D::Vector3 *direction)
{
    return hl_alloc_urho3d_math_t_ray(*origin, *direction);
}


HL_PRIM hl_urho3d_math_ray *HL_NAME(_math_t_ray_cast_to_ray)(Urho3D::Ray *v)
{

    if (v != NULL)
    {
        return hl_alloc_urho3d_math_ray(*v);
    }
    else
    {
        return NULL;
    }
}


HL_PRIM Urho3D::Ray *HL_NAME(_math_t_ray_cast_from_ray)(hl_urho3d_math_ray *v)
{
    return hl_alloc_urho3d_math_t_ray(*(v->ptr));
}

DEFINE_PRIM(HL_URHO3D_T_RAY, _math_t_ray_create, HL_URHO3D_TVECTOR3 HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_RAY, _math_t_ray_cast_to_ray, HL_URHO3D_T_RAY );
DEFINE_PRIM(HL_URHO3D_T_RAY , _math_t_ray_cast_from_ray,HL_URHO3D_RAY );