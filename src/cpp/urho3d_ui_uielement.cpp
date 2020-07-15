#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


void finalize_urho3d_uielement(void * v)
{
    
    hl_urho3d_uielement  * hl_ptr= (hl_urho3d_uielement  * )v;
    if(hl_ptr)
    {
         if(hl_ptr->ptr)
         {
             //printf("finalize_urho3d_texture2d  refs:%d\n", hl_ptr->ptr->Refs());
             /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
             hl_ptr->ptr = NULL;
             
         }
         hl_ptr->finalizer = NULL;
    }
    
}

hl_urho3d_uielement * hl_alloc_urho3d_uielement(urho3d_context *context )
{


        hl_urho3d_uielement *p = (hl_urho3d_uielement *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_uielement));
        memset(p,0,sizeof(hl_urho3d_uielement));
        p->finalizer = (void *)finalize_urho3d_uielement;
        p->ptr = new Urho3D::UIElement(context);
        return p;
}

hl_urho3d_uielement * hl_alloc_urho3d_uielement(urho3d_context *context, Urho3D::UIElement * uielement )
{


        hl_urho3d_uielement *p = (hl_urho3d_uielement *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_uielement));
        memset(p,0,sizeof(hl_urho3d_uielement));
        p->finalizer = (void *)finalize_urho3d_uielement;
        p->ptr = uielement;
        return p;
}



HL_PRIM  hl_urho3d_uielement  * HL_NAME(_create_uielement)(urho3d_context *context)
{
    hl_urho3d_uielement * v =  hl_alloc_urho3d_uielement(context);
    return v;
}

HL_PRIM  void HL_NAME(_ui_uielement_addchild)(urho3d_context *context, hl_urho3d_uielement  * this_, hl_urho3d_uielement  * ui_child)
{
    // TBD ELI , add null ptr protection
    this_->ptr->AddChild(ui_child->ptr);
}
//

//


DEFINE_PRIM(HL_URHO3D_UIELEMENT, _create_uielement, URHO3D_CONTEXT );
DEFINE_PRIM(_VOID, _ui_uielement_addchild, URHO3D_CONTEXT HL_URHO3D_UIELEMENT HL_URHO3D_UIELEMENT);
