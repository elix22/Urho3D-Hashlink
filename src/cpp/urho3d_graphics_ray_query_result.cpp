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

HL_PRIM hl_urho3d_math_tvector3 * HL_NAME(_graphics_ray_query_result_get_position)(hl_urho3d_graphics_ray_query_result * result)
{
    return &(result->position_);
}

HL_PRIM hl_urho3d_graphics_drawable *HL_NAME(_graphics_ray_query_result_get_drawable)(hl_urho3d_graphics_ray_query_result * result)
{
    return result->drawable_;
}

DEFINE_PRIM(HL_URHO3D_TVECTOR3, _graphics_ray_query_result_get_position, HL_URHO3D_RAY_QUERY_RESULT);
DEFINE_PRIM(HL_URHO3D_DRAWABLE, _graphics_ray_query_result_get_drawable, HL_URHO3D_RAY_QUERY_RESULT);