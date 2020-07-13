#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


void finalize_urho3d_texture2d(void * v)
{
    hl_urho3d_texture2d  * hl_ptr= (hl_urho3d_texture2d  * )v;
    if(hl_ptr)
    {
         Urho3D::Resource *urho3d_ptr = (Urho3D::Resource *)hl_ptr->ptr;
         if(urho3d_ptr)
         {
             delete urho3d_ptr;
             hl_ptr->ptr = NULL;
             
         }
         hl_ptr->finalizer = NULL;
    }
    
}

hl_urho3d_texture2d * hl_alloc_urho3d_txture2d(urho3d_context *context , const char * name )
{

    //printf("hl_alloc_urho3d_txture2d  name:%s \n",String(name).CString());

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();
  
    Texture2D *resource = cache->GetResource<Texture2D>(String(name));

    if (resource)
    {
        hl_urho3d_texture2d *p = (hl_urho3d_texture2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_resource));
        p->finalizer = (void *)finalize_urho3d_texture2d;
        p->ptr = resource;
        return p;
    }
    else
    {
        return NULL;
    }

}


HL_PRIM  hl_urho3d_texture2d  * HL_NAME(_create_texture2d)(urho3d_context *context,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    hl_urho3d_texture2d * v =  hl_alloc_urho3d_txture2d(context,ch);
    return v;
}



DEFINE_PRIM(HL_URHO3D_TEXTURE2D, _create_texture2d, URHO3D_CONTEXT _STRING);