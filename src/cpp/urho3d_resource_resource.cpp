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


void finalize_urho3d_resource(void * v)
{
    hl_urho3d_resource  * v2ptr = (hl_urho3d_resource  * )v;
    if(v2ptr)
    {
         Urho3D::Resource *vector2 = (Urho3D::Resource *)v2ptr->ptr;
         if(vector2)
         {
             /* v2ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
             v2ptr->ptr = NULL;
             
         }
         v2ptr->finalizer = NULL;
    }
    
}

hl_urho3d_resource * hl_alloc_urho3d_resource(urho3d_context *context,hl_urho3d_stringhash * type , const char * name )
{

    //printf("hl_alloc_urho3d_resource type:%s name:%s \n",(*(type->ptr)).ToString().CString(),String(name).CString());

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();
  
    Resource *resource = cache->GetResource(*(type->ptr), String(name));

    if (resource)
    {
        hl_urho3d_resource *p = (hl_urho3d_resource *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_resource));
        memset(p,0,sizeof(hl_urho3d_resource));
        p->finalizer = (void *)finalize_urho3d_resource;
        p->ptr = resource;
        return p;
    }
    else
    {
        return NULL;
    }

}


HL_PRIM  hl_urho3d_resource  * HL_NAME(_create_resource)(urho3d_context *context,hl_urho3d_stringhash * type,vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    hl_urho3d_resource * v =  hl_alloc_urho3d_resource(context,type,ch);
    return v;
}



DEFINE_PRIM(HL_URHO3D_RESOURCE, _create_resource, URHO3D_CONTEXT HL_URHO3D_STRINGHASH _STRING);
