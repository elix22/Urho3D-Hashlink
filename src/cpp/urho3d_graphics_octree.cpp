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

static PODVector<RayQueryResult> OctreeRayQueryResults;

HL_PRIM hl_urho3d_graphics_ray_query_results * HL_NAME(_graphics_octree_raycast_single)(urho3d_context *context,Urho3D::Octree  * octree,Urho3D::Ray *ray, int rayQueryLevel,float maxDistance,int drawableFlags, int viewMask)
{
    OctreeRayQueryResults.Clear();
    RayOctreeQuery query(OctreeRayQueryResults, *(ray), RayQueryLevel(rayQueryLevel), maxDistance, drawableFlags,viewMask);
    octree->RaycastSingle(query);
    return &(OctreeRayQueryResults);
}

DEFINE_PRIM(HL_URHO3D_RAY_QUERY_RESULTS, _graphics_octree_raycast_single, URHO3D_CONTEXT HL_URHO3D_OCTREE HL_URHO3D_T_RAY _I32 _F32 _I32 _I32);
