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
         if(hl_ptr->ptr)
         {
             //printf("finalize_urho3d_texture2d  refs:%d\n", hl_ptr->ptr->Refs());
             /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
             hl_ptr->ptr = NULL;
             
         }
         hl_ptr->finalizer = NULL;
    }
    
}

hl_urho3d_texture2d * hl_alloc_urho3d_txture2d(urho3d_context *context , const char * name )
{

    //printf("hl_alloc_urho3d_txture2d  name:%s \n",String(name).CString());

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();
  
    SharedPtr<Urho3D::Texture2D> resource(cache->GetResource<Texture2D>(String(name)));
    //printf("refs:%d\n", resource->Refs());
    if (resource)
    {
        hl_urho3d_texture2d *p = (hl_urho3d_texture2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_texture2d));
        memset(p,0,sizeof(hl_urho3d_texture2d));
        p->finalizer = (void *)finalize_urho3d_texture2d;
        p->ptr = resource;
        //printf("refs:%d\n", resource->Refs());
         //printf("hl_alloc_urho3d_txture2d success  name:%s \n",String(name).CString());
        return p;
    }
    else
    {
       // printf("hl_alloc_urho3d_txture2d failure  name:%s \n",String(name).CString());
        return NULL;
    }

}

hl_urho3d_texture2d * hl_alloc_urho3d_texture2d(SharedPtr<Urho3D::Texture2D> texture2d)
{
        hl_urho3d_texture2d *p = (hl_urho3d_texture2d *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_resource));
        p->finalizer = (void *)finalize_urho3d_texture2d;
        p->ptr = texture2d;
        return p;
}


HL_PRIM  hl_urho3d_texture2d  * HL_NAME(_create_texture2d)(urho3d_context *context,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    hl_urho3d_texture2d * v =  hl_alloc_urho3d_txture2d(context,ch);
    return v;
}

HL_PRIM const char *HL_NAME(_get_texture2d_get_name)(hl_urho3d_texture2d  * hl_texture2d)
{
    if(hl_texture2d)
    {
        Urho3D::Texture2D * urho3d_texture2d=  hl_texture2d->ptr;
        if(urho3d_texture2d)
             return urho3d_texture2d->GetName().CString();
    }

    return "null";

}



DEFINE_PRIM(HL_URHO3D_TEXTURE2D, _create_texture2d, URHO3D_CONTEXT _STRING);
DEFINE_PRIM(_BYTES, _get_texture2d_get_name, HL_URHO3D_TEXTURE2D);
