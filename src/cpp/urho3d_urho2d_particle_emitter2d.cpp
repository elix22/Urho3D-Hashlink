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

void finalize_urho3d_urho2d_particle_emitter2d(void *v)
{
    hl_urho3d_urho2d_particle_emitter2d *hl_ptr = (hl_urho3d_urho2d_particle_emitter2d *)v;
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

hl_urho3d_urho2d_particle_emitter2d *hl_alloc_urho3d_urho2d_particle_emitter2d(urho3d_context *context)
{

    hl_urho3d_urho2d_particle_emitter2d *p = (hl_urho3d_urho2d_particle_emitter2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_urho2d_particle_emitter2d));
    memset(p, 0, sizeof(hl_urho3d_urho2d_particle_emitter2d));
    p->finalizer = (void *)finalize_urho3d_urho2d_particle_emitter2d;
    p->ptr = new ParticleEmitter2D(context);
    return p;
}

hl_urho3d_urho2d_particle_emitter2d *hl_alloc_urho3d_urho2d_particle_emitter2d(ParticleEmitter2D *obj)
{

    hl_urho3d_urho2d_particle_emitter2d *p = (hl_urho3d_urho2d_particle_emitter2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_urho2d_particle_emitter2d));
    memset(p, 0, sizeof(hl_urho3d_urho2d_particle_emitter2d));
    p->finalizer = (void *)finalize_urho3d_urho2d_particle_emitter2d;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_urho2d_particle_emitter2d *HL_NAME(_urho2d_particle_emitter2d_create)(urho3d_context *context)
{
    hl_urho3d_urho2d_particle_emitter2d *v = hl_alloc_urho3d_urho2d_particle_emitter2d(context);
    return v;
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_urho2d_particle_emitter2d_cast_to_component)(urho3d_context *context, hl_urho3d_urho2d_particle_emitter2d *obj)
{
    hl_urho3d_scene_component *hl_u3d_obj = hl_alloc_urho3d_scene_component(obj->ptr);
    return hl_u3d_obj;
}

HL_PRIM hl_urho3d_urho2d_particle_emitter2d *HL_NAME(_urho2d_particle_emitter2d_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    hl_urho3d_urho2d_particle_emitter2d *hl_u3d_obj = hl_alloc_urho3d_urho2d_particle_emitter2d(dynamic_cast<ParticleEmitter2D *>(cmp));
    return hl_u3d_obj;
}

//effect
HL_PRIM void HL_NAME(_urho2d_particle_emitter2d_set_effect)(urho3d_context *context, hl_urho3d_urho2d_particle_emitter2d *obj,hl_urho3d_urho2d_particle_effect2d  * effect)
{
   obj->ptr->SetEffect(effect->ptr);
}

HL_PRIM hl_urho3d_urho2d_particle_effect2d  * HL_NAME(_urho2d_particle_emitter2d_get_effect)(urho3d_context *context, hl_urho3d_urho2d_particle_emitter2d *obj)
{
   return hl_alloc_urho3d_urho2d_particle_effect2d(obj->ptr->GetEffect());
}

DEFINE_PRIM(HL_URHO3D_PARTICLE_EMITTER_2D, _urho2d_particle_emitter2d_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _urho2d_particle_emitter2d_cast_to_component, URHO3D_CONTEXT HL_URHO3D_PARTICLE_EMITTER_2D);
DEFINE_PRIM(HL_URHO3D_PARTICLE_EMITTER_2D, _urho2d_particle_emitter2d_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);

DEFINE_PRIM(_VOID, _urho2d_particle_emitter2d_set_effect, URHO3D_CONTEXT HL_URHO3D_PARTICLE_EMITTER_2D HL_URHO3D_PARTICLE_EFFECT_2D);
DEFINE_PRIM(HL_URHO3D_PARTICLE_EFFECT_2D, _urho2d_particle_emitter2d_get_effect, URHO3D_CONTEXT HL_URHO3D_PARTICLE_EMITTER_2D );

