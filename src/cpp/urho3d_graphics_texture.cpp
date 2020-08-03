#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_graphics_texture(void *v)
{
    hl_urho3d_graphics_texture *hl_ptr = (hl_urho3d_graphics_texture *)v;
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

hl_urho3d_graphics_texture *hl_alloc_urho3d_graphics_texture(urho3d_context *context, const char *name)
{

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

    SharedPtr<Urho3D::Texture> resource(cache->GetResource<Texture>(String(name)));
    if (resource)
    {
        hl_urho3d_graphics_texture *p = (hl_urho3d_graphics_texture *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_texture));
        memset(p, 0, sizeof(hl_urho3d_graphics_texture));
        p->finalizer = (void *)finalize_urho3d_graphics_texture;
        p->ptr = resource;
       // printf("hl_alloc_urho3d_graphics_texture success \n");
        return p;
    }
    else
    {
      //  printf("hl_alloc_urho3d_graphics_texture = NULL \n");
        return NULL;
    }
}

hl_urho3d_graphics_texture *hl_alloc_urho3d_graphics_texture(Urho3D::Texture *texture)
{

    hl_urho3d_graphics_texture *p = (hl_urho3d_graphics_texture *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_texture));
    memset(p, 0, sizeof(hl_urho3d_graphics_texture));
    p->finalizer = (void *)finalize_urho3d_graphics_texture;
    p->ptr = texture;
    return p;
}

HL_PRIM hl_urho3d_graphics_texture *HL_NAME(_graphics_texture_create)(urho3d_context *context,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_graphics_texture(context,ch);
}


HL_PRIM const char *HL_NAME(_graphics_texture_get_name)(hl_urho3d_graphics_texture  * hl_texture)
{
    if(hl_texture)
    {
        Urho3D::Texture * urho3d_texture=  hl_texture->ptr;
        if(urho3d_texture)
             return urho3d_texture->GetName().CString();
    }

    return "null";

}

DEFINE_PRIM(HL_URHO3D_TEXTURE, _graphics_texture_create, URHO3D_CONTEXT _STRING);
DEFINE_PRIM(_BYTES, _graphics_texture_get_name, HL_URHO3D_TEXTURE);