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

void finalize_urho3d_urho2d_particle_effect2d(void *v)
{
    hl_urho3d_urho2d_particle_effect2d *hl_ptr = (hl_urho3d_urho2d_particle_effect2d *)v;
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

hl_urho3d_urho2d_particle_effect2d *hl_alloc_urho3d_urho2d_particle_effect2d(urho3d_context *context, const char *name)
{

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

    SharedPtr<Urho3D::ParticleEffect2D> resource(cache->GetResource<ParticleEffect2D>(String(name)));
    if (resource)
    {
        hl_urho3d_urho2d_particle_effect2d *p = (hl_urho3d_urho2d_particle_effect2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_urho2d_particle_effect2d));
        memset(p, 0, sizeof(hl_urho3d_urho2d_particle_effect2d));
        p->finalizer = (void *)finalize_urho3d_urho2d_particle_effect2d;
        p->ptr = resource;
        return p;
    }
    else
    {
        return NULL;
    }
}

hl_urho3d_urho2d_particle_effect2d *hl_alloc_urho3d_urho2d_particle_effect2d(Urho3D::ParticleEffect2D *obj)
{

    hl_urho3d_urho2d_particle_effect2d *p = (hl_urho3d_urho2d_particle_effect2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_urho2d_particle_effect2d));
    memset(p, 0, sizeof(hl_urho3d_urho2d_particle_effect2d));
    p->finalizer = (void *)finalize_urho3d_urho2d_particle_effect2d;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_urho2d_particle_effect2d *HL_NAME(_urho2d_particle_effect2d_create)(urho3d_context *context,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_urho2d_particle_effect2d(context,ch);
}


HL_PRIM const char *HL_NAME(_urho2d_particle_effect2d_get_name)(hl_urho3d_urho2d_particle_effect2d  * hl_obj)
{
    if(hl_obj)
    {
        Urho3D::ParticleEffect2D * urho3d_obj=  hl_obj->ptr;
        if(urho3d_obj)
             return urho3d_obj->GetName().CString();
    }

    return "null";

}

DEFINE_PRIM(HL_URHO3D_PARTICLE_EFFECT_2D, _urho2d_particle_effect2d_create, URHO3D_CONTEXT _STRING);
DEFINE_PRIM(_BYTES, _urho2d_particle_effect2d_get_name, HL_URHO3D_PARTICLE_EFFECT_2D);

