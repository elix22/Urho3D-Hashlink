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

HL_PRIM void HL_NAME(_graphics_bone_set_animated)(urho3d_context *context, Urho3D::Bone * bone, bool animated )
{
    bone->animated_ = animated;
}

HL_PRIM bool HL_NAME(_graphics_bone_get_animated)(urho3d_context *context, Urho3D::Bone * bone )
{
   return bone->animated_;
}

DEFINE_PRIM(_VOID, _graphics_bone_set_animated, URHO3D_CONTEXT HL_URHO3D_BONE _BOOL);
DEFINE_PRIM(_BOOL, _graphics_bone_get_animated, URHO3D_CONTEXT HL_URHO3D_BONE );