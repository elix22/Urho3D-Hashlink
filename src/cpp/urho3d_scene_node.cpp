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

vdynamic *hl_dyn_abstract_call(vclosure *c, vdynamic **args, int nargs);
void *hl_dyn_getp_internal(vdynamic *d, hl_field_lookup **f, int hfield, vclosure *c = NULL);

void subscribeToEvent(urho3d_context *context, hl_urho3d_scene_node *hl_ptr, hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
{
    if (stringhash)
    {
        Urho3D::StringHash *urho3d_stringhash = stringhash->ptr;
        if (urho3d_stringhash)
        {

            const char *closure_name = (char *)hl_to_utf8(str->bytes);
            (*(hl_ptr->hl_event_closures))[*urho3d_stringhash] = new HL_Urho3DEventHandler(context, dyn_obj, String(closure_name));
            hl_ptr->ptr->SubscribeToEvent(
                *urho3d_stringhash,
                [=](StringHash eventType, VariantMap &eventData) {
                    if (hl_ptr == hl_ptr->ptr->GetEventHandler()->GetUserData())
                    {
                        SharedPtr<HL_Urho3DEventHandler> event_handler = (*(hl_ptr->hl_event_closures))[eventType];
                        if (event_handler != NULL)
                        {
                            vclosure closure;
                            vclosure *callback_fn = (vclosure *)hl_dyn_getp_internal(event_handler->dyn_obj, &event_handler->dyn_obj_field_lookup, event_handler->hl_hash_name, &closure);
                            if (callback_fn && callback_fn->hasValue)
                            {
                                hl_urho3d_stringhash *hl_stringhsh = (hl_urho3d_stringhash *)alloca(sizeof(hl_urho3d_stringhash));
                                hl_stringhsh->ptr = &eventType;
                                vdynamic *dyn_urho3d_stringhash = (vdynamic *)alloca(sizeof(vdynamic));
                                dyn_urho3d_stringhash->t = &hlt_abstract;
                                dyn_urho3d_stringhash->v.ptr = hl_stringhsh;

                                hl_urho3d_variantmap *hl_variantmap = (hl_urho3d_variantmap *)alloca(sizeof(hl_urho3d_variantmap));
                                hl_variantmap->ptr = &eventData;
                                vdynamic *dyn_urho3d_variantmap = (vdynamic *)alloca(sizeof(vdynamic));
                                dyn_urho3d_variantmap->t = &hlt_abstract;
                                dyn_urho3d_variantmap->v.ptr = hl_variantmap;
                                /*
                                vdynamic *args[2];
                                args[0] = dyn_urho3d_stringhash;
                                args[1] = dyn_urho3d_variantmap;
                                hl_dyn_abstract_call(callback_fn, args, 2);
                                */
                                ((void (*)(vdynamic *, vdynamic *, vdynamic *))closure.fun)((vdynamic *)closure.value, (vdynamic *)(*(void **)(&dyn_urho3d_stringhash->v)), (vdynamic *)(*(void **)(&dyn_urho3d_variantmap->v)));
                            }
                        }
                    }
                },
                hl_ptr);
        }
    }
}

void finalize_urho3d_scene_node(void *v)
{
    //   printf("finalize_urho3d_scene_node \n");
    hl_urho3d_scene_node *hl_ptr = (hl_urho3d_scene_node *)v;
    if (hl_ptr)
    {
        hl_ptr->hl_event_closures->Clear();
        delete (hl_ptr->hl_event_closures);
        if (hl_ptr->ptr)
        {
            hl_ptr->ptr->UnsubscribeFromEvents(hl_ptr);
            //   printf("finalize_urho3d_scene_node %d %s \n",hl_ptr->ptr->Refs(), hl_ptr->ptr->GetTypeName().CString());
            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            if (hl_ptr->ptr->Refs() <= 1)
            {
                hl_ptr->ptr->UnsubscribeFromAllEvents();
            }
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
    p->hl_event_closures = new HashMap<StringHash, SharedPtr<HL_Urho3DEventHandler>>();
    return p;
}

hl_urho3d_scene_node *hl_alloc_urho3d_scene_node_no_finalizer(urho3d_context *context, Node *node)
{
    if (node)
    {
        hl_urho3d_scene_node *p = (hl_urho3d_scene_node *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_node));
        memset(p, 0, sizeof(hl_urho3d_scene_node));
        p->ptr = node;
        return p;
    }
    else
    {
        return NULL;
    }
}

hl_urho3d_scene_node *hl_alloc_urho3d_scene_node(urho3d_context *context, Node *node)
{

    if (node)
    {
        hl_urho3d_scene_node *p = (hl_urho3d_scene_node *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_node));
        memset(p, 0, sizeof(hl_urho3d_scene_node));
        p->finalizer = (void *)finalize_urho3d_scene_node;
        p->ptr = node;
        p->hl_event_closures = new HashMap<StringHash, SharedPtr<HL_Urho3DEventHandler>>();
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

HL_PRIM hl_urho3d_scene_component *HL_NAME(_scene_node_create_component)(urho3d_context *context, hl_urho3d_scene_node *this_node, vstring *vtype, int mode, unsigned id)
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

HL_PRIM hl_urho3d_scene_component *HL_NAME(_scene_node_get_component)(urho3d_context *context, hl_urho3d_scene_node *this_node, vstring *vtype, bool recursive)
{
    const char *type = (char *)hl_to_utf8(vtype->bytes);
    Component *component = this_node->ptr->GetComponent(StringHash(type), recursive);
    if (component)
    {
        return hl_alloc_urho3d_scene_component(component);
    }
    else
    {
        return NULL;
    }
}

HL_PRIM void HL_NAME(_scene_node_add_component)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_scene_component *component, int id, int mode)
{
    if (component->ptr)
    {
        this_node->ptr->AddComponent(component->ptr, id, (CreateMode)mode);
    }
}

HL_PRIM void HL_NAME(_scene_node_set_position)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_math_tvector3 *vector)
{
    this_node->ptr->SetPosition(*(vector));
}

HL_PRIM hl_urho3d_math_tvector3 *HL_NAME(_scene_node_get_position)(urho3d_context *context, hl_urho3d_scene_node *this_node)
{
    return hl_alloc_urho3d_math_tvector3(this_node->ptr->GetPosition());
}

HL_PRIM void HL_NAME(_scene_node_set_direction)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_math_tvector3 *vector)
{
    this_node->ptr->SetDirection(*(vector));
}

HL_PRIM hl_urho3d_math_tvector3 *HL_NAME(_scene_node_get_direction)(urho3d_context *context, hl_urho3d_scene_node *this_node)
{
    return hl_alloc_urho3d_math_tvector3(this_node->ptr->GetDirection());
}

HL_PRIM void HL_NAME(_scene_node_set_scale)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_math_tvector3 *vector)
{
    this_node->ptr->SetScale(*(vector));
}

HL_PRIM hl_urho3d_math_tvector3 *HL_NAME(_scene_node_get_scale)(urho3d_context *context, hl_urho3d_scene_node *this_node)
{
    return hl_alloc_urho3d_math_tvector3(this_node->ptr->GetScale());
}

HL_PRIM void HL_NAME(_scene_node_set_rotation)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_math_tquaternion *qt)
{
    this_node->ptr->SetRotation(*(qt));
}

HL_PRIM hl_urho3d_math_tquaternion *HL_NAME(_scene_node_get_rotation)(urho3d_context *context, hl_urho3d_scene_node *this_node)
{
    return hl_alloc_urho3d_math_tquaternion(this_node->ptr->GetRotation());
}

//void Rotate(const Quaternion& delta, TransformSpace space = TS_LOCAL);
HL_PRIM void HL_NAME(_scene_node_rotate)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_math_tquaternion *qt, int space)
{
    this_node->ptr->Rotate(*(qt), (TransformSpace)space);
}

HL_PRIM void HL_NAME(_scene_node_rotate_euler)(urho3d_context *context, hl_urho3d_scene_node *this_node, float x, float y, float z, int space)
{
    this_node->ptr->Rotate(Quaternion(x, y, z), (TransformSpace)space);
}

HL_PRIM void HL_NAME(_scene_node_translate)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_math_tvector3 *vector, int space)
{
    this_node->ptr->Translate(*vector, (TransformSpace)space);
}

HL_PRIM void HL_NAME(_scene_node_yaw)(urho3d_context *context, hl_urho3d_scene_node *this_node, float angle, int space)
{
    this_node->ptr->Yaw(angle, (TransformSpace)space);
}

HL_PRIM void HL_NAME(_scene_node_pitch)(urho3d_context *context, hl_urho3d_scene_node *this_node, float angle, int space)
{
    this_node->ptr->Pitch(angle, (TransformSpace)space);
}

HL_PRIM void HL_NAME(_scene_node_roll)(urho3d_context *context, hl_urho3d_scene_node *this_node, float angle, int space)
{
    this_node->ptr->Roll(angle, (TransformSpace)space);
}

/*
typedef PODVector<Node *> hl_urho3d_scene_pod_node;
#define HL_URHO3D_POD_NODE _ABSTRACT(hl_urho3d_scene_pod_node)
*/

static PODVector<Node *> _hl_scene_node_pod_vector_node;
HL_PRIM PODVector<Node *> *HL_NAME(_scene_node_get_children_with_component)(urho3d_context *context, hl_urho3d_scene_node *this_node, Urho3D::StringHash *typeName, bool recursive)
{
    _hl_scene_node_pod_vector_node.Clear();
    _hl_scene_node_pod_vector_node = this_node->ptr->GetChildrenWithComponent(*typeName, recursive);
    return &_hl_scene_node_pod_vector_node;
}

HL_PRIM int HL_NAME(_scene_node_get_pod_vector_size)(urho3d_context *context, PODVector<Node *> *podVector)
{
    return (*podVector).Size();
}

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_node_get_from_pod_vector)(urho3d_context *context, PODVector<Node *> *podVector, int index)
{
    return hl_alloc_urho3d_scene_node(context, (*podVector)[index]);
}

HL_PRIM void HL_NAME(_scene_node_subscribe_to_event)(urho3d_context *context, hl_urho3d_scene_node *this_node, hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
{
    subscribeToEvent(context, this_node, stringhash, dyn_obj, str);
}

DEFINE_PRIM(HL_URHO3D_POD_NODE, _scene_node_get_children_with_component, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_TSTRINGHASH _BOOL);
DEFINE_PRIM(_I32, _scene_node_get_pod_vector_size, URHO3D_CONTEXT HL_URHO3D_POD_NODE);
DEFINE_PRIM(HL_URHO3D_NODE, _scene_node_get_from_pod_vector, URHO3D_CONTEXT HL_URHO3D_POD_NODE _I32);

DEFINE_PRIM(HL_URHO3D_NODE, _scene_node_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_NODE, _scene_node_create_child, URHO3D_CONTEXT HL_URHO3D_NODE _STRING _I32 _I32 _BOOL);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_node_create_component, URHO3D_CONTEXT HL_URHO3D_NODE _STRING _I32 _I32);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_node_get_component, URHO3D_CONTEXT HL_URHO3D_NODE _STRING _BOOL);
DEFINE_PRIM(_VOID, _scene_node_add_component, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_COMPONENT _I32 _I32);

DEFINE_PRIM(_VOID, _scene_node_set_position, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _scene_node_get_position, URHO3D_CONTEXT HL_URHO3D_NODE);

DEFINE_PRIM(_VOID, _scene_node_set_direction, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _scene_node_get_direction, URHO3D_CONTEXT HL_URHO3D_NODE);

DEFINE_PRIM(_VOID, _scene_node_set_scale, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_TVECTOR3);
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _scene_node_get_scale, URHO3D_CONTEXT HL_URHO3D_NODE);

DEFINE_PRIM(_VOID, _scene_node_set_rotation, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_TQUATERNION);
DEFINE_PRIM(HL_URHO3D_TQUATERNION, _scene_node_get_rotation, URHO3D_CONTEXT HL_URHO3D_NODE);

DEFINE_PRIM(_VOID, _scene_node_rotate, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_TQUATERNION _I32);
DEFINE_PRIM(_VOID, _scene_node_rotate_euler, URHO3D_CONTEXT HL_URHO3D_NODE _F32 _F32 _F32 _I32);

DEFINE_PRIM(_VOID, _scene_node_translate, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_TVECTOR3 _I32);
DEFINE_PRIM(_VOID, _scene_node_yaw, URHO3D_CONTEXT HL_URHO3D_NODE _F32 _I32);
DEFINE_PRIM(_VOID, _scene_node_pitch, URHO3D_CONTEXT HL_URHO3D_NODE _F32 _I32);
DEFINE_PRIM(_VOID, _scene_node_roll, URHO3D_CONTEXT HL_URHO3D_NODE _F32 _I32);

DEFINE_PRIM(_VOID, _scene_node_subscribe_to_event, URHO3D_CONTEXT HL_URHO3D_NODE HL_URHO3D_STRINGHASH _DYN _STRING);
