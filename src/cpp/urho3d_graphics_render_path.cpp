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

void finalize_urho3d_graphics_render_path(void *v)
{
    hl_urho3d_graphics_render_path *hl_ptr = (hl_urho3d_graphics_render_path *)v;
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

hl_urho3d_graphics_render_path *hl_alloc_urho3d_graphics_render_path(urho3d_context *context)
{
        hl_urho3d_graphics_render_path *p = (hl_urho3d_graphics_render_path *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_render_path));
        memset(p, 0, sizeof(hl_urho3d_graphics_render_path));
        p->finalizer = (void *)finalize_urho3d_graphics_render_path;
        p->ptr = new Urho3D::RenderPath();
        return p;
 
}

hl_urho3d_graphics_render_path *hl_alloc_urho3d_graphics_render_path(Urho3D::RenderPath *path)
{

    hl_urho3d_graphics_render_path *p = (hl_urho3d_graphics_render_path *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_render_path));
    memset(p, 0, sizeof(hl_urho3d_graphics_render_path));
    p->finalizer = (void *)finalize_urho3d_graphics_render_path;
    p->ptr = path;
    return p;
}



HL_PRIM hl_urho3d_graphics_render_path *HL_NAME(_graphics_render_path_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_render_path(context);
}

HL_PRIM hl_urho3d_graphics_render_path *HL_NAME(_graphics_render_path_clone)(urho3d_context *context,hl_urho3d_graphics_render_path * path)
{
    return hl_alloc_urho3d_graphics_render_path(path->ptr->Clone());
}

HL_PRIM bool HL_NAME(_graphics_render_path_append)(urho3d_context *context,hl_urho3d_graphics_render_path * path,hl_urho3d_resource_xml_file *xmlFile)
{
    return path->ptr->Append(xmlFile->ptr);
}

HL_PRIM void  HL_NAME(_graphics_render_set_shader_parameter)(urho3d_context *context,hl_urho3d_graphics_render_path * path, vstring *str,hl_urho3d_variant * value)
{
    const char *name = (char *)hl_to_utf8(str->bytes);
    path->ptr->SetShaderParameter(String(name),*(value->ptr));
}

HL_PRIM hl_urho3d_variant *   HL_NAME(_graphics_render_get_shader_parameter)(urho3d_context *context,hl_urho3d_graphics_render_path * path, vstring *str,hl_urho3d_variant * value)
{
    const char *name = (char *)hl_to_utf8(str->bytes);
     return hl_alloc_urho3d_variant(path->ptr->GetShaderParameter(String(name)));
}

HL_PRIM void  HL_NAME(_graphics_render_set_enabled)(urho3d_context *context,hl_urho3d_graphics_render_path * path, vstring *str,bool value)
{
    const char *name = (char *)hl_to_utf8(str->bytes);
    path->ptr->SetEnabled(String(name),value);
}

HL_PRIM void  HL_NAME(_graphics_render_toggle_enabled)(urho3d_context *context,hl_urho3d_graphics_render_path * path, vstring *str)
{
    const char *name = (char *)hl_to_utf8(str->bytes);
    path->ptr->ToggleEnabled(String(name));
}

DEFINE_PRIM(HL_URHO3D_RENDER_PATH, _graphics_render_path_create, URHO3D_CONTEXT );

DEFINE_PRIM(HL_URHO3D_RENDER_PATH, _graphics_render_path_clone, URHO3D_CONTEXT HL_URHO3D_RENDER_PATH);
DEFINE_PRIM(_BOOL, _graphics_render_path_append, URHO3D_CONTEXT HL_URHO3D_RENDER_PATH HL_URHO3D_XML_FILE);
DEFINE_PRIM(_VOID, _graphics_render_set_shader_parameter, URHO3D_CONTEXT HL_URHO3D_RENDER_PATH _STRING HL_URHO3D_VARIANT);
DEFINE_PRIM(HL_URHO3D_VARIANT, _graphics_render_get_shader_parameter, URHO3D_CONTEXT HL_URHO3D_RENDER_PATH _STRING );
DEFINE_PRIM(_VOID, _graphics_render_set_enabled, URHO3D_CONTEXT HL_URHO3D_RENDER_PATH _STRING _BOOL);
DEFINE_PRIM(_VOID, _graphics_render_toggle_enabled, URHO3D_CONTEXT HL_URHO3D_RENDER_PATH _STRING);