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

void finalize_urho3d_ui_font(void *v)
{

    hl_urho3d_ui_font *hl_ptr = (hl_urho3d_ui_font *)v;
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

hl_urho3d_ui_font *hl_alloc_urho3d_ui_font(urho3d_context *context, const char *name)
{

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

    SharedPtr<Urho3D::Font> resource(cache->GetResource<Font>(String(name)));

    if (resource)
    {
        hl_urho3d_ui_font *p = (hl_urho3d_ui_font *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_ui_font));
        memset(p, 0, sizeof(hl_urho3d_ui_font));
        p->finalizer = (void *)finalize_urho3d_ui_font;
        p->ptr = resource;
        return p;
    }
    else
        return NULL;
}

hl_urho3d_ui_font *hl_alloc_urho3d_ui_font(urho3d_context *context, Urho3D::Font *text)
{

    hl_urho3d_ui_font *p = (hl_urho3d_ui_font *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_ui_font));
    memset(p, 0, sizeof(hl_urho3d_ui_font));
    p->finalizer = (void *)finalize_urho3d_ui_font;
    p->ptr = text;
    return p;
}

HL_PRIM hl_urho3d_ui_font *HL_NAME(_ui_font_create)(urho3d_context *context, vstring *str)
{
    const char *ch = (char *)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_ui_font(context,ch);
}

DEFINE_PRIM(HL_URHO3D_UI_FONT, _ui_font_create, URHO3D_CONTEXT _STRING);
