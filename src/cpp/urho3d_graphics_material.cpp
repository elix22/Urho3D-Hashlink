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

hl_urho3d_graphics_material *hl_alloc_urho3d_graphics_material(urho3d_context *context)
{

    hl_urho3d_graphics_material *p = (hl_urho3d_graphics_material *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_material));
    memset(p, 0, sizeof(hl_urho3d_graphics_material));
    p->finalizer = (void *)finalize_urho3d_graphics_material;
    p->ptr = new Urho3D::Material(context);
    return p;
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

HL_PRIM hl_urho3d_graphics_material *HL_NAME(_graphics_material_create)(urho3d_context *context, vstring *str)
{
    const char *ch = (char *)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_graphics_material(context, ch);
}

HL_PRIM hl_urho3d_graphics_material *HL_NAME(_graphics_material_create_empty)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_material(context);
}

HL_PRIM void HL_NAME(_graphics_material_set_technique)(urho3d_context *context, hl_urho3d_graphics_material *hl_material, int index, hl_urho3d_graphics_technique *hl_technique, int qualityLevel, float lodDistance)
{
    hl_material->ptr->SetTechnique(index, hl_technique->ptr, MaterialQuality(qualityLevel), lodDistance);
}

HL_PRIM void HL_NAME(_graphics_material_set_texture)(urho3d_context *context, hl_urho3d_graphics_material *hl_material, int unit, hl_urho3d_graphics_texture *hl_texture)
{
    hl_material->ptr->SetTexture(TextureUnit(unit), hl_texture->ptr);
}

HL_PRIM void HL_NAME(_graphics_material_set_depth_bias)(urho3d_context *context, hl_urho3d_graphics_material *hl_material, hl_urho3d_graphics_light_bias_parameters *p)
{
    hl_material->ptr->SetDepthBias(*(p->ptr));
}

HL_PRIM hl_urho3d_graphics_light_bias_parameters *HL_NAME(_graphics_material_get_depth_bias)(urho3d_context *context, hl_urho3d_graphics_material *hl_material)
{
    return hl_alloc_urho3d_graphics_light_bias_parameters(hl_material->ptr->GetDepthBias());
}

DEFINE_PRIM(HL_URHO3D_MATERIAL, _graphics_material_create, URHO3D_CONTEXT _STRING);
DEFINE_PRIM(HL_URHO3D_MATERIAL, _graphics_material_create_empty, URHO3D_CONTEXT);
DEFINE_PRIM(_VOID, _graphics_material_set_technique, URHO3D_CONTEXT HL_URHO3D_MATERIAL _I32 HL_URHO3D_TECHNIQUE _I32 _F32);
DEFINE_PRIM(_VOID, _graphics_material_set_texture, URHO3D_CONTEXT HL_URHO3D_MATERIAL _I32 HL_URHO3D_TEXTURE);

DEFINE_PRIM(_VOID, _graphics_material_set_depth_bias, URHO3D_CONTEXT HL_URHO3D_MATERIAL HL_URHO3D_LIGHT_BIAS_PARAMETERS);
DEFINE_PRIM(HL_URHO3D_LIGHT_BIAS_PARAMETERS, _graphics_material_get_depth_bias, URHO3D_CONTEXT HL_URHO3D_MATERIAL);
