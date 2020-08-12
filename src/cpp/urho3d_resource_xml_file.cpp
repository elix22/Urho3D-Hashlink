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

void finalize_urho3d_resource_xml_file(void *v)
{
    hl_urho3d_resource_xml_file *v2ptr = (hl_urho3d_resource_xml_file *)v;
    if (v2ptr)
    {
        /* v2ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
        v2ptr->ptr = NULL;
        v2ptr->finalizer = NULL;
    }
}

hl_urho3d_resource_xml_file *hl_alloc_urho3d_resource_xml_file(urho3d_context *context, const char *name)
{

    ResourceCache *cache = context->GetSubsystem<ResourceCache>();

     SharedPtr<Urho3D::XMLFile> resource(cache->GetResource<XMLFile>(String(name)));

    if (resource)
    {
        hl_urho3d_resource_xml_file *p = (hl_urho3d_resource_xml_file *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_resource_xml_file));
        memset(p, 0, sizeof(hl_urho3d_resource_xml_file));
        p->finalizer = (void *)finalize_urho3d_resource_xml_file;
        p->ptr = resource;
        return p;
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_resource_xml_file *HL_NAME(_create_resource_xml_file)(urho3d_context *context, vstring *str)
{
    const char *ch = (char *)hl_to_utf8(str->bytes);
    hl_urho3d_resource_xml_file *v = hl_alloc_urho3d_resource_xml_file(context, ch);
    return v;
}

DEFINE_PRIM(HL_URHO3D_XML_FILE, _create_resource_xml_file, URHO3D_CONTEXT _STRING);
