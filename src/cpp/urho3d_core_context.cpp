
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



HL_PRIM  Urho3D::Context * HL_NAME(_create_context)()
{
    Urho3D::Context *context = new Urho3D::Context();
    return context;
}

DEFINE_PRIM(URHO3D_CONTEXT, _create_context, _NO_ARG);
