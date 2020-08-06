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

class ProxyComponent : public Component
{
    URHO3D_OBJECT(ProxyComponent, Component);

    explicit ProxyComponent(Context *context) : Component(context)
    {
    }

    ~ProxyComponent()
    {
    }
};

void finalize_urho3d_scene_component(void *v)
{
    hl_urho3d_scene_component *hl_ptr = (hl_urho3d_scene_component *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
          //   printf("finalize_urho3d_scene_component %d %s \n",hl_ptr->ptr->Refs(), hl_ptr->ptr->GetTypeName().CString());
            
            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_scene_component *hl_alloc_urho3d_scene_component(urho3d_context *context)
{

    hl_urho3d_scene_component *p = (hl_urho3d_scene_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_component));
    memset(p, 0, sizeof(hl_urho3d_scene_component));
    p->finalizer = (void *)finalize_urho3d_scene_component;
    p->ptr = new Component(context);
    return p;
}

hl_urho3d_scene_component *hl_alloc_urho3d_scene_component(Component *component)
{

    hl_urho3d_scene_component *p = (hl_urho3d_scene_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_component));
    memset(p, 0, sizeof(hl_urho3d_scene_component));
    p->finalizer = (void *)finalize_urho3d_scene_component;
    p->ptr = component;
    return p;
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_scene_component_create)(urho3d_context *context)
{
    hl_urho3d_scene_component *v = hl_alloc_urho3d_scene_component(context);
    return v;
}

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_component_get_node)(urho3d_context *context,hl_urho3d_scene_component *component)
{
    return hl_alloc_urho3d_scene_node(context,component->ptr->GetNode());
}

DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_component_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_NODE, _scene_component_get_node, URHO3D_CONTEXT HL_URHO3D_COMPONENT);
