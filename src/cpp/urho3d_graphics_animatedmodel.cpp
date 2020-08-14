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

void finalize_urho3d_graphics_animatedmodel(void *v)
{
    hl_urho3d_graphics_animatedmodel *hl_ptr = (hl_urho3d_graphics_animatedmodel *)v;
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

hl_urho3d_graphics_animatedmodel *hl_alloc_urho3d_graphics_animatedmodel(urho3d_context *context)
{

    hl_urho3d_graphics_animatedmodel *p = (hl_urho3d_graphics_animatedmodel *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_animatedmodel));
    memset(p, 0, sizeof(hl_urho3d_graphics_animatedmodel));
    p->finalizer = (void *)finalize_urho3d_graphics_animatedmodel;
    p->ptr = new Urho3D::AnimatedModel(context);
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_graphics_animatedmodel *hl_alloc_urho3d_graphics_animatedmodel(Urho3D::AnimatedModel *model)
{

    hl_urho3d_graphics_animatedmodel *p = (hl_urho3d_graphics_animatedmodel *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_animatedmodel));
    memset(p, 0, sizeof(hl_urho3d_graphics_animatedmodel));
    p->finalizer = (void *)finalize_urho3d_graphics_animatedmodel;
    p->ptr = model;
    p->dyn_obj = NULL;
    return p;
}

HL_PRIM hl_urho3d_graphics_animatedmodel *HL_NAME(_graphics_animatedmodel_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_animatedmodel(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_animatedmodel_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *t)
{
    return hl_alloc_urho3d_scene_component(t->ptr);
}

HL_PRIM hl_urho3d_graphics_animatedmodel *HL_NAME(_graphics_animatedmodel_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return hl_alloc_urho3d_graphics_animatedmodel(dynamic_cast<Urho3D::AnimatedModel *>(cmp));
}

HL_PRIM void HL_NAME(_graphics_animatedmodel_set_model)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel, hl_urho3d_graphics_model *model)
{
    animatedmodel->ptr->SetModel(model->ptr);
}

HL_PRIM hl_urho3d_graphics_model *HL_NAME(_graphics_animatedmodel_get_model)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel)
{
    return hl_alloc_urho3d_graphics_model(animatedmodel->ptr->GetModel());
}

HL_PRIM void HL_NAME(_graphics_animatedmodel_set_material)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel, hl_urho3d_graphics_material *material)
{
    animatedmodel->ptr->SetMaterial(material->ptr);
}

HL_PRIM hl_urho3d_graphics_material *HL_NAME(_graphics_animatedmodel_get_material)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel)
{
    return hl_alloc_urho3d_graphics_material(animatedmodel->ptr->GetMaterial());
}

HL_PRIM hl_urho3d_graphics_tanimation_state HL_NAME(_graphics_animatedmodel_add_animation_state)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel, hl_urho3d_graphics_animation *animation)
{
    return animatedmodel->ptr->AddAnimationState(animation->ptr);
   // return state;
    //return hl_alloc_urho3d_graphics_animation_state(state);
}

HL_PRIM hl_urho3d_graphics_tanimation_state HL_NAME(_graphics_animatedmodel_get_animation_state)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel, int index)
{
    return animatedmodel->ptr->GetAnimationState(index);
    //return hl_alloc_urho3d_graphics_animation_state(state);
}

HL_PRIM void HL_NAME(_graphics_animatedmodel_set_cast_shadows)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel, bool cast)
{
     animatedmodel->ptr->SetCastShadows(cast);

}

HL_PRIM bool HL_NAME(_graphics_animatedmodel_get_cast_shadows)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel)
{
     return animatedmodel->ptr->GetCastShadows();
}

HL_PRIM void HL_NAME(_graphics_animatedmodel_set_occluder)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel, bool occluder)
{
    animatedmodel->ptr->SetOccluder(occluder);

}

HL_PRIM bool HL_NAME(_graphics_animatedmodel_get_occluder)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel)
{
    return animatedmodel->ptr->IsOccluder();
}

HL_PRIM void HL_NAME(_graphics_animatedmodel_set_occludee)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel, bool occludee)
{
    animatedmodel->ptr->SetOccludee(occludee);

}

HL_PRIM bool HL_NAME(_graphics_animatedmodel_get_occludee)(urho3d_context *context, hl_urho3d_graphics_animatedmodel *animatedmodel)
{
    return animatedmodel->ptr->IsOccludee();
}


DEFINE_PRIM(HL_URHO3D_ANIMATEDMODEL, _graphics_animatedmodel_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_animatedmodel_cast_to_component, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL);
DEFINE_PRIM(HL_URHO3D_ANIMATEDMODEL, _graphics_animatedmodel_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);
DEFINE_PRIM(_VOID, _graphics_animatedmodel_set_model, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL HL_URHO3D_MODEL);
DEFINE_PRIM(HL_URHO3D_MODEL, _graphics_animatedmodel_get_model, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL);
DEFINE_PRIM(_VOID, _graphics_animatedmodel_set_material, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL HL_URHO3D_MATERIAL);
DEFINE_PRIM(HL_URHO3D_MATERIAL, _graphics_animatedmodel_get_material, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL);
DEFINE_PRIM(HL_URHO3D_TANIMATION_STATE, _graphics_animatedmodel_add_animation_state, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL HL_URHO3D_ANIMATION);
DEFINE_PRIM(HL_URHO3D_TANIMATION_STATE, _graphics_animatedmodel_get_animation_state, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL _I32);
DEFINE_PRIM(_VOID, _graphics_animatedmodel_set_cast_shadows, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL _BOOL);
DEFINE_PRIM(_BOOL, _graphics_animatedmodel_get_cast_shadows, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL );
DEFINE_PRIM(_VOID, _graphics_animatedmodel_set_occluder, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL _BOOL);
DEFINE_PRIM(_BOOL, _graphics_animatedmodel_get_occluder, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL );
DEFINE_PRIM(_VOID, _graphics_animatedmodel_set_occludee, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL _BOOL);
DEFINE_PRIM(_BOOL, _graphics_animatedmodel_get_occludee, URHO3D_CONTEXT HL_URHO3D_ANIMATEDMODEL );
