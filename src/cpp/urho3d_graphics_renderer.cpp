

#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

HL_PRIM void HL_NAME(_graphics_renderer_set_viewport)(urho3d_context *context, int index, hl_urho3d_graphics_viewport *viewport)
{
    Renderer *renderer = context->GetSubsystem<Renderer>();
    if (renderer)
    {
         renderer->SetViewport(index,viewport->ptr);
    }
}


DEFINE_PRIM(_VOID, _graphics_renderer_set_viewport, URHO3D_CONTEXT _I32 HL_URHO3D_VIEWPORT);
