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

void finalize_urho3d_graphics_decalset(void *v)
{
    hl_urho3d_graphics_decalset *hl_ptr = (hl_urho3d_graphics_decalset *)v;
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

hl_urho3d_graphics_decalset *hl_alloc_urho3d_graphics_decalset(urho3d_context *context)
{
    hl_urho3d_graphics_decalset *p = (hl_urho3d_graphics_decalset *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_decalset));
    memset(p, 0, sizeof(hl_urho3d_graphics_decalset));
    p->finalizer = (void *)finalize_urho3d_graphics_decalset;
    p->ptr = new DecalSet(context);
    return p;
}

hl_urho3d_graphics_decalset *hl_alloc_urho3d_graphics_decalset(DecalSet *obj)
{
    hl_urho3d_graphics_decalset *p = (hl_urho3d_graphics_decalset *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_decalset));
    memset(p, 0, sizeof(hl_urho3d_graphics_decalset));
    p->finalizer = (void *)finalize_urho3d_graphics_decalset;
    p->ptr = obj;
    return p;
}

HL_PRIM hl_urho3d_graphics_decalset *HL_NAME(_graphics_decalset_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_decalset(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_decalset_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_decalset *t)
{
    DecalSet *obj = t->ptr;
    if (obj)
    {
        return hl_alloc_urho3d_scene_component(dynamic_cast<Component *>(obj));
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_graphics_decalset *HL_NAME(_graphics_decalset_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    if (cmp)
    {
        return hl_alloc_urho3d_graphics_decalset(dynamic_cast<DecalSet *>(cmp));
    }
    else
    {
        return NULL;
    }
}

HL_PRIM void HL_NAME(_graphics_decalset_set_material)(urho3d_context *context, hl_urho3d_graphics_decalset *obj, hl_urho3d_graphics_material *material)
{
    obj->ptr->SetMaterial(material->ptr);
}

HL_PRIM hl_urho3d_graphics_material *HL_NAME(_graphics_decalset_get_material)(urho3d_context *context, hl_urho3d_graphics_decalset *obj)
{
    return hl_alloc_urho3d_graphics_material(obj->ptr->GetMaterial());
}

HL_PRIM void HL_NAME(_graphics_decalset_add_decal)(urho3d_context *context, hl_urho3d_graphics_decalset *obj, Urho3D::Drawable *target, Urho3D::Vector3 *worldPosition, Urho3D::Quaternion *worldRotation, float size,
                                                   float aspectRatio, float depth, Urho3D::Vector2 *topLeftUV, Urho3D::Vector2 *bottomRightUV, float timeToLive, float normalCutoff, int subGeometry)
{
    obj->ptr->AddDecal(target, *worldPosition, *worldRotation, size, aspectRatio, depth, *topLeftUV, *bottomRightUV, timeToLive, normalCutoff, subGeometry);
}

DEFINE_PRIM(HL_URHO3D_DECALSET, _graphics_decalset_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_decalset_cast_to_component, URHO3D_CONTEXT HL_URHO3D_DECALSET);
DEFINE_PRIM(HL_URHO3D_DECALSET, _graphics_decalset_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);

DEFINE_PRIM(_VOID, _graphics_decalset_set_material, URHO3D_CONTEXT HL_URHO3D_DECALSET HL_URHO3D_MATERIAL);
DEFINE_PRIM(HL_URHO3D_MATERIAL, _graphics_decalset_get_material, URHO3D_CONTEXT HL_URHO3D_DECALSET)

DEFINE_PRIM(_VOID, _graphics_decalset_add_decal, URHO3D_CONTEXT HL_URHO3D_DECALSET HL_URHO3D_DRAWABLE HL_URHO3D_TVECTOR3 HL_URHO3D_TQUATERNION _F32 _F32 _F32 HL_URHO3D_TVECTOR2 HL_URHO3D_TVECTOR2 _F32 _F32 _I32);