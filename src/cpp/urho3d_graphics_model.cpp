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

void finalize_urho3d_graphics_model(void *v)
{
    hl_urho3d_graphics_model *hl_ptr = (hl_urho3d_graphics_model *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_graphics_model *hl_alloc_urho3d_graphics_model(urho3d_context *context, const char *name)
{

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

    SharedPtr<Urho3D::Model> resource(cache->GetResource<Model>(String(name)));
    if (resource)
    {
        hl_urho3d_graphics_model *p = (hl_urho3d_graphics_model *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_model));
        memset(p, 0, sizeof(hl_urho3d_graphics_model));
        p->finalizer = (void *)finalize_urho3d_graphics_model;
        p->ptr = resource;
       // printf("hl_alloc_urho3d_graphics_model success \n");
        return p;
    }
    else
    {
      //  printf("hl_alloc_urho3d_graphics_model = NULL \n");
        return NULL;
    }
}

hl_urho3d_graphics_model *hl_alloc_urho3d_graphics_model(Model *model)
{

    hl_urho3d_graphics_model *p = (hl_urho3d_graphics_model *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_model));
    memset(p, 0, sizeof(hl_urho3d_graphics_model));
    p->finalizer = (void *)finalize_urho3d_graphics_model;
    p->ptr = model;
    return p;
}

HL_PRIM hl_urho3d_graphics_model *HL_NAME(_graphics_model_create)(urho3d_context *context,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_graphics_model(context,ch);
}

DEFINE_PRIM(HL_URHO3D_MODEL, _graphics_model_create, URHO3D_CONTEXT _STRING);
