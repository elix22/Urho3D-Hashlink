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

static int hl_hash_start = 0;
static int hl_hash_delayed_start = 0;
static int hl_hash_stop = 0;
static int hl_hash_update = 0;
static int hl_hash_post_update = 0;
static int hl_hash_fixed_update = 0;
static int hl_hash_fixed_post_update = 0;
static int hl_hash_on_node_set = 0;
static int hl_hash_on_scene_set = 0;
static int hl_hash_on_marked_dirty = 0;
static int hl_hash_on_node_set_enabled = 0;

vdynamic *hl_dyn_abstract_call(vclosure *c, vdynamic **args, int nargs);
// very fast function
void *hl_dyn_getp_internal(vdynamic *d, hl_field_lookup **f, int hfield, vclosure *c = NULL);

const char *LOGIC_CATEGORY = "Logic";

class HashLinkLogicComponent : public LogicComponent
{
    URHO3D_OBJECT(HashLinkLogicComponent, LogicComponent);

public:
    static void RegisterObject(Context *context)
    {
        context->RegisterFactory<HashLinkLogicComponent>(LOGIC_CATEGORY);

        URHO3D_ACCESSOR_ATTRIBUTE("Class Name", GetClassName, SetClassName, String, String::EMPTY, AM_DEFAULT);
    }

    void SetClassName(const String &className)
    {
        this->_className = className;
    }

    const String &GetClassName() const { return _className; }

    HashLinkLogicComponent(Context *context, vdynamic *dyn = NULL, String className = "") : LogicComponent(context)
    {
        dyn_obj = dyn;
        if (dyn_obj)
        {
            hl_add_root(&dyn_obj);
        }

        _className = className;
        dyn_obj_field_start = NULL;
        dyn_obj_field_delayed_start = NULL;
        dyn_obj_field_stop = NULL;
        dyn_obj_field_update = NULL;
        dyn_obj_field_post_update = NULL;
        dyn_obj_field_fixed_update = NULL;
        dyn_obj_field_fixed_post_update = NULL;
        if (hl_hash_start == 0)
            hl_hash_start = hl_hash_utf8("Start");
        if (hl_hash_delayed_start == 0)
            hl_hash_delayed_start = hl_hash_utf8("DelayedStart");
        if (hl_hash_stop == 0)
            hl_hash_stop = hl_hash_utf8("Stop");
        if (hl_hash_update == 0)
            hl_hash_update = hl_hash_utf8("Update");
        if (hl_hash_post_update == 0)
            hl_hash_post_update = hl_hash_utf8("PostUpdate");
        if (hl_hash_fixed_update == 0)
            hl_hash_fixed_update = hl_hash_utf8("FixedUpdate");
        if (hl_hash_fixed_post_update == 0)
            hl_hash_fixed_post_update = hl_hash_utf8("FixedPostUpdate");
        if (hl_hash_on_node_set == 0)
            hl_hash_on_node_set = hl_hash_utf8("_OnNodeSet");
        if (hl_hash_on_scene_set == 0)
            hl_hash_on_scene_set = hl_hash_utf8("_OnSceneSet");
        if (hl_hash_on_marked_dirty == 0)
            hl_hash_on_marked_dirty = hl_hash_utf8("_OnMarkedDirty");
        if (hl_hash_on_node_set_enabled == 0)
            hl_hash_on_node_set_enabled = hl_hash_utf8("_OnNodeSetEnabled");
    }

    /// Destruct.
    ~HashLinkLogicComponent() override
    {
        //  printf("%s \n", __FUNCTION__);

        if (dyn_obj)
        {
            hl_remove_root(&dyn_obj);
            dyn_obj = NULL;
        }
    }

    String GetString(vdynamic *dyn_obj) const
    {

        if (dyn_obj)
        {
            uchar *ustr = (uchar *)hl_dyn_getp(dyn_obj, hl_hash_utf8("bytes"), &hlt_bytes);
            if (ustr)
            {
                return String(hl_to_utf8(ustr));
            }
            else
                return String("");
        }
        else
            return String("");
    }

    Vector<String> GetFields() const
    {
        Vector<String> result;
        if (dyn_obj)
        {
            vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_utf8("GetFields"), &hlt_dyn);
            if (closure)
            {
                vdynamic *ret = hl_dyn_call(closure, NULL, 0);
                varray *array = (varray *)hl_dyn_getp(ret, hl_hash_utf8("array"), &hlt_array);
                if (array && array->size > 0)
                {
                    for (int i = 0; i < array->size; i++)
                    {
                        vstring *str = hl_aptr(array, vstring *)[i];
                        if (str)
                        {
                            const char *name = (char *)hl_to_utf8(str->bytes);
                            if (name)
                            {
                                result.Push(name);
                            }
                        }
                    }
                }
            }
        }

        return result;
    }

    void PopulateDynamicNode(Node *node, vdynamic **dyn_node)
    {
        *dyn_node = (vdynamic *)node->GetVar("hl-object").GetVoidPtr();

      //  printf("%s %d %p %p \n",__FUNCTION__,__LINE__,node,*dyn_node);

        if (*dyn_node != NULL)
        {
            return;
        }

        Node *parent = node->GetParent();
        vdynamic *dyn_node_parent = NULL;
        if (parent)
        {
            dyn_node_parent = (vdynamic *)parent->GetVar("hl-object").GetVoidPtr();
            if (dyn_node_parent == NULL)
                PopulateDynamicNode(parent, &dyn_node_parent);
                /*
            else
            {
                 printf("%s %d %p %p \n",__FUNCTION__,__LINE__,parent,dyn_node_parent);
            }
            */
            
        }
        else
        {
            dyn_node_parent = (vdynamic *)node->GetScene()->GetVar("hl-object").GetVoidPtr();
            if (dyn_node_parent == NULL)
            {
                dyn_node_parent = (vdynamic *)node->GetScene()->GetGlobalVar("hl-object").GetVoidPtr();
            }
          //  printf("%s %d %p %p \n",__FUNCTION__,__LINE__,node->GetScene(),dyn_node_parent);
        }

        if (dyn_node_parent != NULL)
        {
            vclosure *closure = (vclosure *)hl_dyn_getp(dyn_node_parent, hl_hash_utf8("CreateChildFromAbstractNode"), &hlt_dyn);
            if (closure)
            {
                hl_urho3d_scene_node *hl_node = hl_alloc_urho3d_scene_node(context_, node);
                vdynamic *dyn_abstract = hl_alloc_dynamic(&hlt_abstract);
                dyn_abstract->v.ptr = hl_node;

                vdynamic *args[1];
                args[0] = dyn_abstract;
                *dyn_node = hl_dyn_abstract_call(closure, args, 1);

                hl_node->dyn_obj = *dyn_node;
                hl_node->ptr->SetVar("hl-object", *dyn_node);

             //   printf("%s %d %p %p \n",__FUNCTION__,__LINE__,hl_node->ptr.Get(),*dyn_node);
            }
        }
    }

    /// Load from XML data. Return true if successful.
    virtual bool LoadXML(const XMLElement &source)
    {
        Scene *scene = node_->GetScene();
        if (scene == NULL)
        {
            printf("LoadXML error scene=null\n");
            return false;
        }

        vdynamic *dyn_node = NULL;
        PopulateDynamicNode(node_, &dyn_node);
       // printf("dyn_node = %p\n", dyn_node);

        XMLElement attrElem = source.GetChild("attribute");

        while (attrElem)
        {
            String name = attrElem.GetAttribute("name");
            String value = attrElem.GetAttribute("value");
            if (name == String("Class Name"))
            {
             //   printf("creating %s \n", value.CString());
            }
            // printf("name:%s value:%s \n", name.CString(), value.CString());
            //Variant varValue = attrElem.GetVariantValue(attr.type_);

            attrElem = attrElem.GetNext("attribute");
        }

        return true;
    }

    /// Save as XML data. Return true if successful.

    virtual bool SaveXML(XMLElement &dest) const
    {
        //   printf("%s \n", __FUNCTION__);
        if (dyn_obj == NULL)
            return true;

        LogicComponent::SaveXML(dest);

        vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_utf8("GetFields"), &hlt_dyn);
        if (closure)
        {
            vdynamic *ret = hl_dyn_call(closure, NULL, 0);
            varray *array = (varray *)hl_dyn_getp(ret, hl_hash_utf8("array"), &hlt_array);
            if (array != NULL)
            {
                //printf("array not null \n");
                if (array && array->size > 0)
                {

                    for (int i = 0; i < array->size; i++)
                    {
                        vstring *str = hl_aptr(array, vstring *)[i];
                        if (str)
                        {
                            const char *name = (char *)hl_to_utf8(str->bytes);
                            if (name)
                            {
                                //printf("%s \n", name);
                                vdynamic *dyn_field = (vdynamic *)hl_dyn_getp(dyn_obj, hl_hash_utf8(name), &hlt_dyn);

                                if (dyn_field != NULL)
                                {
                                    //  printf(" %s : %d  \n", name, dyn_field->t->kind);
                                    if (HABSTRACT == dyn_field->t->kind)
                                    {

                                        //   printf(" %s : %d :%s \n", name, dyn_field->t->kind, hl_to_utf8(dyn_field->t->abs_name));

                                        if (hl_hash_utf8(hl_to_utf8(dyn_field->t->abs_name)) == hl_hash_utf8("hl_urho3d_math_vector2"))
                                        {
                                            XMLElement attrElem = dest.CreateChild("attribute");
                                            attrElem.SetAttribute("name", name);
                                            hl_urho3d_math_vector2 *hl_urho3d_obj = (hl_urho3d_math_vector2 *)dyn_field->v.ptr;
                                            attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                                        }
                                        else if (hl_hash_utf8(hl_to_utf8(dyn_field->t->abs_name)) == hl_hash_utf8("hl_urho3d_intvector2"))
                                        {
                                            XMLElement attrElem = dest.CreateChild("attribute");
                                            attrElem.SetAttribute("name", name);
                                            hl_urho3d_intvector2 *hl_urho3d_obj = (hl_urho3d_intvector2 *)dyn_field->v.ptr;
                                            attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                                        }
                                        else if (hl_hash_utf8(hl_to_utf8(dyn_field->t->abs_name)) == hl_hash_utf8("hl_urho3d_math_vector3"))
                                        {
                                            XMLElement attrElem = dest.CreateChild("attribute");
                                            attrElem.SetAttribute("name", name);
                                            hl_urho3d_math_vector3 *hl_urho3d_obj = (hl_urho3d_math_vector3 *)dyn_field->v.ptr;
                                            attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                                        }
                                        else if (hl_hash_utf8(hl_to_utf8(dyn_field->t->abs_name)) == hl_hash_utf8("hl_urho3d_math_quaternion"))
                                        {
                                            XMLElement attrElem = dest.CreateChild("attribute");
                                            attrElem.SetAttribute("name", name);
                                            hl_urho3d_math_quaternion *hl_urho3d_obj = (hl_urho3d_math_quaternion *)dyn_field->v.ptr;
                                            attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                                        }
                                        else if (hl_hash_utf8(hl_to_utf8(dyn_field->t->abs_name)) == hl_hash_utf8("hl_urho3d_color"))
                                        {
                                            XMLElement attrElem = dest.CreateChild("attribute");
                                            attrElem.SetAttribute("name", name);
                                            hl_urho3d_color *hl_urho3d_obj = (hl_urho3d_color *)dyn_field->v.ptr;
                                            attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                                        }
                                    }

                                    if (!strcmp(name, "testString"))
                                    {

                                        //   printf("%s : %s \n", name, GetString(dyn_field).CString());
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                printf("array is null \n");
            }
        }

        return true;
    }

    /*
                                        hl_type_obj *string_obj = dyn_field->t->obj;
                                        if (string_obj != NULL)
                                        {
                                            printf("testString nfields:%d \n", string_obj->nfields);
                                            for (int i = 0; i < string_obj->nfields; i++)
                                            {
                                                hl_obj_field *f = string_obj->fields + i;
                                                printf("testString field:%s kind:%d  \n", hl_to_utf8(f->name), f->t->kind);
                                            }
                                        }

                                        uchar *dyn_test_string = (uchar *)hl_dyn_getp(dyn_field, hl_hash_utf8("bytes"), &hlt_bytes);
                                        if (dyn_test_string != 0)
                                        {
                                            printf("%s : %s \n", name, hl_to_utf8(dyn_test_string));
                                        }
                                        else
                                        {
                                            printf("dyn_test_string = NULL \n");
                                        }
                                        */

    /// Handle enabled/disabled state change. Changes update event subscription.
    void OnSetEnabled() override
    {
    }

    /// Called when the component is added to a scene node. Other components may not yet exist.
    virtual void Start()
    {

        if (dyn_obj)
        {

            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_start, &hlt_dyn);
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_start, hl_hash_start, &closure);
            ((void (*)(vdynamic *))closure.fun)((vdynamic *)closure.value);
            // hl_dyn_call(&closure, NULL, 0);

            /*
            hl_field_lookup *hl_lookup = obj_resolve_field(dyn_obj->t->obj, hl_hash_utf8("Start"));
            if (hl_lookup)
            {
                void *args[1];
                hl_dyn_call_obj(dyn_obj, hl_lookup->t, hl_lookup->hashed_name, args, NULL);
            }
            */
        }
    }

    /// Called before the first update. At this point all other components of the node should exist. Will also be called if update events are not wanted; in that case the event is immediately unsubscribed afterward.
    virtual void DelayedStart()
    {
        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_delayed_start, &hlt_dyn);
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_delayed_start, hl_hash_delayed_start, &closure);
            ((void (*)(vdynamic *))closure.fun)((vdynamic *)closure.value);
            // hl_dyn_call(&closure, NULL, 0);
        }
    }

    /// Called on scene update, variable timestep.
    virtual void Update(float timeStep)
    {

        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_update, &hlt_dyn);
            /*faster way , caching the field*/
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_update, hl_hash_update, &closure);
            ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
            /*
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};
            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(&closure, vargs, 1);
            */
        }
    }
    /// Called on scene post-update, variable timestep.
    virtual void PostUpdate(float timeStep)
    {
        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_post_update, &hlt_dyn);

            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_post_update, hl_hash_post_update, &closure);
            ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
            /*
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};

            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(&closure, vargs, 1);
            */
        }
    }
    /// Called on physics update, fixed timestep.
    virtual void FixedUpdate(float timeStep)
    {
        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_fixed_update, &hlt_dyn);
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_fixed_update, hl_hash_fixed_update, &closure);
            ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
            /*
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};

            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(&closure, vargs, 1);
            */
        }
    }
    /// Called on physics post-update, fixed timestep.
    virtual void FixedPostUpdate(float timeStep)
    {
        if (dyn_obj)
        {
            //vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_fixed_post_update, &hlt_dyn);
            vclosure closure;
            hl_dyn_getp_internal(dyn_obj, &dyn_obj_field_fixed_post_update, hl_hash_fixed_post_update, &closure);
            ((void (*)(vdynamic *, double))closure.fun)((vdynamic *)closure.value, (double)timeStep);
            /*
            vdynamic args[1];
            vdynamic *vargs[1] = {&args[0]};

            args[0].t = &hlt_f32;
            args[0].v.f = timeStep;
            hl_dyn_call(&closure, vargs, 1);
            */
        }
    }

    virtual void OnNodeSet(Node *node)
    {
        //    printf("%s %p\n",__FUNCTION__,node);
        if (dyn_obj)
        {
            vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_on_node_set, &hlt_dyn);
            vdynamic *dyn_urho3d_node = hl_alloc_dynamic(&hlt_abstract);
            dyn_urho3d_node->v.ptr = hl_alloc_urho3d_scene_node_no_finalizer(NULL, node);
            vdynamic *vargs[1] = {dyn_urho3d_node};
            hl_dyn_abstract_call(closure, vargs, 1);
            if (node == NULL)
            {
                hl_remove_root(&dyn_obj);
                dyn_obj = NULL;
            }
        }

        LogicComponent::OnNodeSet(node);
    }

    virtual void OnSceneSet(Scene *scene)
    {
        if (dyn_obj && scene)
        {
            vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_on_scene_set, &hlt_dyn);
            vdynamic *dyn_urho3d = hl_alloc_dynamic(&hlt_abstract);
            hl_urho3d_scene_scene *hl_scene = hl_alloc_urho3d_scene_scene_no_finalizer(NULL, scene);
            dyn_urho3d->v.ptr = hl_scene;
            vdynamic *vargs[1] = {dyn_urho3d};
            hl_dyn_abstract_call(closure, vargs, 1);

            // Don't keep a reference to the scene , will cause a crash.
            hl_scene->ptr = NULL;
        }

        LogicComponent::OnSceneSet(scene);

        if (scene == NULL)
        {
            hl_remove_root(&dyn_obj);
            dyn_obj = NULL;
        }
    }

    virtual void OnMarkedDirty(Node *node)
    {
        if (dyn_obj)
        {
            vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_on_marked_dirty, &hlt_dyn);
            vdynamic *dyn_urho3d_node = hl_alloc_dynamic(&hlt_abstract);
            dyn_urho3d_node->v.ptr = hl_alloc_urho3d_scene_node_no_finalizer(NULL, node);
            vdynamic *vargs[1] = {dyn_urho3d_node};
            hl_dyn_abstract_call(closure, vargs, 1);
        }

        LogicComponent::OnMarkedDirty(node);
    }

    virtual void OnNodeSetEnabled(Node *node)
    {
        if (dyn_obj)
        {
            vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_on_node_set_enabled, &hlt_dyn);
            vdynamic *dyn_urho3d_node = hl_alloc_dynamic(&hlt_abstract);
            dyn_urho3d_node->v.ptr = hl_alloc_urho3d_scene_node_no_finalizer(NULL, node);
            vdynamic *vargs[1] = {dyn_urho3d_node};
            hl_dyn_abstract_call(closure, vargs, 1);
        }

        LogicComponent::OnNodeSetEnabled(node);
    }

    vdynamic *dyn_obj;
    String _className;
    hl_field_lookup *dyn_obj_field_start;
    hl_field_lookup *dyn_obj_field_delayed_start;
    hl_field_lookup *dyn_obj_field_stop;
    hl_field_lookup *dyn_obj_field_update;
    hl_field_lookup *dyn_obj_field_post_update;
    hl_field_lookup *dyn_obj_field_fixed_update;
    hl_field_lookup *dyn_obj_field_fixed_post_update;
};

void finalize_urho3d_scene_logic_component(void *v)
{

    hl_urho3d_scene_logic_component *hl_ptr = (hl_urho3d_scene_logic_component *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            hl_ptr->ptr->Remove();
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

//

hl_urho3d_scene_logic_component *hl_alloc_urho3d_scene_logic_component(urho3d_context *context, vdynamic *dyn_obj, const char *className)
{

    hl_urho3d_scene_logic_component *p = (hl_urho3d_scene_logic_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_logic_component));
    memset(p, 0, sizeof(hl_urho3d_scene_logic_component));
    p->finalizer = (void *)finalize_urho3d_scene_logic_component;
    HashLinkLogicComponent *c = new HashLinkLogicComponent(context, dyn_obj, className);
    p->ptr = c;
    p->dyn_obj = dyn_obj;
    return p;
}

hl_urho3d_scene_logic_component *hl_alloc_urho3d_scene_logic_component(urho3d_context *context)
{

    hl_urho3d_scene_logic_component *p = (hl_urho3d_scene_logic_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_logic_component));
    memset(p, 0, sizeof(hl_urho3d_scene_logic_component));
    p->finalizer = (void *)finalize_urho3d_scene_logic_component;
    p->ptr = new HashLinkLogicComponent(context);
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_scene_logic_component *hl_alloc_urho3d_scene_logic_component(LogicComponent *component)
{
    if (component)
    {
        hl_urho3d_scene_logic_component *p = (hl_urho3d_scene_logic_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_logic_component));
        memset(p, 0, sizeof(hl_urho3d_scene_logic_component));
        p->finalizer = (void *)finalize_urho3d_scene_logic_component;
        p->ptr = component;
        p->dyn_obj = NULL;
        return p;
    }
    return NULL;
}

HL_PRIM void *HL_NAME(_scene_logic_component_register_object)(urho3d_context *context)
{
    HashLinkLogicComponent::RegisterObject(context);
}

HL_PRIM hl_urho3d_scene_logic_component *HL_NAME(_scene_logic_component_create)(urho3d_context *context, vdynamic *dyn_obj, vstring *className)
{
    const char *name = (char *)hl_to_utf8(className->bytes);
    return hl_alloc_urho3d_scene_logic_component(context, dyn_obj, name);
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_scene_logic_component_cast_to_component)(urho3d_context *context, hl_urho3d_scene_logic_component *component)
{
    hl_urho3d_scene_component *hl_u3d_obj = hl_alloc_urho3d_scene_component(component->ptr);
    return hl_u3d_obj;
}

HL_PRIM hl_urho3d_scene_logic_component *HL_NAME(_scene_logic_component_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    Component *cmp = component->ptr;
    hl_urho3d_scene_logic_component *hl_u3d_obj = hl_alloc_urho3d_scene_logic_component(dynamic_cast<LogicComponent *>(cmp));
    return hl_u3d_obj;
}

HL_PRIM void HL_NAME(_scene_logic_component_set_update_event_mask)(urho3d_context *context, hl_urho3d_scene_logic_component *component, int mask)
{
    component->ptr->SetUpdateEventMask(UpdateEventFlags(mask));
}

HL_PRIM int HL_NAME(_scene_logic_component_get_update_event_mask)(urho3d_context *context, hl_urho3d_scene_logic_component *component)
{
    return component->ptr->GetUpdateEventMask().AsInteger();
}

DEFINE_PRIM(_VOID, _scene_logic_component_register_object, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_LOGIC_COMPONENT, _scene_logic_component_create, URHO3D_CONTEXT _DYN _STRING);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_logic_component_cast_to_component, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT);
DEFINE_PRIM(HL_URHO3D_LOGIC_COMPONENT, _scene_logic_component_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);
DEFINE_PRIM(_VOID, _scene_logic_component_set_update_event_mask, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT _I32);
DEFINE_PRIM(_I32, _scene_logic_component_get_update_event_mask, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT);
