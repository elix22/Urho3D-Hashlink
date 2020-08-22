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


/*

typedef Urho3D::Bone *  hl_urho3d_graphics_bone;
#define HL_URHO3D_BONE _ABSTRACT(hl_urho3d_graphics_bone)

typedef Urho3D::Skeleton *  hl_urho3d_graphics_skeleton;
#define HL_URHO3D_SKELETON _ABSTRACT(hl_urho3d_graphics_skeleton)
*/

HL_PRIM Urho3D::Bone * HL_NAME(_graphics_skeleton_get_bone)(urho3d_context *context, Urho3D::Skeleton * skeleton , vstring * vname )
{
    const char *name = (char*)hl_to_utf8(vname->bytes);
    return skeleton->GetBone(name);
}

DEFINE_PRIM(HL_URHO3D_BONE, _graphics_skeleton_get_bone, URHO3D_CONTEXT HL_URHO3D_SKELETON _STRING);