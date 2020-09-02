#ifndef _HL_URHO3D_GLOBAL_TYPES_
#define _HL_URHO3D_GLOBAL_TYPES_

#include "urho3d_all.inc"

// TBD ELI size should depend on platform mobile/console/PC
#define TVECTOR2_STACK_SIZE 10000
#define TINTVECTOR2_STACK_SIZE 10000
#define TVECTOR3_STACK_SIZE 10000
#define TQUATERNION_STACK_SIZE 10000
#define TCOLOR_STACK_SIZE 10000
#define TVARIANT_STACK_SIZE 10000
#define TSTRINGHASH_STACK_SIZE 10000
#define TVARIANTMAP_STACK_SIZE 10000
#define TOUCHSTATE_STACK_SIZE 100
#define T_VECTOR_BUFFER_STACK_SIZE 1000
#define T_URHO3D_T_RAY_STACK_SIZE 50


typedef void (*hl_finalizer)(void *v);

vdynamic *GetDynamicHashLinkLogicComponent(Node *node, const char *type, bool recursive=true);
void GetDynamicHashLinkLogicComponents(Node *node, const char *type,PODVector<vdynamic *> & hl_components, bool recursive=true);
void GetAllDynamicHashLinkLogicComponents(Node *node,PODVector<vdynamic *> & hl_components, bool recursive=true);

vbyte *HLCreateVBString(const String & value);
class HL_Urho3DEventHandler : public Object
{
    URHO3D_OBJECT(HL_Urho3DEventHandler, Object);

public:
    HL_Urho3DEventHandler(Context *context, vdynamic *dyn, String name) : Object(context)
    {
        dyn_obj = dyn;
        closure_name = name;
        hl_hash_name = hl_hash_utf8(closure_name.CString());
        dyn_obj_field_lookup = NULL;
    }
    vdynamic *dyn_obj;
    String closure_name;
    int hl_hash_name;
    hl_field_lookup *dyn_obj_field_lookup;
};

typedef Urho3D::Context urho3d_context;
#define URHO3D_CONTEXT _ABSTRACT(urho3d_context)

typedef Urho3D::RefCounted * urho3d_refcounted;
#define URHO3D_REFCOUNTED _ABSTRACT(urho3d_refcounted)

typedef Urho3D::Object  hl_urho3d_core_object;
#define HL_URHO3D_OBJECT _ABSTRACT(hl_urho3d_core_object)


typedef struct hl_urho3d_audio_sound
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Sound> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_audio_sound;

#define HL_URHO3D_SOUND _ABSTRACT(hl_urho3d_audio_sound)


typedef struct hl_urho3d_audio_sound_source
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::SoundSource> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_audio_sound_source;

#define HL_URHO3D_SOUND_SOURCE _ABSTRACT(hl_urho3d_audio_sound_source)



typedef struct hl_urho3d_structure
{
    void *finalizer;
    int hash;
} hl_urho3d_structure;

typedef struct hl_urho3d_color
{
    void *finalizer;
    int hash;
    Urho3D::Color *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_color;

#define HL_URHO3D_COLOR _ABSTRACT(hl_urho3d_color)
hl_urho3d_color *hl_alloc_urho3d_color(const Urho3D::Color &color);
hl_urho3d_color *hl_alloc_urho3d_color(float r = 0.0, float g = 0.0, float b = 0.0, float a = 1.0);


typedef Urho3D::Color  hl_urho3d_tcolor;
#define HL_URHO3D_TCOLOR _ABSTRACT(hl_urho3d_tcolor)
Urho3D::Color *hl_alloc_urho3d_math_tcolor(const Urho3D::Color &color);
Urho3D::Color *hl_alloc_urho3d_math_tcolor(float r = 0.0, float g = 0.0, float b = 0.0, float a = 1.0);


typedef struct hl_urho3d_intvector2
{
    void *finalizer;
    int hash;
    Urho3D::IntVector2 *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_intvector2;

#define HL_URHO3D_INTVECTOR2 _ABSTRACT(hl_urho3d_intvector2)
hl_urho3d_intvector2 *hl_alloc_urho3d_intvector2(int x = 0, int y = 0);


typedef Urho3D::IntVector2  hl_urho3d_math_tintvector2;
#define HL_URHO3D_TINTVECTOR2 _ABSTRACT(hl_urho3d_math_tintvector2)
Urho3D::IntVector2 *hl_alloc_urho3d_math_tintvector2(int x = 0, int y = 0);
Urho3D::IntVector2 *hl_alloc_urho3d_math_tintvector2(const Urho3D::IntVector2 &rhs);


typedef struct hl_urho3d_math_intrect
{
    void *finalizer;
    int hash;
    Urho3D::IntRect *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_math_intrect;

#define HL_URHO3D_INTRECT _ABSTRACT(hl_urho3d_math_intrect)
hl_urho3d_math_intrect *hl_alloc_urho3d_math_intrect(int left, int top, int right, int bottom);


typedef struct hl_urho3d_math_quaternion
{
    void *finalizer;
    int hash;
    Urho3D::Quaternion *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_math_quaternion;

#define HL_URHO3D_QUATERNION _ABSTRACT(hl_urho3d_math_quaternion)
hl_urho3d_math_quaternion *hl_alloc_urho3d_math_quaternion(float x, float y, float z);
hl_urho3d_math_quaternion *hl_alloc_urho3d_math_quaternion(const Urho3D::Quaternion &);

typedef Urho3D::Quaternion  hl_urho3d_math_tquaternion;
#define HL_URHO3D_TQUATERNION _ABSTRACT(hl_urho3d_math_tquaternion)
hl_urho3d_math_tquaternion *hl_alloc_urho3d_math_tquaternion(float x, float y, float z);
hl_urho3d_math_tquaternion *hl_alloc_urho3d_math_tquaternion(const Urho3D::Quaternion &);


typedef struct hl_urho3d_math_ray
{
    void *finalizer;
    int hash;
    Urho3D::Ray *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_math_ray;

#define HL_URHO3D_RAY _ABSTRACT(hl_urho3d_math_ray)
hl_urho3d_math_ray *hl_alloc_urho3d_math_ray(const Vector3& origin, const Vector3& direction);
hl_urho3d_math_ray *hl_alloc_urho3d_math_ray(const Ray& ray);

typedef Urho3D::Ray *  hl_urho3d_math_t_ray;
#define HL_URHO3D_T_RAY _ABSTRACT(hl_urho3d_math_t_ray)
Urho3D::Ray *hl_alloc_urho3d_math_t_ray(const Vector3& origin, const Vector3& direction);
Urho3D::Ray *hl_alloc_urho3d_math_t_ray(const Ray& ray);

typedef struct hl_urho3d_math_vector2
{
    void *finalizer;
    int hash;
    Urho3D::Vector2 *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_math_vector2;

#define HL_URHO3D_VECTOR2 _ABSTRACT(hl_urho3d_math_vector2)
hl_urho3d_math_vector2 *hl_alloc_urho3d_math_vector2(float x = 0.0, float y = 0.0);
hl_urho3d_math_vector2 *hl_alloc_urho3d_math_vector2(const Urho3D::Vector2 &);

typedef Urho3D::Vector2  hl_urho3d_math_tvector2;
#define HL_URHO3D_TVECTOR2 _ABSTRACT(hl_urho3d_math_tvector2)
Urho3D::Vector2 *hl_alloc_urho3d_math_tvector2(float x = 0.0, float y = 0.0);
Urho3D::Vector2 *hl_alloc_urho3d_math_tvector2(const Urho3D::Vector2 &rhs);

typedef struct hl_urho3d_math_vector3
{
    void *finalizer;
    int hash;
    Urho3D::Vector3 *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_math_vector3;

#define HL_URHO3D_VECTOR3 _ABSTRACT(hl_urho3d_math_vector3)
hl_urho3d_math_vector3 *hl_alloc_urho3d_math_vector3(float x = 0.0, float y = 0.0, float z = 0.0);
hl_urho3d_math_vector3 *hl_alloc_urho3d_math_vector3(const Urho3D::Vector3 &);

typedef Urho3D::Vector3  hl_urho3d_math_tvector3;
#define HL_URHO3D_TVECTOR3 _ABSTRACT(hl_urho3d_math_tvector3)
Urho3D::Vector3 *hl_alloc_urho3d_math_tvector3(float x = 0.0, float y = 0.0, float z = 0.0);
Urho3D::Vector3 *hl_alloc_urho3d_math_tvector3(const Urho3D::Vector3 &rhs);

typedef struct hl_urho3d_math_boundingbox
{
    void *finalizer;
    int hash;
    Urho3D::BoundingBox *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_math_boundingbox;

#define HL_URHO3D_BOUNDINGBOX _ABSTRACT(hl_urho3d_math_boundingbox)
hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(const Urho3D::BoundingBox &box);
hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(float x, float y);
hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(const Urho3D::Vector3 &a, const Urho3D::Vector3 &b);

typedef struct hl_urho3d_stringhash
{
    void *finalizer;
    int hash;
    Urho3D::StringHash *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_stringhash;

#define HL_URHO3D_STRINGHASH _ABSTRACT(hl_urho3d_stringhash)
hl_urho3d_stringhash *hl_alloc_urho3d_stringhash(const char *str);
hl_urho3d_stringhash *hl_alloc_urho3d_stringhash_no_finlizer();
hl_urho3d_stringhash *hl_alloc_urho3d_stringhash(Urho3D::StringHash &rhs);

typedef Urho3D::StringHash  hl_urho3d_tstringhash;
#define HL_URHO3D_TSTRINGHASH _ABSTRACT(hl_urho3d_tstringhash)
hl_urho3d_tstringhash *hl_alloc_urho3d_tstringhash(const char *str);
hl_urho3d_tstringhash *hl_alloc_urho3d_tstringhash(Urho3D::StringHash &rhs);


typedef struct hl_urho3d_variant
{
    void *finalizer;
    int hash;
    Urho3D::Variant *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_variant;

#define HL_URHO3D_VARIANT _ABSTRACT(hl_urho3d_variant)
hl_urho3d_variant *hl_alloc_urho3d_variant();
hl_urho3d_variant * hl_alloc_urho3d_variant(const Variant & rhs);


typedef Urho3D::Variant  hl_urho3d_tvariant;
#define HL_URHO3D_TVARIANT _ABSTRACT(hl_urho3d_tvariant)
hl_urho3d_tvariant *hl_alloc_urho3d_tvariant();


typedef struct hl_urho3d_variantmap
{
    void *finalizer;
    int hash;
    Urho3D::VariantMap *ptr;
    vdynamic *dyn_obj;
} hl_urho3d_variantmap;

#define HL_URHO3D_VARIANTMAP _ABSTRACT(hl_urho3d_variantmap)
hl_urho3d_variantmap *hl_alloc_urho3d_variantmap();
hl_urho3d_variantmap *hl_alloc_urho3d_variantmap_no_finlizer();

typedef Urho3D::VariantMap  hl_urho3d_tvariantmap;
#define HL_URHO3D_TVARIANTMAP _ABSTRACT(hl_urho3d_tvariantmap)
hl_urho3d_tvariantmap *hl_alloc_urho3d_tvariantmap();


typedef struct hl_urho3d_application
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Application> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_application;

#define HL_URHO3D_APPLICATION _ABSTRACT(hl_urho3d_application)

typedef struct hl_urho3d_resource
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Resource> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_resource;

#define HL_URHO3D_RESOURCE _ABSTRACT(hl_urho3d_resource)
hl_urho3d_resource *hl_alloc_urho3d_resource();


typedef struct hl_urho3d_resource_xml_file
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::XMLFile> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_resource_xml_file;

#define HL_URHO3D_XML_FILE _ABSTRACT(hl_urho3d_resource_xml_file)
hl_urho3d_resource_xml_file *hl_alloc_urho3d_resource_xml_file();


typedef struct hl_urho3d_texture2d
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Texture2D> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_texture2d;

#define HL_URHO3D_TEXTURE2D _ABSTRACT(hl_urho3d_texture2d)
hl_urho3d_texture2d *hl_alloc_urho3d_texture2d();
hl_urho3d_texture2d *hl_alloc_urho3d_texture2d(SharedPtr<Urho3D::Texture2D> texture2d);

typedef struct hl_urho3d_sprite
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Sprite> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_sprite;

#define HL_URHO3D_SPRITE _ABSTRACT(hl_urho3d_sprite)
hl_urho3d_sprite *hl_alloc_urho3d_sprite();

typedef struct hl_urho3d_uielement
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::UIElement> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_uielement;

#define HL_URHO3D_UIELEMENT _ABSTRACT(hl_urho3d_uielement)
hl_urho3d_uielement *hl_alloc_urho3d_uilement();
hl_urho3d_uielement *hl_alloc_urho3d_uielement(urho3d_context *context, Urho3D::UIElement *uielement);


typedef struct hl_urho3d_ui_text
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Text> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_ui_text;
#define HL_URHO3D_UI_TEXT _ABSTRACT(hl_urho3d_ui_text)


typedef struct hl_urho3d_ui_font
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Font> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_ui_font;
#define HL_URHO3D_UI_FONT _ABSTRACT(hl_urho3d_ui_font)


typedef struct hl_urho3d_scene_component
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Component> ptr;
    vdynamic *dyn_obj;
    HashMap<StringHash, SharedPtr<HL_Urho3DEventHandler>> * hl_event_closures;
} hl_urho3d_scene_component;

#define HL_URHO3D_COMPONENT _ABSTRACT(hl_urho3d_scene_component)
hl_urho3d_scene_component *hl_alloc_urho3d_scene_component();
hl_urho3d_scene_component *hl_alloc_urho3d_scene_component(Component *component);

typedef Urho3D::Component * hl_urho3d_scene_component_ptr;
#define URHO3D_COMPONENT_PTR _ABSTRACT(hl_urho3d_scene_component_ptr)


typedef struct hl_urho3d_scene_logic_component
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::LogicComponent> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_scene_logic_component;

#define HL_URHO3D_LOGIC_COMPONENT _ABSTRACT(hl_urho3d_scene_logic_component)
hl_urho3d_scene_logic_component *hl_alloc_urho3d_scene_logic_component();

typedef struct hl_urho3d_scene_node
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Node> ptr;
    vdynamic *dyn_obj;
      HashMap<StringHash, SharedPtr<HL_Urho3DEventHandler>> * hl_event_closures;
} hl_urho3d_scene_node;

#define HL_URHO3D_NODE _ABSTRACT(hl_urho3d_scene_node)
hl_urho3d_scene_node *hl_alloc_urho3d_scene_node();
hl_urho3d_scene_node *hl_alloc_urho3d_scene_node(urho3d_context *context, Node *node);
hl_urho3d_scene_node *hl_alloc_urho3d_scene_node_no_finalizer(urho3d_context *context, Node *node);

typedef Urho3D::Node * hl_urho3d_scene_t_node;
#define HL_URHO3D_T_NODE _ABSTRACT(hl_urho3d_scene_t_node)

typedef PODVector<Node *> hl_urho3d_scene_pod_node;
#define HL_URHO3D_POD_NODE _ABSTRACT(hl_urho3d_scene_pod_node)

typedef Urho3D::Node * hl_urho3d_scene_node_ptr;
#define URHO3D_NODE_PTR _ABSTRACT(hl_urho3d_scene_node_ptr)

typedef struct hl_urho3d_scene_scene
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Scene> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_scene_scene;

#define HL_URHO3D_SCENE _ABSTRACT(hl_urho3d_scene_scene)
hl_urho3d_scene_scene *hl_alloc_urho3d_scene_scene();
hl_urho3d_scene_scene *hl_alloc_urho3d_scene_scene_no_finalizer(urho3d_context *context,Scene *scene);

//ValueAnimation
typedef struct hl_urho3d_scene_value_animation
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::ValueAnimation> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_scene_value_animation;

#define HL_URHO3D_VALUE_ANIMATION _ABSTRACT(hl_urho3d_scene_value_animation)
hl_urho3d_scene_value_animation *hl_alloc_urho3d_scene_value_animation(urho3d_context *context, ValueAnimation * va);



typedef struct hl_urho3d_graphics_animation
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Animation> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_animation;

#define HL_URHO3D_ANIMATION _ABSTRACT(hl_urho3d_graphics_animation)
hl_urho3d_graphics_animation *hl_alloc_urho3d_graphics_animation(urho3d_context *context);
hl_urho3d_graphics_animation *hl_alloc_urho3d_graphics_animation(Animation *animtion);


//AnimationController
typedef struct hl_urho3d_graphics_animation_controller
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::AnimationController> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_animation_controller;

#define HL_URHO3D_ANIMATION_CONTROLLER _ABSTRACT(hl_urho3d_graphics_animation_controller)
hl_urho3d_graphics_animation_controller *hl_alloc_urho3d_graphics_animation_controller(urho3d_context *context);
hl_urho3d_graphics_animation_controller *hl_alloc_urho3d_graphics_animation_controller(AnimationController *animtion);

/*
typedef struct hl_urho3d_graphics_animation_state
{
    void *finalizer;
    SharedPtr<Urho3D::AnimationState> ptr;
} hl_urho3d_graphics_animation_state;

#define HL_URHO3D_ANIMATION_STATE _ABSTRACT(hl_urho3d_graphics_animation_state)
hl_urho3d_graphics_animation_state *hl_alloc_urho3d_graphics_animation_state(urho3d_context *context);
hl_urho3d_graphics_animation_state *hl_alloc_urho3d_graphics_animation_state(AnimationState *animtionState);
*/

typedef Urho3D::AnimationState  hl_urho3d_graphics_tanimation_state;
#define HL_URHO3D_TANIMATION_STATE _ABSTRACT(hl_urho3d_graphics_tanimation_state)
hl_urho3d_graphics_tanimation_state *hl_alloc_urho3d_graphics_tanimation_state(AnimationState *animtionState);


typedef struct hl_urho3d_graphics_animatedmodel
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::AnimatedModel> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_animatedmodel;

#define HL_URHO3D_ANIMATEDMODEL _ABSTRACT(hl_urho3d_graphics_animatedmodel)
hl_urho3d_graphics_animatedmodel *hl_alloc_urho3d_graphics_animatedmodel(urho3d_context *context);
hl_urho3d_graphics_animatedmodel *hl_alloc_urho3d_graphics_animatedmodel(AnimatedModel *model);


typedef Urho3D::Billboard hl_urho3d_graphics_billboard;
#define HL_URHO3D_BILLBOARD _ABSTRACT(hl_urho3d_graphics_billboard)

typedef PODVector<Billboard> hl_urho3d_graphics_pod_billboard;
#define HL_URHO3D_POD_BILLBOARD _ABSTRACT(hl_urho3d_graphics_pod_billboard)


typedef struct hl_urho3d_graphics_billboardset
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::BillboardSet> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_billboardset;

#define HL_URHO3D_BILLBOARDSET _ABSTRACT(hl_urho3d_graphics_billboardset)
hl_urho3d_graphics_billboardset *hl_alloc_urho3d_graphics_billboardset();
hl_urho3d_graphics_billboardset *hl_alloc_urho3d_graphics_billboardset(BillboardSet *billboardSet);


typedef struct hl_urho3d_graphics_camera
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Camera> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_camera;

#define HL_URHO3D_CAMERA _ABSTRACT(hl_urho3d_graphics_camera)
hl_urho3d_graphics_camera *hl_alloc_urho3d_graphics_camera();
hl_urho3d_graphics_camera *hl_alloc_urho3d_graphics_camera(Camera *camera);


typedef struct hl_urho3d_graphics_light_cascade_parameters
{
    void *finalizer;
    int hash;
    CascadeParameters*  ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_light_cascade_parameters;
#define HL_URHO3D_LIGHT_CASCADE_PARAMETERS _ABSTRACT(hl_urho3d_graphics_light_cascade_parameters)


typedef struct hl_urho3d_graphics_decalset
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::DecalSet> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_decalset;

#define HL_URHO3D_DECALSET _ABSTRACT(hl_urho3d_graphics_decalset)
hl_urho3d_graphics_decalset *hl_alloc_urho3d_graphics_decalset();
hl_urho3d_graphics_decalset *hl_alloc_urho3d_graphics_decalset(DecalSet *decalSet);



typedef Urho3D::Drawable  hl_urho3d_graphics_drawable;
#define HL_URHO3D_DRAWABLE _ABSTRACT(hl_urho3d_graphics_drawable)


typedef struct hl_urho3d_graphics_light
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Light> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_light;

#define HL_URHO3D_LIGHT _ABSTRACT(hl_urho3d_graphics_light)
hl_urho3d_graphics_light *hl_alloc_urho3d_graphics_light();
hl_urho3d_graphics_light *hl_alloc_urho3d_graphics_light(Light *light);


typedef struct hl_urho3d_graphics_light_bias_parameters
{
    void *finalizer;
    int hash;
    BiasParameters*  ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_light_bias_parameters;
#define HL_URHO3D_LIGHT_BIAS_PARAMETERS _ABSTRACT(hl_urho3d_graphics_light_bias_parameters)
hl_urho3d_graphics_light_bias_parameters *hl_alloc_urho3d_graphics_light_bias_parameters(const Urho3D::BiasParameters & rhs );

typedef struct hl_urho3d_graphics_material
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Material> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_material;

#define HL_URHO3D_MATERIAL _ABSTRACT(hl_urho3d_graphics_material)
hl_urho3d_graphics_material *hl_alloc_urho3d_graphics_material(urho3d_context *context, const char *name);
hl_urho3d_graphics_material *hl_alloc_urho3d_graphics_material(Material *material);

typedef struct hl_urho3d_graphics_model
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Model> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_model;

#define HL_URHO3D_MODEL _ABSTRACT(hl_urho3d_graphics_model)
hl_urho3d_graphics_model *hl_alloc_urho3d_graphics_model(urho3d_context *context, const char *name);
hl_urho3d_graphics_model *hl_alloc_urho3d_graphics_model(Model *model);


typedef Urho3D::Octree  hl_urho3d_graphics_octree;
#define HL_URHO3D_OCTREE _ABSTRACT(hl_urho3d_graphics_octree)


typedef PODVector<RayQueryResult> hl_urho3d_graphics_ray_query_results;
#define HL_URHO3D_RAY_QUERY_RESULTS _ABSTRACT(hl_urho3d_graphics_ray_query_results)

typedef RayQueryResult  hl_urho3d_graphics_ray_query_result;
#define HL_URHO3D_RAY_QUERY_RESULT _ABSTRACT(hl_urho3d_graphics_ray_query_result)


typedef struct hl_urho3d_graphics_render_path
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::RenderPath> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_render_path;

#define HL_URHO3D_RENDER_PATH _ABSTRACT(hl_urho3d_graphics_render_path)
hl_urho3d_graphics_render_path *hl_alloc_urho3d_graphics_render_path(urho3d_context *context);
hl_urho3d_graphics_render_path *hl_alloc_urho3d_graphics_render_path(Urho3D::RenderPath*);

//
typedef struct hl_urho3d_graphics_render_surface
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::RenderSurface> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_render_surface;

#define HL_URHO3D_RENDER_SURFACE _ABSTRACT(hl_urho3d_graphics_render_surface)
hl_urho3d_graphics_render_surface *hl_alloc_urho3d_graphics_render_surface(urho3d_context *context);
hl_urho3d_graphics_render_surface *hl_alloc_urho3d_graphics_render_surface(Urho3D::RenderSurface*);



typedef Urho3D::Bone   hl_urho3d_graphics_bone;
#define HL_URHO3D_BONE _ABSTRACT(hl_urho3d_graphics_bone)

typedef Urho3D::Skeleton  hl_urho3d_graphics_skeleton;
#define HL_URHO3D_SKELETON _ABSTRACT(hl_urho3d_graphics_skeleton)


typedef struct hl_urho3d_graphics_skybox
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Skybox> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_skybox;

#define HL_URHO3D_SKYBOX _ABSTRACT(hl_urho3d_graphics_skybox)
hl_urho3d_graphics_skybox *hl_alloc_urho3d_graphics_skybox(urho3d_context *context);
hl_urho3d_graphics_skybox *hl_alloc_urho3d_graphics_skybox(Skybox *obj);

typedef struct hl_urho3d_graphics_staticmodel
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::StaticModel> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_staticmodel;

#define HL_URHO3D_STATICMODEL _ABSTRACT(hl_urho3d_graphics_staticmodel)
hl_urho3d_graphics_staticmodel *hl_alloc_urho3d_graphics_staticmodel(urho3d_context *context);
hl_urho3d_graphics_staticmodel *hl_alloc_urho3d_graphics_staticmodel(StaticModel *model);

typedef struct hl_urho3d_graphics_technique
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Technique> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_technique;

#define HL_URHO3D_TECHNIQUE _ABSTRACT(hl_urho3d_graphics_technique)
hl_urho3d_graphics_technique *hl_alloc_urho3d_graphics_technique(urho3d_context *context, const char *name);
hl_urho3d_graphics_technique *hl_alloc_urho3d_graphics_technique(Technique *obj);

typedef struct hl_urho3d_graphics_texture
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Texture> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_texture;

#define HL_URHO3D_TEXTURE _ABSTRACT(hl_urho3d_graphics_texture)
hl_urho3d_graphics_texture *hl_alloc_urho3d_graphics_texture(urho3d_context *context, const char *name);
hl_urho3d_graphics_texture *hl_alloc_urho3d_graphics_texture(Urho3D::Texture*);


typedef struct hl_urho3d_graphics_viewport
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Viewport> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_viewport;

#define HL_URHO3D_VIEWPORT _ABSTRACT(hl_urho3d_graphics_viewport)
hl_urho3d_graphics_viewport *hl_alloc_urho3d_graphics_viewport(hl_urho3d_scene_scene *scene, hl_urho3d_graphics_camera *camera);
hl_urho3d_graphics_viewport *hl_alloc_urho3d_graphics_viewport(Urho3D::Viewport * vp);

typedef struct hl_urho3d_graphics_zone
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Zone> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_graphics_zone;

#define HL_URHO3D_ZONE _ABSTRACT(hl_urho3d_graphics_zone)
hl_urho3d_graphics_zone *hl_alloc_urho3d_graphics_zone();
hl_urho3d_graphics_zone *hl_alloc_urho3d_graphics_zone(Zone *zone);


typedef Urho3D::TouchState  hl_urho3d_input_touch_state;
#define HL_URHO3D_TOUCH_STATE _ABSTRACT(hl_urho3d_input_touch_state)


typedef struct hl_urho3d_io_file
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::File> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_io_file;
#define HL_URHO3D_FILE _ABSTRACT(hl_urho3d_io_file)



typedef struct hl_urho3d_io_vector_buffer
{
    void *finalizer;
    int hash;
    Urho3D::VectorBuffer * ptr;
    vdynamic *dyn_obj;
} hl_urho3d_io_vector_buffer;
hl_urho3d_io_vector_buffer *hl_alloc_urho3d_io_vector_buffer();
hl_urho3d_io_vector_buffer *hl_alloc_urho3d_io_vector_buffer(Urho3D::VectorBuffer*);
#define HL_URHO3D_VECTOR_BUFFER _ABSTRACT(hl_urho3d_io_vector_buffer)

typedef Urho3D::VectorBuffer   hl_urho3d_io_t_vector_buffer;
#define HL_URHO3D_T_VECTOR_BUFFER _ABSTRACT(hl_urho3d_io_t_vector_buffer)
Urho3D::VectorBuffer *hl_alloc_urho3d_io_t_vector_buffer(Urho3D::VectorBuffer & vb);

typedef Urho3D::MemoryBuffer   hl_urho3d_io_memory_buffer;
#define HL_URHO3D_MEMORY_BUFFER _ABSTRACT(hl_urho3d_io_memory_buffer)



//Constraint
typedef struct hl_urho3d_physics_constraint
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::Constraint> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_physics_constraint;

#define HL_URHO3D_CONSTRAINT _ABSTRACT(hl_urho3d_physics_constraint)
hl_urho3d_physics_constraint *hl_alloc_urho3d_physics_constraint(urho3d_context *context);
hl_urho3d_physics_constraint *hl_alloc_urho3d_physics_constraint(Urho3D::Constraint*);

typedef struct hl_urho3d_physics_collision_shape
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::CollisionShape> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_physics_collision_shape;

#define HL_URHO3D_COLLISION_SHAPE _ABSTRACT(hl_urho3d_physics_collision_shape)
hl_urho3d_physics_collision_shape *hl_alloc_urho3d_physics_collision_shape(urho3d_context *context);
hl_urho3d_physics_collision_shape *hl_alloc_urho3d_physics_collision_shape(Urho3D::CollisionShape*);

typedef Urho3D::PhysicsRaycastResult  hl_urho3d_physics_raycast_result;
#define HL_URHO3D_PHYSICS_RAYCAST_RESULT _ABSTRACT(hl_urho3d_physics_raycast_result)
Urho3D::PhysicsRaycastResult *hl_alloc_urho3d_physics_raycast_result();

typedef Urho3D::PhysicsWorld  hl_urho3d_physics_physics_world;
#define HL_URHO3D_PHYSICS_WORLD _ABSTRACT(hl_urho3d_physics_physics_world)


typedef struct hl_urho3d_physics_rigid_body
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::RigidBody> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_physics_rigid_body;

#define HL_URHO3D_RIGID_BODY _ABSTRACT(hl_urho3d_physics_rigid_body)
hl_urho3d_physics_rigid_body *hl_alloc_urho3d_physics_rigid_body(urho3d_context *context);
hl_urho3d_physics_rigid_body *hl_alloc_urho3d_physics_rigid_body(Urho3D::RigidBody*);


typedef Urho3D::RigidBody  hl_urho3d_physics_t_rigid_body;
#define HL_URHO3D_T_RIGID_BODY _ABSTRACT(hl_urho3d_physics_t_rigid_body)

//urho3d_urho2d_particle_emitter2d

typedef struct hl_urho3d_urho2d_particle_emitter2d
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::ParticleEmitter2D> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_urho2d_particle_emitter2d;

#define HL_URHO3D_PARTICLE_EMITTER_2D _ABSTRACT(hl_urho3d_urho2d_particle_emitter2d)


typedef struct hl_urho3d_urho2d_particle_effect2d
{
    void *finalizer;
    int hash;
    SharedPtr<Urho3D::ParticleEffect2D> ptr;
    vdynamic *dyn_obj;
} hl_urho3d_urho2d_particle_effect2d;

#define HL_URHO3D_PARTICLE_EFFECT_2D _ABSTRACT(hl_urho3d_urho2d_particle_effect2d)
hl_urho3d_urho2d_particle_effect2d *hl_alloc_urho3d_urho2d_particle_effect2d(Urho3D::ParticleEffect2D *obj);

#endif
