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

void finalize_urho3d_graphics_render_surface(void *v)
{
    hl_urho3d_graphics_render_surface *hl_ptr = (hl_urho3d_graphics_render_surface *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_graphics_render_surface *hl_alloc_urho3d_graphics_render_surface(Texture *parentTexture)
{

    hl_urho3d_graphics_render_surface *p = (hl_urho3d_graphics_render_surface *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_render_surface));
    memset(p, 0, sizeof(hl_urho3d_graphics_render_surface));
    p->finalizer = (void *)finalize_urho3d_graphics_render_surface;
    p->ptr = new Urho3D::RenderSurface(parentTexture);
    return p;
}

hl_urho3d_graphics_render_surface *hl_alloc_urho3d_graphics_render_surface(Urho3D::RenderSurface *obj)
{

    hl_urho3d_graphics_render_surface *p = (hl_urho3d_graphics_render_surface *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_render_surface));
    memset(p, 0, sizeof(hl_urho3d_graphics_render_surface));
    p->finalizer = (void *)finalize_urho3d_graphics_render_surface;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_graphics_render_surface *HL_NAME(_graphics_render_surface_create)(urho3d_context *context, hl_urho3d_graphics_texture *hl_texture)
{
    return hl_alloc_urho3d_graphics_render_surface(hl_texture->ptr);
}

HL_PRIM void HL_NAME(_graphics_render_surface_set_viewport)(urho3d_context *context, hl_urho3d_graphics_render_surface *surface, int index, hl_urho3d_graphics_viewport *viewport)
{
    surface->ptr->SetViewport(index, viewport->ptr);
}

HL_PRIM hl_urho3d_graphics_viewport * HL_NAME(_graphics_render_surface_get_viewport)(urho3d_context *context, hl_urho3d_graphics_render_surface *surface, int index)
{
    return hl_alloc_urho3d_graphics_viewport(surface->ptr->GetViewport(index));
}

DEFINE_PRIM(HL_URHO3D_RENDER_SURFACE, _graphics_render_surface_create, URHO3D_CONTEXT HL_URHO3D_TEXTURE);
DEFINE_PRIM(_VOID, _graphics_render_surface_set_viewport, URHO3D_CONTEXT HL_URHO3D_RENDER_SURFACE _I32 HL_URHO3D_VIEWPORT);
DEFINE_PRIM(HL_URHO3D_VIEWPORT, _graphics_render_surface_get_viewport, URHO3D_CONTEXT HL_URHO3D_RENDER_SURFACE _I32 );
