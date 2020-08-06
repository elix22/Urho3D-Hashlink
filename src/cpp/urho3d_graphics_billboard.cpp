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

/*
typedef Urho3D::Billboard hl_urho3d_graphics_billboard;
#define URHO3D_BILLBOARD _ABSTRACT(hl_urho3d_graphics_billboard)

typedef PODVector<Billboard> hl_urho3d_graphics_pod_billboard;
#define URHO3D_POD_BILLBOARD _ABSTRACT(hl_urho3d_graphics_pod_billboard)

    /// Position.
    Vector3 position_;
    /// Two-dimensional size. If BillboardSet has fixed screen size enabled, this is measured in pixels instead of world units.
    Vector2 size_;
    /// UV coordinates.
    Rect uv_;
    /// Color.
    Color color_;
    /// Rotation.
    float rotation_;
    /// Direction (For direction based billboard only).
    Vector3 direction_;
    /// Enabled flag.
    bool enabled_;
    /// Sort distance. Used internally.
    float sortDistance_;
    /// Scale factor for fixed screen size mode. Used internally.
    float screenScaleFactor_;
*/


HL_PRIM void HL_NAME(_graphics_billboard_set_position)(urho3d_context *context, Urho3D::Billboard  * b, Urho3D::Vector3 * position )
{
    b->position_ = *position;
}

HL_PRIM Urho3D::Vector3 *  HL_NAME(_graphics_billboard_get_position)(urho3d_context *context, Urho3D::Billboard  * b )
{
    return &(b->position_);
}

HL_PRIM void HL_NAME(_graphics_billboard_set_size)(urho3d_context *context, Urho3D::Billboard  * b, Urho3D::Vector2 * v )
{
    b->size_ = *v;
}

HL_PRIM Urho3D::Vector2 *  HL_NAME(_graphics_billboard_get_size)(urho3d_context *context, Urho3D::Billboard  * b )
{
    return &(b->size_);
}


HL_PRIM void HL_NAME(_graphics_billboard_set_rotation)(urho3d_context *context, Urho3D::Billboard  * b, float r )
{
    b->rotation_ = r;
}

HL_PRIM float HL_NAME(_graphics_billboard_get_rotation)(urho3d_context *context, Urho3D::Billboard  * b )
{
    return b->rotation_;
}

HL_PRIM void HL_NAME(_graphics_billboard_set_enabled)(urho3d_context *context, Urho3D::Billboard  * b, bool r )
{
    b->enabled_ = r;
}

HL_PRIM bool  HL_NAME(_graphics_billboard_get_enabled)(urho3d_context *context, Urho3D::Billboard  * b )
{
    return b->enabled_;
}

DEFINE_PRIM(_VOID, _graphics_billboard_set_position, URHO3D_CONTEXT HL_URHO3D_BILLBOARD HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _graphics_billboard_get_position, URHO3D_CONTEXT HL_URHO3D_BILLBOARD );

DEFINE_PRIM(_VOID, _graphics_billboard_set_size, URHO3D_CONTEXT HL_URHO3D_BILLBOARD HL_URHO3D_TVECTOR2);
DEFINE_PRIM(HL_URHO3D_TVECTOR2, _graphics_billboard_get_size, URHO3D_CONTEXT HL_URHO3D_BILLBOARD );

DEFINE_PRIM(_VOID, _graphics_billboard_set_rotation, URHO3D_CONTEXT HL_URHO3D_BILLBOARD _F32);
DEFINE_PRIM(_F32, _graphics_billboard_get_rotation, URHO3D_CONTEXT HL_URHO3D_BILLBOARD );

DEFINE_PRIM(_VOID, _graphics_billboard_set_enabled, URHO3D_CONTEXT HL_URHO3D_BILLBOARD _BOOL);
DEFINE_PRIM(_BOOL, _graphics_billboard_get_enabled, URHO3D_CONTEXT HL_URHO3D_BILLBOARD );
