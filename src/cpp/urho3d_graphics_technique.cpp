#define HL_NAME(n) Urho3D_##n
extern "C"
{
#if defined(URHO3D_HAXE_HASHLINK)
#include <hashlink/hl.h>
#else
#include <hl.h>
#endif
}

#include "global_types.h"

void finalize_urho3d_graphics_technique(void *v)
{
    hl_urho3d_graphics_technique *hl_ptr = (hl_urho3d_graphics_technique *)v;
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

hl_urho3d_graphics_technique *hl_alloc_urho3d_graphics_technique(urho3d_context *context, const char *name)
{

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

    SharedPtr<Urho3D::Technique> resource(cache->GetResource<Technique>(String(name)));
    if (resource)
    {
        hl_urho3d_graphics_technique *p = (hl_urho3d_graphics_technique *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_technique));
        memset(p, 0, sizeof(hl_urho3d_graphics_technique));
        p->finalizer = (void *)finalize_urho3d_graphics_technique;
        p->ptr = resource;
        return p;
    }
    else
    {
        return NULL;
    }
}

hl_urho3d_graphics_technique *hl_alloc_urho3d_graphics_technique(Urho3D::Technique *obj)
{

    hl_urho3d_graphics_technique *p = (hl_urho3d_graphics_technique *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_technique));
    memset(p, 0, sizeof(hl_urho3d_graphics_technique));
    p->finalizer = (void *)finalize_urho3d_graphics_technique;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_graphics_technique *HL_NAME(_graphics_technique_create)(urho3d_context *context,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_graphics_technique(context,ch);
}


HL_PRIM const char *HL_NAME(_graphics_technique_get_name)(hl_urho3d_graphics_technique  * hl_technique)
{
    if(hl_technique)
    {
        if(hl_technique->ptr)
             return hl_technique->ptr->GetName().CString();
    }

    return "null";

}

DEFINE_PRIM(HL_URHO3D_TECHNIQUE, _graphics_technique_create, URHO3D_CONTEXT _STRING);
DEFINE_PRIM(_BYTES, _graphics_technique_get_name, HL_URHO3D_TECHNIQUE);
