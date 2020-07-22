#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_graphics_camera(void *v)
{
    hl_urho3d_graphics_camera *hl_ptr = (hl_urho3d_graphics_camera *)v;
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

hl_urho3d_graphics_camera *hl_alloc_urho3d_graphics_camera(urho3d_context *context)
{

    hl_urho3d_graphics_camera *p = (hl_urho3d_graphics_camera *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_camera));
    memset(p,0,sizeof(hl_urho3d_graphics_camera));
    p->finalizer = (void *)finalize_urho3d_graphics_camera;
    p->ptr = new Camera(context);
    return p;
}

hl_urho3d_graphics_camera *hl_alloc_urho3d_graphics_camera(Camera *model)
{

    hl_urho3d_graphics_camera *p = (hl_urho3d_graphics_camera *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_camera));
    memset(p,0,sizeof(hl_urho3d_graphics_camera));
    p->finalizer = (void *)finalize_urho3d_graphics_camera;
    p->ptr = model;
    return p;
}

HL_PRIM hl_urho3d_graphics_camera *HL_NAME(_graphics_camera_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_camera(context);

}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_camera_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_camera * t)
{
    return  hl_alloc_urho3d_scene_component(t->ptr);
}


HL_PRIM hl_urho3d_graphics_camera *HL_NAME(_graphics_camera_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component * component)
{
    Component * cmp = component->ptr;
    return  hl_alloc_urho3d_graphics_camera(dynamic_cast<Camera*>(cmp));
}

DEFINE_PRIM(HL_URHO3D_CAMERA, _graphics_camera_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_camera_cast_to_component, URHO3D_CONTEXT HL_URHO3D_CAMERA);
DEFINE_PRIM(HL_URHO3D_CAMERA, _graphics_camera_cast_from_component,URHO3D_CONTEXT HL_URHO3D_COMPONENT );