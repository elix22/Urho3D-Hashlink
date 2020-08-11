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

void finalize_urho3d_texture2d(void *v)
{

    hl_urho3d_texture2d *hl_ptr = (hl_urho3d_texture2d *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            //printf("finalize_urho3d_texture2d  refs:%d\n", hl_ptr->ptr->Refs());
            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_texture2d *hl_alloc_urho3d_txture2d(urho3d_context *context)
{

    hl_urho3d_texture2d *p = (hl_urho3d_texture2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_texture2d));
    memset(p, 0, sizeof(hl_urho3d_texture2d));
    p->finalizer = (void *)finalize_urho3d_texture2d;
    p->ptr = new Texture2D(context);
    return p;
}

hl_urho3d_texture2d *hl_alloc_urho3d_txture2d(urho3d_context *context, const char *name)
{

    //printf("hl_alloc_urho3d_txture2d  name:%s \n",String(name).CString());

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

    SharedPtr<Urho3D::Texture2D> resource(cache->GetResource<Texture2D>(String(name)));
    //printf("refs:%d\n", resource->Refs());
    if (resource)
    {
        hl_urho3d_texture2d *p = (hl_urho3d_texture2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_texture2d));
        memset(p, 0, sizeof(hl_urho3d_texture2d));
        p->finalizer = (void *)finalize_urho3d_texture2d;
        p->ptr = resource;
        return p;
    }
    else
    {
        return NULL;
    }
}

hl_urho3d_texture2d *hl_alloc_urho3d_texture2d(SharedPtr<Urho3D::Texture2D> texture2d)
{
    hl_urho3d_texture2d *p = (hl_urho3d_texture2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_resource));
    p->finalizer = (void *)finalize_urho3d_texture2d;
    p->ptr = texture2d;
    return p;
}

hl_urho3d_texture2d *hl_alloc_urho3d_texture2d(Urho3D::Texture2D *texture2d)
{
    hl_urho3d_texture2d *p = (hl_urho3d_texture2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_resource));
    p->finalizer = (void *)finalize_urho3d_texture2d;
    p->ptr = texture2d;
    return p;
}

HL_PRIM hl_urho3d_texture2d *HL_NAME(_graphics_texture2d_create)(urho3d_context *context, vstring *str)
{
    const char *ch = (char *)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_txture2d(context, ch);
}

HL_PRIM hl_urho3d_texture2d *HL_NAME(_graphics_texture2d_create_empty)(urho3d_context *context)
{
    return hl_alloc_urho3d_txture2d(context);
}

HL_PRIM const char *HL_NAME(_graphics_texture2d_get_name)(hl_urho3d_texture2d *hl_texture2d)
{
    if (hl_texture2d)
    {
        Urho3D::Texture2D *urho3d_texture2d = hl_texture2d->ptr;
        if (urho3d_texture2d)
            return urho3d_texture2d->GetName().CString();
    }

    return "null";
}

HL_PRIM hl_urho3d_graphics_texture *HL_NAME(_graphics_texture2d_cast_to_texture)(urho3d_context *context, hl_urho3d_texture2d *hl_texture2d)
{
    Texture2D *t = hl_texture2d->ptr;
    if (t)
    {
        return hl_alloc_urho3d_graphics_texture(dynamic_cast<Urho3D::Texture *>(t));
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_texture2d *HL_NAME(_graphics_texture2d_cast_from_texture)(urho3d_context *context, hl_urho3d_graphics_texture *hl_texture)
{
    Texture *t = hl_texture->ptr;
    if (t)
    {
        return hl_alloc_urho3d_texture2d(dynamic_cast<Urho3D::Texture2D *>(t));
    }
    else
    {
        return NULL;
    }
}


HL_PRIM bool HL_NAME(_graphics_texture2d_set_size)(urho3d_context *context, hl_urho3d_texture2d *hl_texture2d,int width, int height, int format, int usage, int multiSample, bool autoResolve)
{
    if (hl_texture2d->ptr)
    {      
        return hl_texture2d->ptr->SetSize(width,height,(unsigned int)format,TextureUsage(usage),multiSample,autoResolve);
    }
    else
    {
        return false;
    }
}


HL_PRIM void HL_NAME(_graphics_texture2d_set_filter_mode)(urho3d_context *context, hl_urho3d_texture2d *hl_texture2d,int mode)
{
    if (hl_texture2d->ptr)
    {
        hl_texture2d->ptr->SetFilterMode(TextureFilterMode(mode));
    }
}

HL_PRIM int HL_NAME(_graphics_texture2d_get_filter_mode)(urho3d_context *context, hl_urho3d_texture2d *hl_texture2d)
{
    if (hl_texture2d->ptr)
    {
        return hl_texture2d->ptr->GetFilterMode();
    }
}

HL_PRIM hl_urho3d_graphics_render_surface * HL_NAME(_graphics_texture2d_get_render_surface)(urho3d_context *context, hl_urho3d_texture2d *hl_texture2d)
{
    return hl_alloc_urho3d_graphics_render_surface(hl_texture2d->ptr->GetRenderSurface());
}

DEFINE_PRIM(HL_URHO3D_TEXTURE2D, _graphics_texture2d_create, URHO3D_CONTEXT _STRING);
DEFINE_PRIM(HL_URHO3D_TEXTURE2D, _graphics_texture2d_create_empty, URHO3D_CONTEXT);
DEFINE_PRIM(_BYTES, _graphics_texture2d_get_name, HL_URHO3D_TEXTURE2D);
DEFINE_PRIM(HL_URHO3D_TEXTURE, _graphics_texture2d_cast_to_texture, URHO3D_CONTEXT HL_URHO3D_TEXTURE2D);
DEFINE_PRIM(HL_URHO3D_TEXTURE2D, _graphics_texture2d_cast_from_texture, URHO3D_CONTEXT HL_URHO3D_TEXTURE);
DEFINE_PRIM(_BOOL, _graphics_texture2d_set_size, URHO3D_CONTEXT HL_URHO3D_TEXTURE2D _I32 _I32 _I32 _I32 _I32 _BOOL);
DEFINE_PRIM(_VOID, _graphics_texture2d_set_filter_mode, URHO3D_CONTEXT HL_URHO3D_TEXTURE2D _I32);
DEFINE_PRIM(_I32, _graphics_texture2d_get_filter_mode, URHO3D_CONTEXT HL_URHO3D_TEXTURE2D );

DEFINE_PRIM(HL_URHO3D_RENDER_SURFACE, _graphics_texture2d_get_render_surface, URHO3D_CONTEXT HL_URHO3D_TEXTURE2D );
