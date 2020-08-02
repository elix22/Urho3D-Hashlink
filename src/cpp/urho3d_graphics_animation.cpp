#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_graphics_animation(void *v)
{
    hl_urho3d_graphics_animation *hl_ptr = (hl_urho3d_graphics_animation *)v;
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

hl_urho3d_graphics_animation *hl_alloc_urho3d_graphics_animation(urho3d_context *context, const char *name)
{

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

    SharedPtr<Urho3D::Animation> resource(cache->GetResource<Animation>(String(name)));
    if (resource)
    {
        hl_urho3d_graphics_animation *p = (hl_urho3d_graphics_animation *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_animation));
        memset(p, 0, sizeof(hl_urho3d_graphics_animation));
        p->finalizer = (void *)finalize_urho3d_graphics_animation;
        p->ptr = resource;
       // printf("hl_alloc_urho3d_graphics_animation success \n");
        return p;
    }
    else
    {
      //  printf("hl_alloc_urho3d_graphics_animation = NULL \n");
        return NULL;
    }
}

hl_urho3d_graphics_animation *hl_alloc_urho3d_graphics_animation(Animation *animation)
{

    hl_urho3d_graphics_animation *p = (hl_urho3d_graphics_animation *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_animation));
    memset(p, 0, sizeof(hl_urho3d_graphics_animation));
    p->finalizer = (void *)finalize_urho3d_graphics_animation;
    p->ptr = animation;
    return p;
}

HL_PRIM hl_urho3d_graphics_animation *HL_NAME(_graphics_animation_create)(urho3d_context *context,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_graphics_animation(context,ch);
}


HL_PRIM float HL_NAME(_graphics_animation_get_length)(urho3d_context *context,hl_urho3d_graphics_animation * animation)
{
  return animation->ptr->GetLength();
}

DEFINE_PRIM(HL_URHO3D_ANIMATION, _graphics_animation_create, URHO3D_CONTEXT _STRING);
DEFINE_PRIM(_F32, _graphics_animation_get_length, URHO3D_CONTEXT HL_URHO3D_ANIMATION);
