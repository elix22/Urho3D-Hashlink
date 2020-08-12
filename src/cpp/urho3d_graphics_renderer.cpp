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

HL_PRIM void HL_NAME(_graphics_renderer_set_viewport)(urho3d_context *context, int index, hl_urho3d_graphics_viewport *viewport)
{
    Renderer *renderer = context->GetSubsystem<Renderer>();
    if (renderer)
    {
        renderer->SetViewport(index, viewport->ptr);
    }
}

HL_PRIM hl_urho3d_graphics_viewport * HL_NAME(_graphics_renderer_get_viewport)(urho3d_context *context, int index)
{
    Renderer *renderer = context->GetSubsystem<Renderer>();
    if (renderer)
    {
        return hl_alloc_urho3d_graphics_viewport(renderer->GetViewport(index));
    }
}

// Viewport* GetViewport(unsigned index) const;
HL_PRIM void HL_NAME(_graphics_renderer_draw_debug_geometry)(urho3d_context *context, bool drawDebug)
{
    Renderer *renderer = context->GetSubsystem<Renderer>();
    if (renderer)
    {
        renderer->DrawDebugGeometry(drawDebug);
    }
}

HL_PRIM void HL_NAME(_graphics_renderer_set_num_viewports)(urho3d_context *context, int count)
{
    Renderer *renderer = context->GetSubsystem<Renderer>();
    if (renderer)
    {
        renderer->SetNumViewports(count);
    }
}

HL_PRIM int HL_NAME(_graphics_renderer_get_num_viewports)(urho3d_context *context)
{
    Renderer *renderer = context->GetSubsystem<Renderer>();
    if (renderer)
    {
        return renderer->GetNumViewports();
    }
    else
    {
        return 0;
    }
}

DEFINE_PRIM(_VOID, _graphics_renderer_set_viewport, URHO3D_CONTEXT _I32 HL_URHO3D_VIEWPORT);
DEFINE_PRIM(HL_URHO3D_VIEWPORT, _graphics_renderer_get_viewport, URHO3D_CONTEXT _I32 );
DEFINE_PRIM(_VOID, _graphics_renderer_draw_debug_geometry, URHO3D_CONTEXT _BOOL);
DEFINE_PRIM(_VOID, _graphics_renderer_set_num_viewports, URHO3D_CONTEXT _I32);
DEFINE_PRIM(_I32, _graphics_renderer_get_num_viewports, URHO3D_CONTEXT );
