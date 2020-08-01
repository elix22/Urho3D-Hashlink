#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

static int hl_hash_start = 0;
static int hl_hash_delayed_start = 0;
static int hl_hash_stop = 0;
static int hl_hash_update = 0;
static int hl_hash_post_update = 0;
static int hl_hash_fixed_update = 0;
static int hl_hash_fixed_post_update = 0;

// very fast function
void *hl_dyn_getp_internal(vdynamic *d, hl_field_lookup **f, int hfield, vclosure *c = NULL);

class ProxyLogicComponent : public LogicComponent
{
    URHO3D_OBJECT(ProxyLogicComponent, LogicComponent);

public:
    ProxyLogicComponent(Context *context) : LogicComponent(context)
    {
        dyn_obj = NULL;
        dyn_obj_field_start = NULL;
        dyn_obj_field_delayed_start = NULL;
        dyn_obj_field_stop = NULL;
        dyn_obj_field_update = NULL;
        dyn_obj_field_post_update = NULL;
        dyn_obj_field_fixed_update = NULL;
        dyn_obj_field_fixed_post_update = NULL;
        if (hl_hash_start == 0)
            hl_hash_start = hl_hash_utf8("Start");
        if (hl_hash_delayed_start == 0)
            hl_hash_delayed_start = hl_hash_utf8("DelayedStart");
        if (hl_hash_stop == 0)
            hl_hash_stop = hl_hash_utf8("Stop");
        if (hl_hash_update == 0)
            hl_hash_update = hl_hash_utf8("Update");
        if (hl_hash_post_update == 0)
            hl_hash_post_update = hl_hash_utf8("PostUpdate");
        if (hl_hash_fixed_update == 0)
            hl_hash_fixed_update = hl_hash_utf8("FixedUpdate");
        if (hl_hash_fixed_post_update == 0)
            hl_hash_fixed_post_update = hl_hash_utf8("FixedPostUpdate");
    }

    /// Destruct.
    ~ProxyLogicComponent() override
    {
        //printf("~ProxyLogicComponent \n");
        if (dyn_obj)
        {

            hl_remove_root(&dyn_obj);
            dyn_obj = NULL;
        }
    }

    /// Handle enabled/disabled state change. Changes update event subscription.
    void OnSetEnabled() override
    {
    }

    /// Called when the component is added to a scene node. Other components may not yet exist.
    virtual void Start()
    {

        if (dyn_obj)
        {

            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_start, &hlt_dyn);
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_start, hl_hash_start, &closure);
            ((void (*)(vdynamic *))closure.fun)((vdynamic *)closure.value);
            // hl_dyn_call(&closure, NULL, 0);

            /*
            hl_field_lookup *hl_lookup = obj_resolve_field(dyn_obj->t->obj, hl_hash_utf8("Start"));
            if (hl_lookup)
            {
                void *args[1];
                hl_dyn_call_obj(dyn_obj, hl_lookup->t, hl_lookup->hashed_name, args, NULL);
            }
            */
        }
    }

    /// Called before the first update. At this point all other components of the node should exist. Will also be called if update events are not wanted; in that case the event is immediately unsubscribed afterward.
    virtual void DelayedStart()
    {
        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_delayed_start, &hlt_dyn);
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_delayed_start, hl_hash_delayed_start, &closure);
            ((void (*)(vdynamic *))closure.fun)((vdynamic *)closure.value);
            // hl_dyn_call(&closure, NULL, 0);
        }
    }

    /// Called when the component is detached from a scene node, usually on destruction. Note that you will no longer have access to the node and scene at that point.
    virtual void Stop()
    {
        dyn_obj = NULL;

       // if (dyn_obj)
       // {
            // printf("ProxyLogicComponent.Stop \n");
       //     vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_stop, &hlt_dyn);
            // vclosure closure;
            // hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_stop, hl_hash_stop, &closure);
            // ((void (*)(vdynamic*))closure.fun)((vdynamic*)closure.value);
           // if (closure != NULL)
           //     hl_dyn_call(closure, NULL, 0);

            // hl_remove_root(&dyn_obj);
        //     dyn_obj = NULL;
       // }
    }

    /// Called on scene update, variable timestep.
    virtual void Update(float timeStep)
    {

        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_update, &hlt_dyn);
            /*faster way , caching the field*/
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_update, hl_hash_update, &closure);
            ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
            /*
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};
            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(&closure, vargs, 1);
            */
        }
    }
    /// Called on scene post-update, variable timestep.
    virtual void PostUpdate(float timeStep)
    {
        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_post_update, &hlt_dyn);

            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_post_update, hl_hash_post_update, &closure);
            ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
            /*
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};

            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(&closure, vargs, 1);
            */
        }
    }
    /// Called on physics update, fixed timestep.
    virtual void FixedUpdate(float timeStep)
    {
        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_fixed_update, &hlt_dyn);
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_fixed_update, hl_hash_fixed_update, &closure);
            ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
            /*
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};

            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(&closure, vargs, 1);
            */
        }
    }
    /// Called on physics post-update, fixed timestep.
    virtual void FixedPostUpdate(float timeStep)
    {
        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_fixed_post_update, &hlt_dyn);
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_fixed_post_update, hl_hash_fixed_post_update, &closure);
            ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
            /*
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};

            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(&closure, vargs, 1);
            */
        }
    }

    vdynamic *dyn_obj;
    hl_field_lookup *dyn_obj_field_start;
    hl_field_lookup *dyn_obj_field_delayed_start;
    hl_field_lookup *dyn_obj_field_stop;
    hl_field_lookup *dyn_obj_field_update;
    hl_field_lookup *dyn_obj_field_post_update;
    hl_field_lookup *dyn_obj_field_fixed_update;
    hl_field_lookup *dyn_obj_field_fixed_post_update;
};

void finalize_urho3d_scene_logic_component(void *v)
{
    // printf("finalize_urho3d_scene_logic_component \n");
    hl_urho3d_scene_logic_component *hl_ptr = (hl_urho3d_scene_logic_component *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

//

hl_urho3d_scene_logic_component *hl_alloc_urho3d_scene_logic_component(urho3d_context *context, vdynamic *dyn_obj)
{

    hl_urho3d_scene_logic_component *p = (hl_urho3d_scene_logic_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_logic_component));
    memset(p, 0, sizeof(hl_urho3d_scene_logic_component));
    p->finalizer = (void *)finalize_urho3d_scene_logic_component;
    ProxyLogicComponent *c = new ProxyLogicComponent(context);
    c->dyn_obj = dyn_obj;
   // hl_add_root(&dyn_obj);
    p->ptr = c;
    return p;
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

HL_PRIM hl_urho3d_scene_logic_component *HL_NAME(_scene_logic_component_create)(urho3d_context *context, vdynamic *dyn_obj)
{
    return hl_alloc_urho3d_scene_logic_component(context, dyn_obj);
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

DEFINE_PRIM(HL_URHO3D_LOGIC_COMPONENT, _scene_logic_component_create, URHO3D_CONTEXT _DYN);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_logic_component_cast_to_component, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT);
DEFINE_PRIM(HL_URHO3D_LOGIC_COMPONENT, _scene_logic_component_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);