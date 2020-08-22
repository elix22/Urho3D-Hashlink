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

void finalize_urho3d_scene_scene(void *v)
{
    hl_urho3d_scene_scene *hl_ptr = (hl_urho3d_scene_scene *)v;
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

hl_urho3d_scene_scene *hl_alloc_urho3d_scene_scene(urho3d_context *context)
{

    hl_urho3d_scene_scene *p = (hl_urho3d_scene_scene *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_scene));
    memset(p, 0, sizeof(hl_urho3d_scene_scene));
    p->finalizer = (void *)finalize_urho3d_scene_scene;
    p->ptr = new Scene(context);
    return p;
}

hl_urho3d_scene_scene *hl_alloc_urho3d_scene_scene_no_finalizer(urho3d_context *context, Scene *scene)
{

    hl_urho3d_scene_scene *p = (hl_urho3d_scene_scene *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_scene));
    memset(p, 0, sizeof(hl_urho3d_scene_scene));
    p->ptr = scene;
    return p;
}

HL_PRIM hl_urho3d_scene_scene *HL_NAME(_scene_scene_create)(urho3d_context *context, vdynamic *dyn_obj)
{
    hl_urho3d_scene_scene *v = hl_alloc_urho3d_scene_scene(context);
    v->dyn_obj = dyn_obj;
    v->ptr->SetVar("hl-object", dyn_obj);
    return v;
}

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_scene_cast_to_node)(urho3d_context *context, hl_urho3d_scene_scene *scene)
{
    hl_urho3d_scene_node *hl_node = hl_alloc_urho3d_scene_node(context, scene->ptr);
    return hl_node;
}

HL_PRIM Urho3D::Octree *HL_NAME(_scene_scene_get_octree)(urho3d_context *context, hl_urho3d_scene_scene *scene)
{
    return scene->ptr->GetComponent<Octree>();
}

//SaveXML
HL_PRIM bool HL_NAME(_scene_scene_save_xml)(urho3d_context *context, hl_urho3d_scene_scene *scene, hl_urho3d_io_file *file, vstring *indentation)
{
    File *f = file->ptr;
    const char *indent = (char *)hl_to_utf8(indentation->bytes);
    return scene->ptr->SaveXML(*f, indent);
}

//
HL_PRIM bool HL_NAME(_scene_scene_save_xml_string)(urho3d_context *context, hl_urho3d_scene_scene *scene, vstring *vpath, vstring *indentation)
{
    const char *file_path = (char *)hl_to_utf8(vpath->bytes);
    Urho3D::File file(context, String(file_path), FileMode::FILE_WRITE);
    const char *indent = (char *)hl_to_utf8(indentation->bytes);
    bool ret =  scene->ptr->SaveXML(file, indent);
    file.Close();
    return ret;
}

HL_PRIM bool HL_NAME(_scene_scene_load_xml)(urho3d_context *context, hl_urho3d_scene_scene *scene, hl_urho3d_io_file *file)
{
    File *f = file->ptr;
    scene->ptr->SetGlobalVar("hl-object", scene->dyn_obj);
    bool ret = scene->ptr->LoadXML(*f);
    scene->ptr->SetVar("hl-object", scene->dyn_obj);
    return ret;
}

HL_PRIM bool HL_NAME(_scene_scene_load_xml_string)(urho3d_context *context, hl_urho3d_scene_scene *scene, vstring *vpath)
{
    const char *file_path = (char *)hl_to_utf8(vpath->bytes);
    Urho3D::File file(context, String(file_path), FileMode::FILE_READ);
    scene->ptr->SetGlobalVar("hl-object", scene->dyn_obj);
    bool ret = scene->ptr->LoadXML(file);
    file.Close();
    scene->ptr->SetVar("hl-object", scene->dyn_obj);
    return ret;
}

HL_PRIM Urho3D::PhysicsWorld *HL_NAME(_scene_scene_get_physics_world)(urho3d_context *context, hl_urho3d_scene_scene *scene)
{
    return scene->ptr->GetComponent<PhysicsWorld>();
}

DEFINE_PRIM(HL_URHO3D_SCENE, _scene_scene_create, URHO3D_CONTEXT _DYN);
DEFINE_PRIM(HL_URHO3D_NODE, _scene_scene_cast_to_node, URHO3D_CONTEXT HL_URHO3D_SCENE);
DEFINE_PRIM(HL_URHO3D_OCTREE, _scene_scene_get_octree, URHO3D_CONTEXT HL_URHO3D_SCENE);

DEFINE_PRIM(_BOOL, _scene_scene_save_xml, URHO3D_CONTEXT HL_URHO3D_SCENE HL_URHO3D_FILE _STRING);
DEFINE_PRIM(_BOOL, _scene_scene_load_xml, URHO3D_CONTEXT HL_URHO3D_SCENE HL_URHO3D_FILE);

DEFINE_PRIM(_BOOL, _scene_scene_save_xml_string, URHO3D_CONTEXT HL_URHO3D_SCENE _STRING _STRING);
DEFINE_PRIM(_BOOL, _scene_scene_load_xml_string, URHO3D_CONTEXT HL_URHO3D_SCENE _STRING);

DEFINE_PRIM(HL_URHO3D_PHYSICS_WORLD, _scene_scene_get_physics_world, URHO3D_CONTEXT HL_URHO3D_SCENE);