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



HL_PRIM  hl_urho3d_uielement * HL_NAME(_ui_get_root)(urho3d_context *context)
{
   UI *ui = context->GetSubsystem<UI>();
   if(ui)
   {
       hl_urho3d_uielement * v =  hl_alloc_urho3d_uielement(context, dynamic_cast<Urho3D::UIElement *>(ui->GetRoot()));
       return v;
   }
   else
   {
       return NULL;
   }
   
}

HL_PRIM  Urho3D::IntVector2 * HL_NAME(_ui_get_cursor_position)(urho3d_context *context)
{
   UI *ui = context->GetSubsystem<UI>();
   if(ui)
   {
       return hl_alloc_urho3d_math_tintvector2(ui->GetCursorPosition());
   }
   else
   {
       return NULL;
   }
   

}


DEFINE_PRIM(HL_URHO3D_UIELEMENT, _ui_get_root, URHO3D_CONTEXT );
DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _ui_get_cursor_position, URHO3D_CONTEXT );
