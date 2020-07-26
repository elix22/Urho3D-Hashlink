#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


HL_PRIM  hl_urho3d_intvector2  * HL_NAME(_input_get_mousemove)(urho3d_context *context)
{
   Input *graphics = context->GetSubsystem<Input>();
   if(graphics)
   {
       IntVector2  mouse= graphics->GetMouseMove();

       return  hl_alloc_urho3d_intvector2(mouse.x_, mouse.y_);
   }
   else
   {
       return NULL;
   }
   
}

HL_PRIM  int HL_NAME(_input_get_mousemove_x)(urho3d_context *context)
{
   Input *graphics = context->GetSubsystem<Input>();
   if(graphics)
   {
       return graphics->GetMouseMove().x_;
   }
   else
   {
       return 0;
   } 
}

HL_PRIM  int HL_NAME(_input_get_mousemove_y)(urho3d_context *context)
{
   Input *graphics = context->GetSubsystem<Input>();
   if(graphics)
   {
       return graphics->GetMouseMove().y_;
   }
   else
   {
       return 0;
   } 
}




DEFINE_PRIM(HL_URHO3D_INTVECTOR2, _input_get_mousemove, URHO3D_CONTEXT );
DEFINE_PRIM(_I32, _input_get_mousemove_x, URHO3D_CONTEXT );
DEFINE_PRIM(_I32, _input_get_mousemove_y, URHO3D_CONTEXT );
