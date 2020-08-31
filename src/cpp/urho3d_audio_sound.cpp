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

void finalize_urho3d_audio_sound(void *v)
{
    hl_urho3d_audio_sound *hl_ptr = (hl_urho3d_audio_sound *)v;
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

hl_urho3d_audio_sound *hl_alloc_urho3d_audio_sound(urho3d_context *context, const char *name)
{

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

    SharedPtr<Urho3D::Sound> resource(cache->GetResource<Sound>(String(name)));
    if (resource)
    {
        hl_urho3d_audio_sound *p = (hl_urho3d_audio_sound *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_audio_sound));
        memset(p, 0, sizeof(hl_urho3d_audio_sound));
        p->finalizer = (void *)finalize_urho3d_audio_sound;
        p->ptr = resource;
        return p;
    }
    else
    {
        return NULL;
    }
}

hl_urho3d_audio_sound *hl_alloc_urho3d_audio_sound(Urho3D::Sound *sound)
{

    hl_urho3d_audio_sound *p = (hl_urho3d_audio_sound *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_audio_sound));
    memset(p, 0, sizeof(hl_urho3d_audio_sound));
    p->finalizer = (void *)finalize_urho3d_audio_sound;
    p->ptr = sound;
    return p;
}

HL_PRIM hl_urho3d_audio_sound *HL_NAME(_audio_sound_create)(urho3d_context *context,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_audio_sound(context,ch);
}


HL_PRIM const char *HL_NAME(_audio_sound_get_name)(hl_urho3d_audio_sound  * hl_obj)
{
    if(hl_obj)
    {
        Urho3D::Sound * urho3d_obj=  hl_obj->ptr;
        if(urho3d_obj)
             return urho3d_obj->GetName().CString();
    }

    return "null";

}

DEFINE_PRIM(HL_URHO3D_SOUND, _audio_sound_create, URHO3D_CONTEXT _STRING);
DEFINE_PRIM(_BYTES, _audio_sound_get_name, HL_URHO3D_SOUND);
