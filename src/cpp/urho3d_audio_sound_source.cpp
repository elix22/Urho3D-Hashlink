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

void finalize_urho3d_audio_sound_source(void *v)
{
    hl_urho3d_audio_sound_source *hl_ptr = (hl_urho3d_audio_sound_source *)v;
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

hl_urho3d_audio_sound_source *hl_alloc_urho3d_audio_sound_source(urho3d_context *context)
{

    hl_urho3d_audio_sound_source *p = (hl_urho3d_audio_sound_source *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_audio_sound_source));
    memset(p, 0, sizeof(hl_urho3d_audio_sound_source));
    p->finalizer = (void *)finalize_urho3d_audio_sound_source;
    p->ptr = new SoundSource(context);
    return p;
}

hl_urho3d_audio_sound_source *hl_alloc_urho3d_audio_sound_source(SoundSource *obj)
{

    hl_urho3d_audio_sound_source *p = (hl_urho3d_audio_sound_source *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_audio_sound_source));
    memset(p, 0, sizeof(hl_urho3d_audio_sound_source));
    p->finalizer = (void *)finalize_urho3d_audio_sound_source;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_audio_sound_source *HL_NAME(_audio_sound_source_create)(urho3d_context *context)
{
    hl_urho3d_audio_sound_source *v = hl_alloc_urho3d_audio_sound_source(context);
    return v;
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_audio_sound_source_cast_to_component)(urho3d_context *context, hl_urho3d_audio_sound_source *soundSource)
{
    hl_urho3d_scene_component *hl_u3d_obj = hl_alloc_urho3d_scene_component(soundSource->ptr);
    return hl_u3d_obj;
}

HL_PRIM hl_urho3d_audio_sound_source *HL_NAME(_audio_sound_source_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    hl_urho3d_audio_sound_source *hl_u3d_obj = hl_alloc_urho3d_audio_sound_source(dynamic_cast<SoundSource *>(cmp));
    return hl_u3d_obj;
}

//
/* TBD ELI
 void Play(Sound* sound);
  void Play(Sound* sound, float frequency);
  void Play(Sound* sound, float frequency, float gain);
 void Play(Sound* sound, float frequency, float gain, float panning);
*/
HL_PRIM void HL_NAME(_audio_sound_source_play)(urho3d_context *context, hl_urho3d_audio_sound_source *soundSource, hl_urho3d_audio_sound *sound)
{
    soundSource->ptr->Play(sound->ptr);
}


HL_PRIM void HL_NAME(_audio_sound_source_set_gain)(urho3d_context *context, hl_urho3d_audio_sound_source *soundSource, float gain)
{
    soundSource->ptr->SetGain(gain);
}


HL_PRIM float HL_NAME(_audio_sound_source_get_gain)(urho3d_context *context, hl_urho3d_audio_sound_source *soundSource)
{
    return soundSource->ptr->GetGain();
}



HL_PRIM void HL_NAME(_audio_sound_source_set_auto_remove)(urho3d_context *context, hl_urho3d_audio_sound_source *soundSource, int autoremove)
{
    soundSource->ptr->SetAutoRemoveMode(Urho3D::AutoRemoveMode(autoremove));
}



HL_PRIM int HL_NAME(_audio_sound_source_get_auto_remove)(urho3d_context *context, hl_urho3d_audio_sound_source *soundSource)
{
    return soundSource->ptr->GetAutoRemoveMode();
}


DEFINE_PRIM(_VOID, _audio_sound_source_set_gain, URHO3D_CONTEXT HL_URHO3D_SOUND_SOURCE _F32);
DEFINE_PRIM(_F32, _audio_sound_source_get_gain, URHO3D_CONTEXT HL_URHO3D_SOUND_SOURCE);
DEFINE_PRIM(_I32, _audio_sound_source_get_auto_remove, URHO3D_CONTEXT HL_URHO3D_SOUND_SOURCE );
DEFINE_PRIM(_VOID, _audio_sound_source_set_auto_remove, URHO3D_CONTEXT HL_URHO3D_SOUND_SOURCE _I32);


DEFINE_PRIM(HL_URHO3D_SOUND_SOURCE, _audio_sound_source_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _audio_sound_source_cast_to_component, URHO3D_CONTEXT HL_URHO3D_SOUND_SOURCE);
DEFINE_PRIM(HL_URHO3D_SOUND_SOURCE, _audio_sound_source_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);
DEFINE_PRIM(_VOID, _audio_sound_source_play, URHO3D_CONTEXT HL_URHO3D_SOUND_SOURCE HL_URHO3D_SOUND);
