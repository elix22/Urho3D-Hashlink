#define HL_NAME(n) Urho3D_##n
extern "C"
{
#if defined(URHO3D_HAXE_HASHLINK)
#include <hashlink/hl.h>
#else
#include <hl.h>
#endif
}

#include "global_types.h"


HL_PRIM int HL_NAME(_graphics_ray_query_results_get_size)(hl_urho3d_graphics_ray_query_results * query)
{
    if(query)
    {
        return query->Size();
    }
    else
    {
        return 0;
    }
    
}

HL_PRIM hl_urho3d_graphics_ray_query_result * HL_NAME(_graphics_ray_query_results_get_result)(hl_urho3d_graphics_ray_query_results * query , int index)
{
    if(query && index < query->Size())
    {
        return &((*query)[index]);
    }
    else
    {
        return NULL;
    }
    
}

DEFINE_PRIM(_I32, _graphics_ray_query_results_get_size, HL_URHO3D_RAY_QUERY_RESULTS);
DEFINE_PRIM(HL_URHO3D_RAY_QUERY_RESULT, _graphics_ray_query_results_get_result, HL_URHO3D_RAY_QUERY_RESULTS _I32);