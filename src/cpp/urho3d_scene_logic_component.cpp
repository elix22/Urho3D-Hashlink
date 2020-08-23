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
#include <vector>
#include <string>
#include <locale>
#include <codecvt>

//static int counter = 0;
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

static int hl_hash_GetFields = 0;
//hl_hash_utf8("GetFields")

vdynamic *hl_dyn_abstract_call(vclosure *c, vdynamic **args, int nargs);
// very fast function
void *hl_dyn_getp_internal(vdynamic *d, hl_field_lookup **f, int hfield, vclosure *c = NULL);

void hl_obj_fields_internal(vdynamic *obj, std::vector<const uchar *> &result);

class HashLinkLogicComponent;
hl_urho3d_scene_logic_component *hl_local_alloc_urho3d_scene_logic_component(HashLinkLogicComponent *component);

const char *HL_LOGIC_CATEGORY = "Logic";

static bool IsAbstractType(vdynamic *dyn_field, const char *type)
{
    if (((hl_urho3d_structure *)dyn_field->v.ptr)->hash == hl_hash_utf8(type) ||
        ((dyn_field->t->abs_name != NULL) && hl_hash_utf8(hl_to_utf8(dyn_field->t->abs_name)) == hl_hash_utf8(type)))
    {
        return true;
    }
    return false;
}

static vbyte *HLCreateVBString(String value)
{
    hl_buffer *b = hl_alloc_buffer();
    hl_buffer_str(b, (uchar *)(hl_to_utf16(value.CString())));
    return (vbyte *)hl_buffer_content(b, NULL);
}

class HashLinkLogicComponent : public LogicComponent
{
    URHO3D_OBJECT(HashLinkLogicComponent, LogicComponent);

public:
    static void RegisterObject(Context *context)
    {
        context->RegisterFactory<HashLinkLogicComponent>(HL_LOGIC_CATEGORY);

        URHO3D_ACCESSOR_ATTRIBUTE("Class Name", GetClassName, SetClassName, String, String::EMPTY, AM_DEFAULT);
    }

    void SetClassName(const String &className)
    {
        this->_className = className;
    }

    const String &GetClassName() const
    {
        return _className;
    }

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
        if (hl_hash_GetFields == 0)
            hl_hash_GetFields = hl_hash_utf8("GetFields");
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

        //public function CreateHashLinkLogicComponent(component:AbstractLogicComponent, componentType:HString):Dynamic

        XMLElement attrElem = source.GetChild("attribute");
        vdynamic *dyn_component = NULL;
        while (attrElem)
        {
            String name = attrElem.GetAttribute("name");
            String value = attrElem.GetAttribute("value");
            if (name == String("Class Name"))
            {
                this->_className = value;

                if (dyn_node != NULL)
                {
                    vclosure *closure = (vclosure *)hl_dyn_getp(dyn_node, hl_hash_utf8("CreateHashLinkLogicComponent"), &hlt_dyn);
                    if (closure)
                    {
                        hl_urho3d_scene_logic_component *hashlink_logic_component = hl_local_alloc_urho3d_scene_logic_component(this);
                        vdynamic *arg_dyn_abstract = hl_alloc_dynamic(&hlt_abstract);
                        arg_dyn_abstract->v.ptr = hashlink_logic_component;

                        vdynamic arg_vbyte_name;
                        arg_vbyte_name.t = &hlt_bytes;
                        arg_vbyte_name.v.bytes = HLCreateVBString(value);

                        vdynamic *args[2];
                        args[0] = arg_dyn_abstract;
                        args[1] = &arg_vbyte_name;
                        dyn_component = hl_dyn_abstract_call(closure, args, 2);
                        if (dyn_component != NULL)
                        {
                            this->dyn_obj = dyn_component;
                            hashlink_logic_component->dyn_obj = dyn_component;
                            hl_add_root(&dyn_obj);
                            Start();
                        }
                    }
                }

                //   printf("creating %s \n", value.CString());
            }
            else
            {
                //public inline function SetField(name:hl.Bytes, obj:Dynamic)
                if (dyn_obj)
                {
                    vdynamic *dyn_field = (vdynamic *)hl_dyn_getp(dyn_obj, hl_hash_utf8(name.CString()), &hlt_dyn);
                    if (dyn_field != NULL)
                    {
                        if (HABSTRACT == dyn_field->t->kind && dyn_field->v.ptr != NULL)
                        {
                            if (IsAbstractType(dyn_field, "hl_urho3d_math_vector2"))
                            {
                                Vector2 var = attrElem.GetVariantValue(VariantType::VAR_VECTOR2).GetVector2();
                                hl_urho3d_math_vector2 *hl_urho3d_obj = (hl_urho3d_math_vector2 *)dyn_field->v.ptr;
                                *(hl_urho3d_obj->ptr) = var;
                            }
                            else if (IsAbstractType(dyn_field, "hl_urho3d_intvector2"))
                            {
                                IntVector2 var = attrElem.GetVariantValue(VariantType::VAR_INTVECTOR2).GetIntVector2();
                                hl_urho3d_intvector2 *hl_urho3d_obj = (hl_urho3d_intvector2 *)dyn_field->v.ptr;
                                *(hl_urho3d_obj->ptr) = var;
                            }
                            else if (IsAbstractType(dyn_field, "hl_urho3d_math_vector3"))
                            {
                                Vector3 var = attrElem.GetVariantValue(VariantType::VAR_VECTOR3).GetVector3();
                                hl_urho3d_math_vector3 *hl_urho3d_obj = (hl_urho3d_math_vector3 *)dyn_field->v.ptr;
                                *(hl_urho3d_obj->ptr) = var;
                            }
                            else if (IsAbstractType(dyn_field, "hl_urho3d_math_quaternion"))
                            {
                                Quaternion var = attrElem.GetVariantValue(VariantType::VAR_QUATERNION).GetQuaternion();
                                hl_urho3d_math_quaternion *hl_urho3d_obj = (hl_urho3d_math_quaternion *)dyn_field->v.ptr;
                                *(hl_urho3d_obj->ptr) = var;
                            }
                        }
                        else if (HUI8 == dyn_field->t->kind)
                        {
                            int var = attrElem.GetVariantValue(VariantType::VAR_INT).GetInt();
                            dyn_field->v.ui8 = var;
                          //  printf("%s %d %d %d \n", __FUNCTION__, __LINE__, var, dyn_field->v.ui8);
                        }
                        else if (HUI16 == dyn_field->t->kind)
                        {
                            int var = attrElem.GetVariantValue(VariantType::VAR_INT).GetInt();
                            dyn_field->v.ui16 = var;
                           // printf("%s %d %d %d \n", __FUNCTION__, __LINE__, var, dyn_field->v.ui16);
                        }
                        else if (HI32 == dyn_field->t->kind)
                        {
                            int var = attrElem.GetVariantValue(VariantType::VAR_INT).GetInt();
                            dyn_field->v.i = var;
                          //  printf("%s %d %s %d %d \n", __FUNCTION__, __LINE__, name.CString(), var, dyn_field->v.i);
                        }
                        else if (HI64 == dyn_field->t->kind)
                        {
                            dyn_field->v.i64 = attrElem.GetVariantValue(VariantType::VAR_INT).GetInt64();
                          //  printf("%s %d %s %ld \n", __FUNCTION__, __LINE__, name.CString(), dyn_field->v.i64);
                        }
                        else if (HF32 == dyn_field->t->kind)
                        {
                            float var = attrElem.GetVariantValue(VariantType::VAR_FLOAT).GetFloat();
                            dyn_field->v.f = var;
                         //   printf("%s %d %s %f %f \n", __FUNCTION__, __LINE__, name.CString(), var, dyn_field->v.f);
                        }
                        else if (HF64 == dyn_field->t->kind)
                        {
                            double var = attrElem.GetVariantValue(VariantType::VAR_DOUBLE).GetDouble();
                            dyn_field->v.d = var;
                         //   printf("%s %d %s %f %f \n", __FUNCTION__, __LINE__, name.CString(), var, dyn_field->v.d);
                        }
                        /*
                        else if (HBOOL == dyn_field->t->kind)
                        {
                            bool var = attrElem.GetVariantValue(VariantType::VAR_BOOL).GetBool();
                            dyn_field->v.i = var;
                             printf("%s %d %s %d %d \n",__FUNCTION__,__LINE__,name.CString(),var,dyn_field->v.i);
                        }
                        */
                    }
                }
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
        //   printf("%s %d \n", __FUNCTION__, __LINE__);
        if (dyn_obj == NULL)
            return true;

        //   printf("%s %d \n", __FUNCTION__, __LINE__);
        LogicComponent::SaveXML(dest);

        std::vector<const uchar *> result;
        hl_obj_fields_internal(dyn_obj, result);

        for (int i = 0; i < result.size(); i++)
        {

            std::u16string source = std::u16string((char16_t *)result[i]);
            std::wstring_convert<std::codecvt_utf8_utf16<char16_t>, char16_t> convert;
            std::string str_name = convert.to_bytes(source);
            const char *name = str_name.c_str();
            if (String(name) == String("abstractComponent") || String(name) == String("abstractLogicComponent") || String(name) == String("_node"))
                continue;

            vdynamic *dyn_field = (vdynamic *)hl_dyn_getp(dyn_obj, hl_hash_utf8(name), &hlt_dyn);

            if (dyn_field != NULL)
            {
                //      printf("%s %d %s %d \n", __FUNCTION__, __LINE__, name, dyn_field->t->kind);
                if (HABSTRACT == dyn_field->t->kind && dyn_field->v.ptr != NULL && ((hl_urho3d_structure *)dyn_field->v.ptr)->hash != 0)
                {
                    if (IsAbstractType(dyn_field, "hl_urho3d_math_vector2"))
                    {
                        XMLElement attrElem = dest.CreateChild("attribute");
                        attrElem.SetAttribute("name", name);
                        hl_urho3d_math_vector2 *hl_urho3d_obj = (hl_urho3d_math_vector2 *)dyn_field->v.ptr;
                        attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                    }
                    else if (IsAbstractType(dyn_field, "hl_urho3d_intvector2"))
                    {
                        XMLElement attrElem = dest.CreateChild("attribute");
                        attrElem.SetAttribute("name", name);
                        hl_urho3d_intvector2 *hl_urho3d_obj = (hl_urho3d_intvector2 *)dyn_field->v.ptr;
                        attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                    }
                    else if (IsAbstractType(dyn_field, "hl_urho3d_math_vector3"))
                    {
                        XMLElement attrElem = dest.CreateChild("attribute");
                        attrElem.SetAttribute("name", name);
                        hl_urho3d_math_vector3 *hl_urho3d_obj = (hl_urho3d_math_vector3 *)dyn_field->v.ptr;
                        attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                    }
                    else if (IsAbstractType(dyn_field, "hl_urho3d_math_quaternion"))
                    {
                        XMLElement attrElem = dest.CreateChild("attribute");
                        attrElem.SetAttribute("name", name);
                        hl_urho3d_math_quaternion *hl_urho3d_obj = (hl_urho3d_math_quaternion *)dyn_field->v.ptr;
                        attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                    }
                    else if (IsAbstractType(dyn_field, "hl_urho3d_color"))
                    {
                        XMLElement attrElem = dest.CreateChild("attribute");
                        attrElem.SetAttribute("name", name);
                        hl_urho3d_color *hl_urho3d_obj = (hl_urho3d_color *)dyn_field->v.ptr;
                        attrElem.SetVariantValue(*(hl_urho3d_obj->ptr));
                    }
                }
                else if (HUI8 == dyn_field->t->kind)
                {
                    XMLElement attrElem = dest.CreateChild("attribute");
                    attrElem.SetAttribute("name", name);
                    attrElem.SetVariantValue((dyn_field->v.ui8));
                }
                else if (HUI16 == dyn_field->t->kind)
                {
                    XMLElement attrElem = dest.CreateChild("attribute");
                    attrElem.SetAttribute("name", name);
                    attrElem.SetVariantValue((dyn_field->v.ui16));
                }
                else if (HI32 == dyn_field->t->kind)
                {
                    XMLElement attrElem = dest.CreateChild("attribute");
                    attrElem.SetAttribute("name", name);
                    attrElem.SetVariantValue((dyn_field->v.i));
                }
                else if (HI64 == dyn_field->t->kind)
                {
                    XMLElement attrElem = dest.CreateChild("attribute");
                    attrElem.SetAttribute("name", name);
                    attrElem.SetVariantValue((dyn_field->v.i64));
                }
                else if (HF32 == dyn_field->t->kind)
                {
                    XMLElement attrElem = dest.CreateChild("attribute");
                    attrElem.SetAttribute("name", name);
                    attrElem.SetVariantValue((dyn_field->v.f));
                }
                else if (HF64 == dyn_field->t->kind)
                {
                    XMLElement attrElem = dest.CreateChild("attribute");
                    attrElem.SetAttribute("name", name);
                    attrElem.SetVariantValue((dyn_field->v.d));
                }
                /* TBD ELI ,casuing crash during loading
                else if (HBOOL == dyn_field->t->kind)
                {
                    XMLElement attrElem = dest.CreateChild("attribute");
                    attrElem.SetAttribute("name", name);
                    attrElem.SetVariantValue((dyn_field->v.b));
                }
                */
            }
        }

    done:
        // printf("%s %d \n", __FUNCTION__, __LINE__);
        return true;
    }

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

vdynamic *GetDynamicHashLinkLogicComponent(Node *node, const char *type, bool recursive)
{

    PODVector<Component *> components;
    node->GetComponents(components, "HashLinkLogicComponent", recursive);
    for (PODVector<Component *>::Iterator component = components.Begin(); component != components.End(); ++component)
    {
        HashLinkLogicComponent *logic_comp = dynamic_cast<HashLinkLogicComponent *>(*component);
        if (logic_comp && logic_comp->GetClassName() == String(type))
        {
            //    printf("GetDynamicHashLinkLogicComponent dyn_obj:%p \n", logic_comp->dyn_obj);
            return logic_comp->dyn_obj;
        }
    }
    return NULL;
}

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

hl_urho3d_scene_logic_component *hl_local_alloc_urho3d_scene_logic_component(HashLinkLogicComponent *component)
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

HL_PRIM vbyte *HL_NAME(_scene_logic_component_get_class_name)(urho3d_context *context, hl_urho3d_scene_logic_component *component)
{
    HashLinkLogicComponent *logicComp = dynamic_cast<HashLinkLogicComponent *>(component->ptr.Get());
    if (logicComp != NULL)
    {
        return HLCreateVBString(logicComp->GetClassName());
    }
    else
    {
        return NULL;
    }
}

DEFINE_PRIM(_VOID, _scene_logic_component_register_object, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_LOGIC_COMPONENT, _scene_logic_component_create, URHO3D_CONTEXT _DYN _STRING);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_logic_component_cast_to_component, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT);
DEFINE_PRIM(HL_URHO3D_LOGIC_COMPONENT, _scene_logic_component_cast_from_component, URHO3D_CONTEXT HL_URHO3D_COMPONENT);
DEFINE_PRIM(_VOID, _scene_logic_component_set_update_event_mask, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT _I32);
DEFINE_PRIM(_I32, _scene_logic_component_get_update_event_mask, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT);

DEFINE_PRIM(_BYTES, _scene_logic_component_get_class_name, URHO3D_CONTEXT HL_URHO3D_LOGIC_COMPONENT);

/*
                                vclosure *closure = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_utf8("CreateVector3"), &hlt_dyn);
                                if (closure)
                                {
                                    
                                    vdynamic arg_x;
                                    arg_x.t = &hlt_f64;
                                    arg_x.v.d = var.x_;

                                    vdynamic arg_y;
                                    arg_y.t = &hlt_f64;
                                    arg_y.v.d = var.y_;

                                    vdynamic arg_z;
                                    arg_z.t = &hlt_f64;
                                    arg_z.v.d = var.z_;

                                    vdynamic *args[3];
                                    args[0] = &arg_x;
                                    args[1] = &arg_y;
                                    args[2] = &arg_z;
                                    vdynamic *ret = hl_dyn_call(closure, args, 3);
                                    hl_urho3d_math_vector3 *hl_vector3 = (hl_urho3d_math_vector3 *)ret->v.ptr;
                                    printf("%s %d %f %f %f\n", __FUNCTION__, __LINE__, hl_vector3->ptr->x_, hl_vector3->ptr->y_, hl_vector3->ptr->z_);
                                    
                                    //hl_dyn_setp(dyn_obj, hl_hash_utf8(name.CString()), &hlt_dyn, ret);
                                }
                                else
                                {
                                    printf("%s %d \n", __FUNCTION__, __LINE__);
                                }
                                */

/*
                                Vector3 var = attrElem.GetVariantValue(VariantType::VAR_VECTOR3).GetVector3();
                                hl_urho3d_math_vector3 *hl_var = hl_alloc_urho3d_math_vector3(var);
                                hl_add_root(&hl_var);
                                dyn_field->v.ptr = hl_var;
                                hl_dyn_setp(dyn_obj, hl_hash_utf8(name.CString()), &hlt_dyn, dyn_field);
                                */

/*
                                vclosure *closureSetField = (vclosure *)hl_dyn_getp(dyn_obj, hl_hash_utf8("SetFieldVector3"), &hlt_dyn);
                                if (closureSetField)
                                {
                                   // Vector3 var = attrElem.GetVariantValue(VariantType::VAR_VECTOR3).GetVector3();
                                   // hl_urho3d_math_vector3 *hl_var = hl_alloc_urho3d_math_vector3(var);

                                  //  hl_type hlt_vector3_abstract = {HABSTRACT, {(const uchar *)USTR("hl_urho3d_math_vector3")}};
                                    vdynamic *arg_dyn_abstract = hl_alloc_dynamic(&hlt_abstract);
                                    arg_dyn_abstract->v.ptr = hl_var;

                                    hl_buffer *b = hl_alloc_buffer();
                                    hl_buffer_str(b, (uchar *)(hl_to_utf16(name.CString())));
                                    vbyte *vbyte_name = (vbyte *)hl_buffer_content(b, NULL);
                                    vdynamic arg_vbyte_name;
                                    arg_vbyte_name.t = &hlt_bytes;
                                    arg_vbyte_name.v.bytes = vbyte_name;

                                    vdynamic *args[2];
                                    args[0] = &arg_vbyte_name;
                                    args[1] = dyn_field;
                                    hl_dyn_abstract_call(closureSetField, args, 2);
                                }
                                */

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