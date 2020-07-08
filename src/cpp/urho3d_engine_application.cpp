#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


class ProxyApp : public Application
{
    // Enable type information.
    URHO3D_OBJECT(ProxyApp, Application);

    explicit ProxyApp(Context *context) : Application(context)
    {
        callback_setup = NULL;
        callback_start = NULL;
        callback_stop = NULL;
    }

    void Setup() override
    {
        
               //
        engineParameters_[EP_RESOURCE_PREFIX_PATHS] = GetSubsystem<FileSystem>()->GetProgramDir();
#if URHO3D_HAXE_HASHLINK
         engineParameters_[EP_RESOURCE_PATHS] = "Data;CoreData;";
#else
        engineParameters_[EP_RESOURCE_PATHS] = "bin/Data;bin/CoreData;";
#endif
        engineParameters_[EP_LOG_NAME] = GetSubsystem<FileSystem>()->GetProgramDir() + "UrhoHaxe.log";
        engineParameters_[EP_FULL_SCREEN] = false;
        engineParameters_[EP_WINDOW_WIDTH] = 1280;
        engineParameters_[EP_WINDOW_HEIGHT] = 720;
        engineParameters_[EP_WINDOW_TITLE] = "UrhoHaxe";
        engineParameters_[EP_WINDOW_ICON] = "Textures/UrhoIcon.png";

        
        if(callback_setup)
        {
            vdynamic *args[1];
            hl_dyn_call(callback_setup, args, 0);
        }
    }

    void Start() override
    {
        if(callback_start)
        {
            vdynamic *args[1];
            hl_dyn_call(callback_start, args, 0);
        }
    }

    void Stop() override
    {
        if(callback_stop)
        {
            vdynamic *args[1];
            hl_dyn_call(callback_stop, args, 0);
        }
    }

    public :
    vclosure *callback_setup;
    vclosure *callback_start;
    vclosure *callback_stop;
};

hl_urho3d_application * hl_alloc_urho3d_application(hl_finalizer finalizer,urho3d_context * context)
{
    printf("hl_alloc_urho3d_application enter \n");
    hl_urho3d_application  * p= (hl_urho3d_application *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_application));

    p->finalizer = finalizer?(void*)finalizer:0;
    Urho3D::Application *v = new ProxyApp(context);
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

HL_PRIM  void HL_NAME(_setup_closure_application)(hl_urho3d_application * app,vclosure *callback_fn)
{
    Urho3D::Application  * ptr_app = app->ptr;
    if(ptr_app)
    {
        ProxyApp * proxyApp  = (ProxyApp *)ptr_app;
        proxyApp->callback_setup = callback_fn;
    }
}

HL_PRIM  void HL_NAME(_start_closure_application)(hl_urho3d_application * app,vclosure *callback_fn)
{
    Urho3D::Application  * ptr_app = app->ptr;
    if(ptr_app)
    {
        ProxyApp * proxyApp  = (ProxyApp *)ptr_app;
        proxyApp->callback_start = callback_fn;
    }
}

HL_PRIM  void HL_NAME(_stop_closure_application)(hl_urho3d_application * app,vclosure *callback_fn)
{
    Urho3D::Application  * ptr_app = app->ptr;
    if(ptr_app)
    {
        ProxyApp * proxyApp  = (ProxyApp *)ptr_app;
        proxyApp->callback_stop = callback_fn;
    }
}

DEFINE_PRIM(HL_URHO3D_APPLICATION, _create_application, URHO3D_CONTEXT);
DEFINE_PRIM(_VOID, _run_application, HL_URHO3D_APPLICATION);
DEFINE_PRIM(_VOID, _setup_closure_application, HL_URHO3D_APPLICATION _FUN(_VOID, _NO_ARG));
DEFINE_PRIM(_VOID, _start_closure_application, HL_URHO3D_APPLICATION _FUN(_VOID, _NO_ARG));
DEFINE_PRIM(_VOID, _stop_closure_application, HL_URHO3D_APPLICATION _FUN(_VOID, _NO_ARG));