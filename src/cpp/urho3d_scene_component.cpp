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

void subscribeToEvent(urho3d_context *context,Urho3D::Object *object, hl_urho3d_scene_component *hl_ptr, hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
{
    if (stringhash)
    {
        Urho3D::StringHash *urho3d_stringhash = stringhash->ptr;
        if (urho3d_stringhash)
        {

            const char *closure_name = (char *)hl_to_utf8(str->bytes);
            (*(hl_ptr->hl_event_closures))[*urho3d_stringhash] = new HL_Urho3DEventHandler(context, dyn_obj, String(closure_name));
            hl_ptr->ptr->SubscribeToEvent(
                object,
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
                                ((void (*)(vdynamic *, vdynamic *, vdynamic *))closure.fun)((vdynamic *)closure.value, (vdynamic *)(*(void **)(&dyn_urho3d_stringhash->v)), (vdynamic *)(*(void **)(&dyn_urho3d_variantmap->v)));
                            }
                        }
                    }
                },
                hl_ptr);
        }
    }

}

void subscribeToEvent(urho3d_context *context, hl_urho3d_scene_component *hl_ptr, hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
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

void finalize_urho3d_scene_component(void *v)
{
    hl_urho3d_scene_component *hl_ptr = (hl_urho3d_scene_component *)v;
    if (hl_ptr)
    {
        hl_ptr->hl_event_closures->Clear();
        delete (hl_ptr->hl_event_closures);

        if (hl_ptr->ptr)
        {

            hl_ptr->ptr->UnsubscribeFromEvents(hl_ptr);

            // printf("finalize_urho3d_scene_component %d %s \n",hl_ptr->ptr->Refs(), hl_ptr->ptr->GetTypeName().CString());

            if (hl_ptr->ptr->Refs() <= 1)
            {
                hl_ptr->ptr->UnsubscribeFromAllEvents();
            }

            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_scene_component *hl_alloc_urho3d_scene_component(urho3d_context *context)
{

    //  printf("%s %d \n",__FUNCTION__,__LINE__);
    hl_urho3d_scene_component *p = (hl_urho3d_scene_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_component));
    memset(p, 0, sizeof(hl_urho3d_scene_component));
    p->finalizer = (void *)finalize_urho3d_scene_component;
    p->ptr = new Component(context);
    p->hl_event_closures = new HashMap<StringHash, SharedPtr<HL_Urho3DEventHandler>>();
    return p;
}

hl_urho3d_scene_component *hl_alloc_urho3d_scene_component(Component *component)
{

    //   printf("%s %d \n",__FUNCTION__,__LINE__);
    hl_urho3d_scene_component *p = (hl_urho3d_scene_component *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_scene_component));
    memset(p, 0, sizeof(hl_urho3d_scene_component));
    p->finalizer = (void *)finalize_urho3d_scene_component;
    p->ptr = component;
    p->hl_event_closures = new HashMap<StringHash, SharedPtr<HL_Urho3DEventHandler>>();
    return p;
}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_scene_component_create)(urho3d_context *context)
{
    printf("_scene_component_create \n");
    hl_urho3d_scene_component *v = hl_alloc_urho3d_scene_component(context);
    return v;
}

HL_PRIM hl_urho3d_scene_node *HL_NAME(_scene_component_get_node)(urho3d_context *context, hl_urho3d_scene_component *component)
{
    return hl_alloc_urho3d_scene_node(context, component->ptr->GetNode());
}

HL_PRIM void HL_NAME(_scene_component_subscribe_to_event)(urho3d_context *context, hl_urho3d_scene_component *component, hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
{
    subscribeToEvent(context, component, stringhash, dyn_obj, str);
}

HL_PRIM void HL_NAME(_scene_component_subscribe_to_event_sender)(urho3d_context *context,Urho3D::Object * object, hl_urho3d_scene_component *component, hl_urho3d_stringhash *stringhash, vdynamic *dyn_obj, vstring *str)
{
    subscribeToEvent(context,object, component, stringhash, dyn_obj, str);
}

DEFINE_PRIM(HL_URHO3D_COMPONENT, _scene_component_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_NODE, _scene_component_get_node, URHO3D_CONTEXT HL_URHO3D_COMPONENT);
DEFINE_PRIM(_VOID, _scene_component_subscribe_to_event, URHO3D_CONTEXT HL_URHO3D_COMPONENT HL_URHO3D_STRINGHASH _DYN _STRING);
DEFINE_PRIM(_VOID, _scene_component_subscribe_to_event_sender, URHO3D_CONTEXT HL_URHO3D_OBJECT HL_URHO3D_COMPONENT HL_URHO3D_STRINGHASH _DYN _STRING);
