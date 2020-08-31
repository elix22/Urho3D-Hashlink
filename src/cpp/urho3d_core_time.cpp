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


HL_PRIM  int HL_NAME(_core_time_get_system_time)(urho3d_context *context)
{
       int i= Time::GetSystemTime();
       if(i<0)i=0-i;
       return i;
}

DEFINE_PRIM(_I32, _core_time_get_system_time, URHO3D_CONTEXT );
