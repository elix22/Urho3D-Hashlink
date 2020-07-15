#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>

#include "global_types.h"


vdynamic *hl_dyn_abstract_call( vclosure *c, vdynamic **args, int nargs );

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
           // hl_dyn_call(callback_stop, args, 0);

            hl_remove_root(&callback_stop);
            callback_stop = NULL;
        }

        if(callback_start)
        {
            hl_remove_root(&callback_start);
            callback_start = NULL;
        }

        if(callback_setup)
        {
            hl_remove_root(&callback_setup);
            callback_setup = NULL;
        }
    }

    void subscribeToEvent(hl_urho3d_stringhash* stringhash,vclosure *callback_fn)
    {
        if(stringhash)
        {
            Urho3D::StringHash *  urho3d_stringhash  = stringhash->ptr;
            if(urho3d_stringhash)
            {
                hl_add_root(&callback_fn);
                printf("subscribeToEvent %s",urho3d_stringhash->ToString().CString());
                hl_event_closures[*urho3d_stringhash] = callback_fn;

                SubscribeToEvent(*urho3d_stringhash,URHO3D_HANDLER(ProxyApp, HandlEvents));
            }
        }
    }

    void subscribeToEvent2(hl_urho3d_stringhash* stringhash,vclosure *callback_fn)
    {
        if(stringhash)
        {
            Urho3D::StringHash *  urho3d_stringhash  = stringhash->ptr;
            if(urho3d_stringhash)
            {
                hl_add_root(&callback_fn);
                printf("subscribeToEvent2 %s",urho3d_stringhash->ToString().CString());
                hl_event_closures2[*urho3d_stringhash] = callback_fn;

                SubscribeToEvent(*urho3d_stringhash,URHO3D_HANDLER(ProxyApp, HandlEvents2));
            }
        }
    }


    void HandlEvents2(StringHash eventType, VariantMap& eventData)
    {
       vclosure *callback_fn = hl_event_closures2[eventType];
        if(callback_fn)
        {
            hl_type hl_abstract_urho3d_stringhash = {HABSTRACT};
            hl_abstract_urho3d_stringhash.abs_name = (const uchar *)hl_to_utf16("hl_urho3d_stringhash");

            vdynamic *obj = (vdynamic*)hl_alloc_dynobj();

            hl_dyn_seti(obj, hl_hash_gen(hl_to_utf16("testInt"), true), &hlt_i32, 458);

            vdynamic *args[1];
            args[0] = obj;
            hl_dyn_call(callback_fn, args, 1);

        }
    }

    void HandlEvents(StringHash eventType, VariantMap& eventData)
    {
        vclosure *callback_fn = hl_event_closures[eventType];
        if(callback_fn)
        {

            hl_urho3d_stringhash * hl_stringhsh = hl_alloc_urho3d_stringhash_no_finlizer();
            hl_stringhsh->ptr = &eventType;
            hl_type hl_stringhsh_abstract = {HABSTRACT};
            hl_stringhsh_abstract.abs_name = hl_to_utf16("hl_urho3d_stringhash");
            vdynamic * dyn_urho3d_stringhash = hl_alloc_dynamic(&hl_stringhsh_abstract);
            dyn_urho3d_stringhash->v.ptr = hl_stringhsh;

            hl_urho3d_variantmap * hl_variantmap = hl_alloc_urho3d_variantmap_no_finlizer();
            hl_variantmap->ptr = &eventData;
            hl_type hl_variantmap_abstract = {HABSTRACT};
            hl_variantmap_abstract.abs_name = hl_to_utf16("hl_urho3d_variantmap");
            vdynamic * dyn_urho3d_variantmap = hl_alloc_dynamic(&hl_stringhsh_abstract);
            dyn_urho3d_variantmap->v.ptr = hl_variantmap;


           vdynamic *args[2];
           args[0]= dyn_urho3d_stringhash;
           args[1]=dyn_urho3d_variantmap;

           hl_dyn_abstract_call(callback_fn, args, 2);
        }
    }


    public :
    vclosure *callback_setup;
    vclosure *callback_start;
    vclosure *callback_stop;

    HashMap<StringHash, vclosure *>  hl_event_closures;

    HashMap<StringHash, vclosure *>  hl_event_closures2;

};

hl_urho3d_application * hl_alloc_urho3d_application(hl_finalizer finalizer,urho3d_context * context)
{
    //printf("hl_alloc_urho3d_application enter \n");
    hl_urho3d_application  * p= (hl_urho3d_application *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_application));
    memset(p,0,sizeof(hl_urho3d_application));
    
    p->finalizer = finalizer?(void*)finalizer:0;
    p->ptr = new ProxyApp(context);

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
             /* appptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
             appptr->ptr = NULL;
         }
         appptr->finalizer = NULL;
    }
    
}

HL_PRIM  hl_urho3d_application  * HL_NAME(_create_application)(urho3d_context * context)
{
   // printf("_create_application enter \n");
    hl_urho3d_application * v =  hl_alloc_urho3d_application(finalize_urho3d_application,context);
    return v;
}


HL_PRIM  void HL_NAME(_run_application)(hl_urho3d_application * app)
{
   // printf("_run_application enter \n");
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
        hl_add_root(&callback_fn);
    }
}

HL_PRIM  void HL_NAME(_start_closure_application)(hl_urho3d_application * app,vclosure *callback_fn)
{
    Urho3D::Application  * ptr_app = app->ptr;
    if(ptr_app)
    {
        ProxyApp * proxyApp  = (ProxyApp *)ptr_app;
        proxyApp->callback_start = callback_fn;
        hl_add_root(&callback_fn);
    }
}

HL_PRIM  void HL_NAME(_stop_closure_application)(hl_urho3d_application * app,vclosure *callback_fn)
{
    Urho3D::Application  * ptr_app = app->ptr;
    if(ptr_app)
    {
        ProxyApp * proxyApp  = (ProxyApp *)ptr_app;
        proxyApp->callback_stop = callback_fn;
        hl_add_root(&callback_fn);
    }
}

HL_PRIM  void HL_NAME(_application_subscribe_to_event)(hl_urho3d_application * app,hl_urho3d_stringhash* stringhash,vclosure *callback_fn)
{
    Urho3D::Application  * ptr_app = app->ptr;
    if(ptr_app)
    {
        ProxyApp * proxyApp  = (ProxyApp *)ptr_app;
        proxyApp->subscribeToEvent(stringhash,callback_fn);
    }
}

HL_PRIM  void HL_NAME(_application_subscribe_to_event2)(hl_urho3d_application * app,hl_urho3d_stringhash* stringhash,vclosure *callback_fn)
{
    Urho3D::Application  * ptr_app = app->ptr;
    if(ptr_app)
    {
        ProxyApp * proxyApp  = (ProxyApp *)ptr_app;
        proxyApp->subscribeToEvent2(stringhash,callback_fn);
    }
}

DEFINE_PRIM(HL_URHO3D_APPLICATION, _create_application, URHO3D_CONTEXT);
DEFINE_PRIM(_VOID, _run_application, HL_URHO3D_APPLICATION);
DEFINE_PRIM(_VOID, _setup_closure_application, HL_URHO3D_APPLICATION _FUN(_VOID, _NO_ARG));
DEFINE_PRIM(_VOID, _start_closure_application, HL_URHO3D_APPLICATION _FUN(_VOID, _NO_ARG));
DEFINE_PRIM(_VOID, _stop_closure_application, HL_URHO3D_APPLICATION _FUN(_VOID, _NO_ARG));

DEFINE_PRIM(_VOID, _application_subscribe_to_event, HL_URHO3D_APPLICATION HL_URHO3D_STRINGHASH _FUN(_VOID, HL_URHO3D_STRINGHASH HL_URHO3D_VARIANTMAP));
DEFINE_PRIM(_VOID, _application_subscribe_to_event2, HL_URHO3D_APPLICATION HL_URHO3D_STRINGHASH _FUN(_VOID, _DYN));
