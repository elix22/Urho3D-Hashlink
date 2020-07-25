#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_scene_node(void *v)
{
 //   printf("finalize_urho3d_scene_node \n");
    hl_urho3d_scene_node *hl_ptr = (hl_urho3d_scene_node *)v;
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

hl_urho3d_scene_node *hl_alloc_urho3d_scene_node(urho3d_context *context)
{

    hl_urho3d_scene_node *p = (hl_urho3d_scene_node *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_node));
    memset(p, 0, sizeof(hl_urho3d_scene_node));
    p->finalizer = (void *)finalize_urho3d_scene_node;
    p->ptr = new Node(context);
    return p;
}

hl_urho3d_scene_node *hl_alloc_urho3d_scene_node(urho3d_context *context, Node *node)
{

    if (node)
    {
        hl_urho3d_scene_node *p = (hl_urho3d_scene_node *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_node));
        memset(p, 0, sizeof(hl_urho3d_scene_node));
        p->finalizer = (void *)finalize_urho3d_scene_node;
        p->ptr = node;
        return p;
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_node_create)(urho3d_context *context)
{
    hl_urho3d_scene_node *v = hl_alloc_urho3d_scene_node(context);
    return v;
}

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_node_create_child)(urho3d_context *context, hl_urho3d_scene_node *this_node, vstring *vname, int mode, int id, bool temporary)
{
    const char *name = (char *)hl_to_utf8(vname->bytes);
    Node *child = this_node->ptr->CreateChild(String(name), (CreateMode)mode, id, temporary);
    if (child)
    {
        return hl_alloc_urho3d_scene_node(context, child);
    }
    return NULL;
}

HL_PRIM hl_urho3d_scene_component * HL_NAME(_scene_node_create_component)(urho3d_context *context, hl_urho3d_scene_node *this_node, vstring *vtype, int mode, unsigned id)
{
    const char *type = (char *)hl_to_utf8(vtype->bytes);
    Component *component = this_node->ptr->CreateComponent(StringHash(String(type)), (CreateMode)mode, id);
    if (component)
    {
       // printf("_scene_node_create_component %s success \n",type);
        return hl_alloc_urho3d_scene_component(component);
    }
    else
    {
       // printf("_scene_node_create_component %s failure \n",type);
        return NULL;
    }
}



HL_PRIM hl_urho3d_scene_component * HL_NAME(_scene_node_get_component)(urho3d_context *context, hl_urho3d_scene_node *this_node, vstring *vtype)
{
    const char *type = (char *)hl_to_utf8(vtype->bytes);
    Component *component = this_node->ptr->GetComponent(StringHash(type),true);
    if (component)
    {
        return hl_alloc_urho3d_scene_component(component);
    }
    else
    {
        return NULL;
    }
}


HL_PRIM void HL_NAME(_scene_node_add_component)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_scene_component * component,int id, int mode)
{
    if(component->ptr)
    {
        this_node->ptr->AddComponent(component->ptr,id,(CreateMode)mode);
    }
}

HL_PRIM void HL_NAME(_scene_node_set_position)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_math_vector3 * vector )
{
    this_node->ptr->SetPosition(*(vector->ptr));
}

HL_PRIM hl_urho3d_math_vector3 * HL_NAME(_scene_node_get_position)(urho3d_context *context, hl_urho3d_scene_node *this_node )
{
    return hl_alloc_urho3d_math_vector3(this_node->ptr->GetPosition());
}


HL_PRIM void HL_NAME(_scene_node_set_rotation)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_math_quaternion * qt )
{
    this_node->ptr->SetRotation(*(qt->ptr));
}

HL_PRIM hl_urho3d_math_quaternion * HL_NAME(_scene_node_get_rotation)(urho3d_context *context, hl_urho3d_scene_node *this_node )
{
     return  hl_alloc_urho3d_math_quaternion(this_node->ptr->GetRotation());
}

//void Rotate(const Quaternion& delta, TransformSpace space = TS_LOCAL);
HL_PRIM void HL_NAME(_scene_node_rotate)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_math_quaternion * qt, int space )
{
    this_node->ptr->Rotate(*(qt->ptr),(TransformSpace)space);
}

HL_PRIM void HL_NAME(_scene_node_rotate_euler)(urho3d_context *context, hl_urho3d_scene_node *this_node, float x, float y, float z, int space )
{
    this_node->ptr->Rotate(Quaternion(x,y,z),(TransformSpace)space);
}


DEFINE_PRIM(HL_URHO3D_NODE, _scene_node_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_NODE, _scene_node_create_child, URHO3D_CONTEXT HL_URHO3D_NODE _STRING _I32 _I32 _BOOL);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_node_create_component, URHO3D_CONTEXT HL_URHO3D_NODE _STRING _I32 _I32);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_node_get_component, URHO3D_CONTEXT HL_URHO3D_NODE _STRING);
DEFINE_PRIM(_VOID, _scene_node_add_component, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_COMPONENT _I32 _I32);

DEFINE_PRIM(_VOID, _scene_node_set_position, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_VECTOR3);
DEFINE_PRIM(HL_URHO3D_VECTOR3, _scene_node_get_position, URHO3D_CONTEXT HL_URHO3D_NODE );

DEFINE_PRIM(_VOID, _scene_node_set_rotation, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_QUATERNION);
DEFINE_PRIM(HL_URHO3D_QUATERNION, _scene_node_get_rotation, URHO3D_CONTEXT HL_URHO3D_NODE );

DEFINE_PRIM(_VOID, _scene_node_rotate, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_QUATERNION _I32);
DEFINE_PRIM(_VOID, _scene_node_rotate_euler, URHO3D_CONTEXT HL_URHO3D_NODE _F32 _F32 _F32 _I32);