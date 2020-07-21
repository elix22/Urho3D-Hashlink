#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

class ProxyLogicComponent : public LogicComponent
{
    URHO3D_OBJECT(ProxyLogicComponent, LogicComponent);

public:
    ProxyLogicComponent(Context *context) : LogicComponent(context)
    {
        vclosure_start = NULL;
        vclosure_delayed_start = NULL;
        vclosure_stop = NULL;
        vclosure_update = NULL;
        vclosure_post_update = NULL;
        vclosure_fixed_update = NULL;
        vclosure_fixed_post_update = NULL;
    }

    /// Destruct.
    ~ProxyLogicComponent() override
    {
    }

    /// Handle enabled/disabled state change. Changes update event subscription.
    void OnSetEnabled() override
    {
    }

    /// Called when the component is added to a scene node. Other components may not yet exist.
    virtual void Start()
    {
        if (vclosure_start)
            hl_dyn_call(vclosure_start, NULL, 0);
    }

    /// Called before the first update. At this point all other components of the node should exist. Will also be called if update events are not wanted; in that case the event is immediately unsubscribed afterward.
    virtual void DelayedStart()
    {
        if (vclosure_delayed_start)
            hl_dyn_call(vclosure_delayed_start, NULL, 0);
    }

    /// Called when the component is detached from a scene node, usually on destruction. Note that you will no longer have access to the node and scene at that point.
    virtual void Stop()
    {
        if (vclosure_stop)
            hl_dyn_call(vclosure_stop, NULL, 0);
    }

    /// Called on scene update, variable timestep.
    virtual void Update(float timeStep)
    {
        if (vclosure_update)
        {
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};
            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(vclosure_update, vargs, 1);
        }
    }
    /// Called on scene post-update, variable timestep.
    virtual void PostUpdate(float timeStep)
    {
        if (vclosure_post_update)
        {
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};
            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(vclosure_post_update, vargs, 1);
        }
    }
    /// Called on physics update, fixed timestep.
    virtual void FixedUpdate(float timeStep)
    {
        if (vclosure_fixed_update)
        {
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};
            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(vclosure_fixed_update, vargs, 1);
        }
    }
    /// Called on physics post-update, fixed timestep.
    virtual void FixedPostUpdate(float timeStep)
    {
        if (vclosure_fixed_post_update)
        {
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};
            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(vclosure_fixed_post_update, vargs, 1);
        }
    }

    vclosure *vclosure_start;
    vclosure *vclosure_delayed_start;
    vclosure *vclosure_stop;
    vclosure *vclosure_update;
    vclosure *vclosure_post_update;
    vclosure *vclosure_fixed_update;
    vclosure *vclosure_fixed_post_update;
};

void finalize_urho3d_scene_logic_component(void *v)
{
    hl_urho3d_scene_logic_component *hl_ptr = (hl_urho3d_scene_logic_component *)v;
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

hl_urho3d_scene_logic_component *hl_alloc_urho3d_scene_logic_component(urho3d_context *context)
{

    hl_urho3d_scene_logic_component *p = (hl_urho3d_scene_logic_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_logic_component));
    memset(p, 0, sizeof(hl_urho3d_scene_logic_component));
    p->finalizer = (void *)finalize_urho3d_scene_logic_component;
    p->ptr = new ProxyLogicComponent(context);
    return p;
}

hl_urho3d_scene_logic_component *hl_alloc_urho3d_scene_logic_component(LogicComponent *component)
{
    if (component)
    {
        hl_urho3d_scene_logic_component *p = (hl_urho3d_scene_logic_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_logic_component));
        memset(p, 0, sizeof(hl_urho3d_scene_logic_component));
        p->finalizer = (void *)finalize_urho3d_scene_logic_component;
        p->ptr = component;
        return p;
    }
    return NULL;
}

HL_PRIM hl_urho3d_scene_logic_component *HL_NAME(_scene_logic_component_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_scene_logic_component(context);
}

HL_PRIM void HL_NAME(_scene_logic_component_bind_callbacks)(hl_urho3d_scene_logic_component *component, vclosure *vclosure_start,
                                                            vclosure *vclosure_delayed_start,
                                                            vclosure *vclosure_stop,
                                                            vclosure *vclosure_update,
                                                            vclosure *vclosure_post_update,
                                                            vclosure *vclosure_fixed_update,
                                                            vclosure *vclosure_fixed_post_update)
{
    LogicComponent *ptr = component->ptr;

    if (ptr)
    {
        ProxyLogicComponent *proxyLogicComponent = dynamic_cast<ProxyLogicComponent *>(ptr);
        if (proxyLogicComponent != NULL)
        {
            proxyLogicComponent->vclosure_start = vclosure_start;
            proxyLogicComponent->vclosure_delayed_start = vclosure_delayed_start;
            proxyLogicComponent->vclosure_stop = vclosure_stop;
            proxyLogicComponent->vclosure_update = vclosure_update;
            proxyLogicComponent->vclosure_post_update = vclosure_post_update;
            proxyLogicComponent->vclosure_fixed_update = vclosure_fixed_update;
            proxyLogicComponent->vclosure_fixed_post_update = vclosure_fixed_post_update;
        }
    }
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_scene_logic_component_cast_to_component)(urho3d_context *context, hl_urho3d_scene_logic_component *component)
{
    hl_urho3d_scene_component *hl_u3d_obj = hl_alloc_urho3d_scene_component(component->ptr);
    return hl_u3d_obj;
}

HL_PRIM hl_urho3d_scene_logic_component *HL_NAME(_scene_logic_component_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    hl_urho3d_scene_logic_component *hl_u3d_obj = hl_alloc_urho3d_scene_logic_component(dynamic_cast<LogicComponent *>(cmp));
    return hl_u3d_obj;
}

DEFINE_PRIM(HL_URHO3D_LOGIC_COMPONENT, _scene_logic_component_create, URHO3D_CONTEXT);
DEFINE_PRIM(_VOID, _scene_logic_component_bind_callbacks, HL_URHO3D_LOGIC_COMPONENT _FUN(_VOID, _NO_ARG) _FUN(_VOID, _NO_ARG) _FUN(_VOID, _NO_ARG) _FUN(_VOID, _F32) _FUN(_VOID, _F32) _FUN(_VOID, _F32) _FUN(_VOID, _F32));
DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_logic_component_cast_to_component, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT);
DEFINE_PRIM(HL_URHO3D_LOGIC_COMPONENT, _scene_logic_component_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);