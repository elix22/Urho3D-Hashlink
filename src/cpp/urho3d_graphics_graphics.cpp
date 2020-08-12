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


HL_PRIM  int HL_NAME(_graphics_get_width)(urho3d_context *context)
{
   Graphics *graphics = context->GetSubsystem<Graphics>();
   if(graphics)
   {
       return graphics->GetWidth();
   }
   else
   {
       return 0;
   }
   
}

HL_PRIM  int HL_NAME(_graphics_get_height)(urho3d_context *context)
{
   Graphics *graphics = context->GetSubsystem<Graphics>();
   if(graphics)
   {
       return graphics->GetHeight();
   }
   else
   {
       return 0;
   }
   
}


//DEFINE_PRIM_WITH_NAME("i",_graphics_get_width,"X" "urho3d_context" "_",_graphics_get_width)

//#define _DEFINE_PRIM_WITH_NAME(t,name,args,realName)
//#define _DEFINE_PRIM_WITH_NAME("i",_graphics_get_width,"X" "urho3d_context" "_",_graphics_get_width)

//extern "C" {	EXPORT void *hlp__graphics_get_width(const char **sign) { *sign =  "P" "X" "urho3d_context" "_" "_" "i" ; return (void*)(&Urho3D__graphics_get_width)); }  };  
//=>  C_FUNCTION_BEGIN EXPORT void *hlp_##realName( const char  **sign) { *sign = _FUN(t,args); return (void*)(&HL_NAME(name)); } C_FUNCTION_END


DEFINE_PRIM(_I32, _graphics_get_width, URHO3D_CONTEXT );
DEFINE_PRIM(_I32, _graphics_get_height, URHO3D_CONTEXT );


