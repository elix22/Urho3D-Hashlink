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

void finalize_urho3d_graphics_staticmodel(void *v)
{
    hl_urho3d_graphics_staticmodel *hl_ptr = (hl_urho3d_graphics_staticmodel *)v;
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

hl_urho3d_graphics_staticmodel *hl_alloc_urho3d_graphics_staticmodel(urho3d_context *context)
{

    hl_urho3d_graphics_staticmodel *p = (hl_urho3d_graphics_staticmodel *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_staticmodel));
    memset(p, 0, sizeof(hl_urho3d_graphics_staticmodel));
    p->finalizer = (void *)finalize_urho3d_graphics_staticmodel;
    p->ptr = new StaticModel(context);
    return p;
}

hl_urho3d_graphics_staticmodel *hl_alloc_urho3d_graphics_staticmodel(StaticModel *model)
{

    hl_urho3d_graphics_staticmodel *p = (hl_urho3d_graphics_staticmodel *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_staticmodel));
    memset(p, 0, sizeof(hl_urho3d_graphics_staticmodel));
    p->finalizer = (void *)finalize_urho3d_graphics_staticmodel;
    p->ptr = model;
    return p;
}

HL_PRIM hl_urho3d_graphics_staticmodel *HL_NAME(_graphics_staticmodel_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_staticmodel(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_staticmodel_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_staticmodel *t)
{
    return hl_alloc_urho3d_scene_component(t->ptr);
}

HL_PRIM hl_urho3d_graphics_staticmodel *HL_NAME(_graphics_staticmodel_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return hl_alloc_urho3d_graphics_staticmodel(dynamic_cast<StaticModel *>(cmp));
}

HL_PRIM void HL_NAME(_graphics_staticmodel_set_model)(urho3d_context *context, hl_urho3d_graphics_staticmodel *staticmodel, hl_urho3d_graphics_model *model)
{
    staticmodel->ptr->SetModel(model->ptr);
}

HL_PRIM hl_urho3d_graphics_model *HL_NAME(_graphics_staticmodel_get_model)(urho3d_context *context, hl_urho3d_graphics_staticmodel *staticmodel)
{
    return hl_alloc_urho3d_graphics_model(staticmodel->ptr->GetModel());
}

HL_PRIM void HL_NAME(_graphics_staticmodel_set_material)(urho3d_context *context, hl_urho3d_graphics_staticmodel *staticmodel, hl_urho3d_graphics_material *material)
{
    staticmodel->ptr->SetMaterial(material->ptr);
}

HL_PRIM hl_urho3d_graphics_material *HL_NAME(_graphics_staticmodel_get_material)(urho3d_context *context, hl_urho3d_graphics_staticmodel *staticmodel)
{
    return hl_alloc_urho3d_graphics_material(staticmodel->ptr->GetMaterial());
}

HL_PRIM void HL_NAME(_graphics_staticmodel_set_cast_shadows)(urho3d_context *context, hl_urho3d_graphics_staticmodel *staticmodel, bool cast)
{
    staticmodel->ptr->SetCastShadows(cast);
}

HL_PRIM bool HL_NAME(_graphics_staticmodel_get_cast_shadows)(urho3d_context *context, hl_urho3d_graphics_staticmodel *staticmodel)
{
    return staticmodel->ptr->GetCastShadows();
}

DEFINE_PRIM(HL_URHO3D_STATICMODEL, _graphics_staticmodel_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_staticmodel_cast_to_component, URHO3D_CONTEXT HL_URHO3D_STATICMODEL);
DEFINE_PRIM(HL_URHO3D_STATICMODEL, _graphics_staticmodel_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);
DEFINE_PRIM(_VOID, _graphics_staticmodel_set_model, URHO3D_CONTEXT HL_URHO3D_STATICMODEL HL_URHO3D_MODEL);
DEFINE_PRIM(HL_URHO3D_MODEL, _graphics_staticmodel_get_model, URHO3D_CONTEXT HL_URHO3D_STATICMODEL);
DEFINE_PRIM(_VOID, _graphics_staticmodel_set_material, URHO3D_CONTEXT HL_URHO3D_STATICMODEL HL_URHO3D_MATERIAL);
DEFINE_PRIM(HL_URHO3D_MATERIAL, _graphics_staticmodel_get_material, URHO3D_CONTEXT HL_URHO3D_STATICMODEL);
DEFINE_PRIM(_VOID, _graphics_staticmodel_set_cast_shadows, URHO3D_CONTEXT HL_URHO3D_STATICMODEL _BOOL);
DEFINE_PRIM(_BOOL, _graphics_staticmodel_get_cast_shadows, URHO3D_CONTEXT HL_URHO3D_STATICMODEL);
