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

// printf("hl_alloc_urho3d_graphics_camera %d \n",__LINE__);
    hl_urho3d_graphics_camera *p = (hl_urho3d_graphics_camera *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_camera));
    memset(p,0,sizeof(hl_urho3d_graphics_camera));
    p->finalizer = (void *)finalize_urho3d_graphics_camera;
    p->ptr = new Camera(context);
    return p;
}

hl_urho3d_graphics_camera *hl_alloc_urho3d_graphics_camera(Camera *model)
{
 //printf("hl_alloc_urho3d_graphics_camera %d \n",__LINE__);
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
    Camera * cam = t->ptr;
    return  hl_alloc_urho3d_scene_component(dynamic_cast<Component*>(cam));
}


HL_PRIM hl_urho3d_graphics_camera *HL_NAME(_graphics_camera_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component * component)
{
    Component * cmp = component->ptr;
    return  hl_alloc_urho3d_graphics_camera(dynamic_cast<Camera*>(cmp));
}

HL_PRIM void HL_NAME(_graphics_camera_set_far_clip)(urho3d_context *context, hl_urho3d_graphics_camera * t , float farclip)
{
    t->ptr->SetFarClip(farclip);
}

HL_PRIM float HL_NAME(_graphics_camera_get_far_clip)(urho3d_context *context, hl_urho3d_graphics_camera * t )
{
    return t->ptr->GetFarClip();
}


HL_PRIM void HL_NAME(_graphics_camera_set_fov)(urho3d_context *context, hl_urho3d_graphics_camera * t , float fov)
{
    t->ptr->SetFov(fov);
}

HL_PRIM float HL_NAME(_graphics_camera_get_fov)(urho3d_context *context, hl_urho3d_graphics_camera * t )
{
    return t->ptr->GetFov();
}

DEFINE_PRIM(HL_URHO3D_CAMERA, _graphics_camera_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_camera_cast_to_component, URHO3D_CONTEXT HL_URHO3D_CAMERA);
DEFINE_PRIM(HL_URHO3D_CAMERA, _graphics_camera_cast_from_component,URHO3D_CONTEXT HL_URHO3D_COMPONENT );

DEFINE_PRIM(_VOID, _graphics_camera_set_far_clip, URHO3D_CONTEXT HL_URHO3D_CAMERA _F32);
DEFINE_PRIM(_F32, _graphics_camera_get_far_clip, URHO3D_CONTEXT HL_URHO3D_CAMERA);

DEFINE_PRIM(_VOID, _graphics_camera_set_fov, URHO3D_CONTEXT HL_URHO3D_CAMERA _F32);
DEFINE_PRIM(_F32, _graphics_camera_get_fov, URHO3D_CONTEXT HL_URHO3D_CAMERA);
