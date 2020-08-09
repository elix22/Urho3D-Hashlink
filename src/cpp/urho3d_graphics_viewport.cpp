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

void finalize_urho3d_graphics_viewport(void *v)
{
    hl_urho3d_graphics_viewport *hl_ptr = (hl_urho3d_graphics_viewport *)v;
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

hl_urho3d_graphics_viewport *hl_alloc_urho3d_graphics_viewport(urho3d_context *context,hl_urho3d_scene_scene * scene ,hl_urho3d_graphics_camera * camera)
{

    hl_urho3d_graphics_viewport *p = (hl_urho3d_graphics_viewport *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_viewport));
    memset(p,0,sizeof(hl_urho3d_graphics_viewport));
    p->finalizer = (void *)finalize_urho3d_graphics_viewport;
    p->ptr = new Viewport(context,scene->ptr,camera->ptr);
    return p;
}

hl_urho3d_graphics_viewport *hl_alloc_urho3d_graphics_viewport(urho3d_context *context,hl_urho3d_scene_scene * scene ,hl_urho3d_graphics_camera * camera,hl_urho3d_math_intrect * intRect)
{

    hl_urho3d_graphics_viewport *p = (hl_urho3d_graphics_viewport *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_viewport));
    memset(p,0,sizeof(hl_urho3d_graphics_viewport));
    p->finalizer = (void *)finalize_urho3d_graphics_viewport;
    p->ptr = new Viewport(context,scene->ptr,camera->ptr,*intRect->ptr);
    return p;
}


HL_PRIM hl_urho3d_graphics_viewport *HL_NAME(_graphics_viewport_create)(urho3d_context *context,hl_urho3d_scene_scene * scene ,hl_urho3d_graphics_camera * camera)
{
    return hl_alloc_urho3d_graphics_viewport(context,scene,camera);

}


HL_PRIM hl_urho3d_graphics_viewport *HL_NAME(_graphics_viewport_create_r)(urho3d_context *context,hl_urho3d_scene_scene * scene ,hl_urho3d_graphics_camera * camera,hl_urho3d_math_intrect * intRect)
{
    return hl_alloc_urho3d_graphics_viewport(context,scene,camera,intRect);

}


DEFINE_PRIM(HL_URHO3D_VIEWPORT, _graphics_viewport_create, URHO3D_CONTEXT HL_URHO3D_SCENE HL_URHO3D_CAMERA);
DEFINE_PRIM(HL_URHO3D_VIEWPORT, _graphics_viewport_create_r, URHO3D_CONTEXT HL_URHO3D_SCENE HL_URHO3D_CAMERA HL_URHO3D_INTRECT);