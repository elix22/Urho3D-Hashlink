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
void finalize_urho3d_graphics_drawable(void *v)
{
    hl_urho3d_graphics_drawable *hl_ptr = (hl_urho3d_graphics_drawable *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_graphics_drawable *hl_alloc_urho3d_graphics_drawable(urho3d_context *context, Urho3D::Drawable *drawable)
{

    hl_urho3d_graphics_drawable *p = (hl_urho3d_graphics_drawable *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_drawable));
    memset(p, 0, sizeof(hl_urho3d_graphics_drawable));
    p->finalizer = (void *)finalize_urho3d_graphics_drawable;
    p->ptr = drawable;
    return p;
}
*/

HL_PRIM hl_urho3d_scene_node *HL_NAME(_graphics_drawable_get_node)(urho3d_context *context, hl_urho3d_graphics_drawable *drawable)
{
    if (drawable)
    {
        return hl_alloc_urho3d_scene_node(context, drawable->GetNode());
    }
    else
    {
        return NULL;
    }
}

DEFINE_PRIM(HL_URHO3D_NODE, _graphics_drawable_get_node, URHO3D_CONTEXT HL_URHO3D_DRAWABLE);
