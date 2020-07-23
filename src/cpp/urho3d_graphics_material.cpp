#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_graphics_material(void *v)
{
    hl_urho3d_graphics_material *hl_ptr = (hl_urho3d_graphics_material *)v;
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

hl_urho3d_graphics_material *hl_alloc_urho3d_graphics_material(urho3d_context *context, const char *name)
{

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

    SharedPtr<Urho3D::Material> resource(cache->GetResource<Material>(String(name)));
    if (resource)
    {
        hl_urho3d_graphics_material *p = (hl_urho3d_graphics_material *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_material));
        memset(p, 0, sizeof(hl_urho3d_graphics_material));
        p->finalizer = (void *)finalize_urho3d_graphics_material;
        p->ptr = resource;
       // printf("hl_alloc_urho3d_graphics_material success \n");
        return p;
    }
    else
    {
      //  printf("hl_alloc_urho3d_graphics_material = NULL \n");
        return NULL;
    }
}

hl_urho3d_graphics_material *hl_alloc_urho3d_graphics_material(Material *t)
{

    hl_urho3d_graphics_material *p = (hl_urho3d_graphics_material *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_material));
    memset(p, 0, sizeof(hl_urho3d_graphics_material));
    p->finalizer = (void *)finalize_urho3d_graphics_material;
    p->ptr = t;
    return p;
}

HL_PRIM hl_urho3d_graphics_material *HL_NAME(_graphics_material_create)(urho3d_context *context,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_graphics_material(context,ch);
}

DEFINE_PRIM(HL_URHO3D_MATERIAL, _graphics_material_create, URHO3D_CONTEXT _STRING);
