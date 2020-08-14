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


void finalize_urho3d_graphics_light_bias_parameters(void *v)
{
    hl_urho3d_graphics_light_bias_parameters *hl_ptr = (hl_urho3d_graphics_light_bias_parameters *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            delete(hl_ptr->ptr);
        }
        hl_ptr->finalizer = NULL;
    }
}


void finalize_urho3d_graphics_light_cascade_parameters(void *v)
{
    hl_urho3d_graphics_light_cascade_parameters *hl_ptr = (hl_urho3d_graphics_light_cascade_parameters *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            delete(hl_ptr->ptr);
        }
        hl_ptr->finalizer = NULL;
    }
}

void finalize_urho3d_graphics_light(void *v)
{
    hl_urho3d_graphics_light *hl_ptr = (hl_urho3d_graphics_light *)v;
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



hl_urho3d_graphics_light_bias_parameters *hl_alloc_urho3d_graphics_light_bias_parameters(float constantBias, float slopeScaledBias, float normalOffset )
{
    hl_urho3d_graphics_light_bias_parameters *p = (hl_urho3d_graphics_light_bias_parameters *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_light_bias_parameters));

    p->finalizer = (void *)finalize_urho3d_graphics_light_bias_parameters;
    p->ptr = new Urho3D::BiasParameters(constantBias, slopeScaledBias,normalOffset);
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_graphics_light_bias_parameters *hl_alloc_urho3d_graphics_light_bias_parameters(const Urho3D::BiasParameters & rhs )
{
    hl_urho3d_graphics_light_bias_parameters *p = (hl_urho3d_graphics_light_bias_parameters *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_light_bias_parameters));

    p->finalizer = (void *)finalize_urho3d_graphics_light_bias_parameters;
    p->ptr = new Urho3D::BiasParameters(rhs);
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_graphics_light_cascade_parameters *hl_alloc_urho3d_graphics_light_cascade_parameters(float split1, float split2, float split3, float split4, float fadeStart, float biasAutoAdjust )
{
    hl_urho3d_graphics_light_cascade_parameters *p = (hl_urho3d_graphics_light_cascade_parameters *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_light_cascade_parameters));

    p->finalizer = (void *)finalize_urho3d_graphics_light_cascade_parameters;
    p->ptr = new Urho3D::CascadeParameters(split1,split2,split3,split4,fadeStart,biasAutoAdjust);
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_graphics_light_cascade_parameters *hl_alloc_urho3d_graphics_light_cascade_parameters(const CascadeParameters & rhs)
{
    hl_urho3d_graphics_light_cascade_parameters *p = (hl_urho3d_graphics_light_cascade_parameters *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_light_cascade_parameters));

    p->finalizer = (void *)finalize_urho3d_graphics_light_cascade_parameters;
    p->ptr = new Urho3D::CascadeParameters(rhs);
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_graphics_light *hl_alloc_urho3d_graphics_light(urho3d_context *context)
{

    hl_urho3d_graphics_light *p = (hl_urho3d_graphics_light *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_light));
    memset(p, 0, sizeof(hl_urho3d_graphics_light));
    p->finalizer = (void *)finalize_urho3d_graphics_light;
    p->ptr = new Light(context);
    return p;
}

hl_urho3d_graphics_light *hl_alloc_urho3d_graphics_light(Light *t)
{

    hl_urho3d_graphics_light *p = (hl_urho3d_graphics_light *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_light));
    memset(p, 0, sizeof(hl_urho3d_graphics_light));
    p->finalizer = (void *)finalize_urho3d_graphics_light;
    p->ptr = t;
    return p;
}

HL_PRIM hl_urho3d_graphics_light *HL_NAME(_graphics_light_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_light(context);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_light_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return hl_alloc_urho3d_scene_component(t->ptr);
}

HL_PRIM hl_urho3d_graphics_light *HL_NAME(_graphics_light_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    return hl_alloc_urho3d_graphics_light(dynamic_cast<Light *>(cmp));
}

HL_PRIM void HL_NAME(_graphics_light_set_light_type)(urho3d_context *context, hl_urho3d_graphics_light *t, int type)
{
    t->ptr->SetLightType((LightType)type);
}

HL_PRIM int HL_NAME(_graphics_light_get_light_type)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetLightType();
}

HL_PRIM void HL_NAME(_graphics_light_set_range)(urho3d_context *context, hl_urho3d_graphics_light *t, float range)
{
    t->ptr->SetRange(range);
}

HL_PRIM float HL_NAME(_graphics_light_get_range)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetRange();
}

HL_PRIM void HL_NAME(_graphics_light_set_color)(urho3d_context * context,hl_urho3d_graphics_light *t,hl_urho3d_color * color)
{
    t->ptr->SetColor(*(color->ptr));
}

HL_PRIM hl_urho3d_color *HL_NAME(_graphics_light_get_color)(urho3d_context * context,hl_urho3d_graphics_light *t)
{
    return hl_alloc_urho3d_color( t->ptr->GetColor());
}


HL_PRIM void HL_NAME(_graphics_light_set_cast_shadows)(urho3d_context * context,hl_urho3d_graphics_light *t,bool cast)
{
    t->ptr->SetCastShadows(cast);
}
HL_PRIM bool  HL_NAME(_graphics_light_get_cast_shadows)(urho3d_context * context,hl_urho3d_graphics_light *t)
{
    return t->ptr->GetCastShadows();
}

HL_PRIM  hl_urho3d_graphics_light_bias_parameters * HL_NAME(_graphics_light_bias_parameters_create)(float constantBias, float slopeScaledBias, float normalOffset)
{
    return hl_alloc_urho3d_graphics_light_bias_parameters(constantBias,slopeScaledBias,normalOffset);
}

HL_PRIM  hl_urho3d_graphics_light_cascade_parameters * HL_NAME(_graphics_light_cascade_parameters_create)(float split1, float split2, float split3, float split4, float fadeStart, float biasAutoAdjust)
{
    return hl_alloc_urho3d_graphics_light_cascade_parameters(split1,split2,split3,split4,fadeStart,biasAutoAdjust);
}

HL_PRIM void HL_NAME(_graphics_light_set_shadow_bias)(urho3d_context * context,hl_urho3d_graphics_light *t,hl_urho3d_graphics_light_bias_parameters *p)
{
    t->ptr->SetShadowBias(*(p->ptr));
}

HL_PRIM hl_urho3d_graphics_light_bias_parameters * HL_NAME(_graphics_light_get_shadow_bias)(urho3d_context * context,hl_urho3d_graphics_light *t)
{
    return hl_alloc_urho3d_graphics_light_bias_parameters(t->ptr->GetShadowBias());
}

HL_PRIM void HL_NAME(_graphics_light_set_shadow_cascade)(urho3d_context * context,hl_urho3d_graphics_light *t,hl_urho3d_graphics_light_cascade_parameters *p)
{
    t->ptr->SetShadowCascade(*(p->ptr));
}

HL_PRIM hl_urho3d_graphics_light_cascade_parameters * HL_NAME(_graphics_light_get_shadow_cascade)(urho3d_context * context,hl_urho3d_graphics_light *t)
{
    return hl_alloc_urho3d_graphics_light_cascade_parameters(t->ptr->GetShadowCascade());
}



HL_PRIM void HL_NAME(_graphics_light_set_specular_intensity)(urho3d_context *context, hl_urho3d_graphics_light *t, float intensity)
{
    t->ptr->SetSpecularIntensity(intensity);
}

HL_PRIM float HL_NAME(_graphics_light_get_specular_intensity)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetSpecularIntensity();
}


HL_PRIM void HL_NAME(_graphics_light_set_ramp_texture)(urho3d_context *context, hl_urho3d_graphics_light *l,hl_urho3d_graphics_texture  * t)
{
    l->ptr->SetRampTexture(t->ptr);
}

HL_PRIM hl_urho3d_graphics_texture * HL_NAME(_graphics_light_get_ramp_texture)(urho3d_context *context, hl_urho3d_graphics_light *l)
{
    return hl_alloc_urho3d_graphics_texture(l->ptr->GetRampTexture());
}

///////////////////

HL_PRIM void HL_NAME(_graphics_light_set_fov)(urho3d_context *context, hl_urho3d_graphics_light *t, float f)
{
    t->ptr->SetFov(f);
}

HL_PRIM float HL_NAME(_graphics_light_get_fov)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetFov();
}

HL_PRIM void HL_NAME(_graphics_light_set_shadow_fade_distance)(urho3d_context *context, hl_urho3d_graphics_light *t, float f)
{
    t->ptr->SetShadowFadeDistance(f);
}

HL_PRIM float HL_NAME(_graphics_light_get_shadow_fade_distance)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetShadowFadeDistance();
}

HL_PRIM void HL_NAME(_graphics_light_set_shadow_distance)(urho3d_context *context, hl_urho3d_graphics_light *t, float f)
{
    t->ptr->SetShadowDistance(f);
}

HL_PRIM float HL_NAME(_graphics_light_get_shadow_distance)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetShadowDistance();
}

HL_PRIM void HL_NAME(_graphics_light_set_shadow_resolution)(urho3d_context *context, hl_urho3d_graphics_light *t, float f)
{
    t->ptr->SetShadowResolution(f);
}

HL_PRIM float HL_NAME(_graphics_light_get_shadow_resolution)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetShadowResolution();
}

HL_PRIM void HL_NAME(_graphics_light_set_shadow_near_far_ratio)(urho3d_context *context, hl_urho3d_graphics_light *t, float f)
{
    t->ptr->SetShadowNearFarRatio(f);
}

HL_PRIM float HL_NAME(_graphics_light_get_shadow_near_far_ratio)(urho3d_context *context, hl_urho3d_graphics_light *t)
{
    return t->ptr->GetShadowNearFarRatio();
}



DEFINE_PRIM(HL_URHO3D_LIGHT, _graphics_light_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_light_cast_to_component, URHO3D_CONTEXT HL_URHO3D_LIGHT);
DEFINE_PRIM(HL_URHO3D_LIGHT, _graphics_light_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);


DEFINE_PRIM(_VOID, _graphics_light_set_light_type, URHO3D_CONTEXT HL_URHO3D_LIGHT _I32);
DEFINE_PRIM(_I32, _graphics_light_get_light_type, URHO3D_CONTEXT HL_URHO3D_LIGHT );

DEFINE_PRIM(_VOID, _graphics_light_set_range, URHO3D_CONTEXT HL_URHO3D_LIGHT _F32);
DEFINE_PRIM(_F32, _graphics_light_get_range, URHO3D_CONTEXT HL_URHO3D_LIGHT );


DEFINE_PRIM(_VOID, _graphics_light_set_color,URHO3D_CONTEXT HL_URHO3D_LIGHT HL_URHO3D_COLOR);
DEFINE_PRIM(HL_URHO3D_COLOR, _graphics_light_get_color,URHO3D_CONTEXT HL_URHO3D_LIGHT );

DEFINE_PRIM(_VOID, _graphics_light_set_cast_shadows,URHO3D_CONTEXT HL_URHO3D_LIGHT _BOOL);
DEFINE_PRIM(_BOOL, _graphics_light_get_cast_shadows,URHO3D_CONTEXT HL_URHO3D_LIGHT);

DEFINE_PRIM(HL_URHO3D_LIGHT_BIAS_PARAMETERS, _graphics_light_bias_parameters_create, _F32 _F32 _F32);
DEFINE_PRIM(HL_URHO3D_LIGHT_CASCADE_PARAMETERS, _graphics_light_cascade_parameters_create, _F32 _F32 _F32 _F32 _F32 _F32);

DEFINE_PRIM(_VOID, _graphics_light_set_shadow_bias,URHO3D_CONTEXT HL_URHO3D_LIGHT HL_URHO3D_LIGHT_BIAS_PARAMETERS);
DEFINE_PRIM(HL_URHO3D_LIGHT_BIAS_PARAMETERS, _graphics_light_get_shadow_bias,URHO3D_CONTEXT HL_URHO3D_LIGHT);

DEFINE_PRIM(_VOID, _graphics_light_set_shadow_cascade,URHO3D_CONTEXT HL_URHO3D_LIGHT HL_URHO3D_LIGHT_CASCADE_PARAMETERS);
DEFINE_PRIM(HL_URHO3D_LIGHT_CASCADE_PARAMETERS, _graphics_light_get_shadow_cascade,URHO3D_CONTEXT HL_URHO3D_LIGHT);

DEFINE_PRIM(_VOID, _graphics_light_set_specular_intensity, URHO3D_CONTEXT HL_URHO3D_LIGHT _F32);
DEFINE_PRIM(_F32, _graphics_light_get_specular_intensity, URHO3D_CONTEXT HL_URHO3D_LIGHT );

DEFINE_PRIM(_VOID, _graphics_light_set_ramp_texture, URHO3D_CONTEXT HL_URHO3D_LIGHT HL_URHO3D_TEXTURE);
DEFINE_PRIM(HL_URHO3D_TEXTURE, _graphics_light_get_ramp_texture, URHO3D_CONTEXT HL_URHO3D_LIGHT);


DEFINE_PRIM(_VOID, _graphics_light_set_fov, URHO3D_CONTEXT HL_URHO3D_LIGHT _F32);
DEFINE_PRIM(_F32, _graphics_light_get_fov, URHO3D_CONTEXT HL_URHO3D_LIGHT );

DEFINE_PRIM(_VOID,_graphics_light_set_shadow_fade_distance , URHO3D_CONTEXT HL_URHO3D_LIGHT _F32);
DEFINE_PRIM(_F32, _graphics_light_get_shadow_fade_distance, URHO3D_CONTEXT HL_URHO3D_LIGHT );

DEFINE_PRIM(_VOID,_graphics_light_set_shadow_distance , URHO3D_CONTEXT HL_URHO3D_LIGHT _F32);
DEFINE_PRIM(_F32, _graphics_light_get_shadow_distance, URHO3D_CONTEXT HL_URHO3D_LIGHT );

DEFINE_PRIM(_VOID,_graphics_light_set_shadow_resolution , URHO3D_CONTEXT HL_URHO3D_LIGHT _F32);
DEFINE_PRIM(_F32, _graphics_light_get_shadow_resolution, URHO3D_CONTEXT HL_URHO3D_LIGHT );

DEFINE_PRIM(_VOID, _graphics_light_set_shadow_near_far_ratio, URHO3D_CONTEXT HL_URHO3D_LIGHT _F32);
DEFINE_PRIM(_F32, _graphics_light_get_shadow_near_far_ratio, URHO3D_CONTEXT HL_URHO3D_LIGHT );
