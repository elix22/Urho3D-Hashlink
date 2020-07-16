
#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"



HL_PRIM  Urho3D::Context * HL_NAME(_create_context)()
{
    Urho3D::Context *context = new Urho3D::Context();
    return context;
}

DEFINE_PRIM(URHO3D_CONTEXT, _create_context, _NO_ARG);
