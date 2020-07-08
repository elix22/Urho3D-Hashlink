#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"



hl_urho3d_application * hl_alloc_urho3d_application(hl_finalizer finalizer,urho3d_context * context)
{
    printf("hl_alloc_urho3d_application enter \n");
    hl_urho3d_application  * p= (hl_urho3d_application *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_application));

    p->finalizer = finalizer?(void*)finalizer:0;
    Urho3D::Application *v = new Urho3D::Application(context);
    p->ptr = v;

    if(p->ptr)
    printf("created application \n");
    return p;
}

void finalize_urho3d_application(void * v)
{
    hl_urho3d_application  * appptr = (hl_urho3d_application  * )v;
    if(appptr)
    {
         Urho3D::Application *app = (Urho3D::Application *)appptr->ptr;
         if(app)
         {
             delete app;
             appptr->ptr = NULL;
         }
         appptr->finalizer = NULL;
    }
    
}

HL_PRIM  hl_urho3d_application  * HL_NAME(_create_application)(urho3d_context * context)
{
    printf("_create_application enter \n");
    hl_urho3d_application * v =  hl_alloc_urho3d_application(finalize_urho3d_application,context);
    return v;
}

HL_PRIM  void HL_NAME(_run_application)(hl_urho3d_application * app)
{
    printf("_run_application enter \n");
    Urho3D::Application  * ptr_app = app->ptr;
    if(ptr_app)
    {
        ptr_app->Run();
    }
}


DEFINE_PRIM(HL_URHO3D_APPLICATION, _create_application, URHO3D_CONTEXT);
DEFINE_PRIM(_VOID, _run_application, HL_URHO3D_APPLICATION);