#ifndef _HL_URHO3D_GLOBAL_TYPES_
#define _HL_URHO3D_GLOBAL_TYPES_

#include "urho3d_all.h"

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

typedef void (*hl_finalizer)(void *v);

typedef Urho3D::Context urho3d_context;
#define URHO3D_CONTEXT _ABSTRACT(urho3d_context)

typedef struct hl_urho3d_color
{
    void *finalizer;
    Urho3D::Color *ptr;
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
    Urho3D::IntVector2 *ptr;
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
    Urho3D::IntRect *ptr;
} hl_urho3d_math_intrect;

#define HL_URHO3D_INTRECT _ABSTRACT(hl_urho3d_math_intrect)
hl_urho3d_math_intrect *hl_alloc_urho3d_math_intrect(int left, int top, int right, int bottom);


typedef struct hl_urho3d_math_quaternion
{
    void *finalizer;
    Urho3D::Quaternion *ptr;
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
    Urho3D::Ray *ptr;
} hl_urho3d_math_ray;

#define HL_URHO3D_RAY _ABSTRACT(hl_urho3d_math_ray)
hl_urho3d_math_ray *hl_alloc_urho3d_math_ray(const Vector3& origin, const Vector3& direction);
hl_urho3d_math_ray *hl_alloc_urho3d_math_ray(const Ray& ray);

typedef struct hl_urho3d_math_vector2
{
    void *finalizer;
    Urho3D::Vector2 *ptr;
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
    Urho3D::Vector3 *ptr;
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
    Urho3D::BoundingBox *ptr;
} hl_urho3d_math_boundingbox;

#define HL_URHO3D_BOUNDINGBOX _ABSTRACT(hl_urho3d_math_boundingbox)
hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(const Urho3D::BoundingBox &box);
hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(float x, float y);
hl_urho3d_math_boundingbox *hl_alloc_urho3d_math_boundingbox(const Urho3D::Vector3 &a, const Urho3D::Vector3 &b);

typedef struct hl_urho3d_stringhash
{
    void *finalizer;
    Urho3D::StringHash *ptr;
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
    Urho3D::Variant *ptr;
} hl_urho3d_variant;

#define HL_URHO3D_VARIANT _ABSTRACT(hl_urho3d_variant)
hl_urho3d_variant *hl_alloc_urho3d_variant();
hl_urho3d_variant * hl_alloc_urho3d_variant(Variant & rhs);


typedef Urho3D::Variant  hl_urho3d_tvariant;
#define HL_URHO3D_TVARIANT _ABSTRACT(hl_urho3d_tvariant)
hl_urho3d_tvariant *hl_alloc_urho3d_tvariant();


typedef struct hl_urho3d_variantmap
{
    void *finalizer;
    Urho3D::VariantMap *ptr;
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
    SharedPtr<Urho3D::Application> ptr;
} hl_urho3d_application;

#define HL_URHO3D_APPLICATION _ABSTRACT(hl_urho3d_application)

typedef struct hl_urho3d_resource
{
    void *finalizer;
    SharedPtr<Urho3D::Resource> ptr;
} hl_urho3d_resource;

#define HL_URHO3D_RESOURCE _ABSTRACT(hl_urho3d_resource)
hl_urho3d_resource *hl_alloc_urho3d_resource();


typedef struct hl_urho3d_resource_xml_file
{
    void *finalizer;
    SharedPtr<Urho3D::XMLFile> ptr;
} hl_urho3d_resource_xml_file;

#define HL_URHO3D_XML_FILE _ABSTRACT(hl_urho3d_resource_xml_file)
hl_urho3d_resource_xml_file *hl_alloc_urho3d_resource_xml_file();


typedef struct hl_urho3d_texture2d
{
    void *finalizer;
    SharedPtr<Urho3D::Texture2D> ptr;
} hl_urho3d_texture2d;

#define HL_URHO3D_TEXTURE2D _ABSTRACT(hl_urho3d_texture2d)
hl_urho3d_texture2d *hl_alloc_urho3d_texture2d();
hl_urho3d_texture2d *hl_alloc_urho3d_texture2d(SharedPtr<Urho3D::Texture2D> texture2d);

typedef struct hl_urho3d_sprite
{
    void *finalizer;
    SharedPtr<Urho3D::Sprite> ptr;
} hl_urho3d_sprite;

#define HL_URHO3D_SPRITE _ABSTRACT(hl_urho3d_sprite)
hl_urho3d_sprite *hl_alloc_urho3d_sprite();

typedef struct hl_urho3d_uielement
{
    void *finalizer;
    SharedPtr<Urho3D::UIElement> ptr;
} hl_urho3d_uielement;

#define HL_URHO3D_UIELEMENT _ABSTRACT(hl_urho3d_uielement)
hl_urho3d_uielement *hl_alloc_urho3d_uilement();
hl_urho3d_uielement *hl_alloc_urho3d_uielement(urho3d_context *context, Urho3D::UIElement *uielement);

typedef struct hl_urho3d_scene_component
{
    void *finalizer;
    SharedPtr<Urho3D::Component> ptr;
} hl_urho3d_scene_component;

#define HL_URHO3D_COMPONENT _ABSTRACT(hl_urho3d_scene_component)
hl_urho3d_scene_component *hl_alloc_urho3d_scene_component();
hl_urho3d_scene_component *hl_alloc_urho3d_scene_component(Component *component);

typedef struct hl_urho3d_scene_logic_component
{
    void *finalizer;
    SharedPtr<Urho3D::LogicComponent> ptr;
} hl_urho3d_scene_logic_component;

#define HL_URHO3D_LOGIC_COMPONENT _ABSTRACT(hl_urho3d_scene_logic_component)
hl_urho3d_scene_logic_component *hl_alloc_urho3d_scene_logic_component();

typedef struct hl_urho3d_scene_node
{
    void *finalizer;
    SharedPtr<Urho3D::Node> ptr;
} hl_urho3d_scene_node;

#define HL_URHO3D_NODE _ABSTRACT(hl_urho3d_scene_node)
hl_urho3d_scene_node *hl_alloc_urho3d_scene_node();
hl_urho3d_scene_node *hl_alloc_urho3d_scene_node(urho3d_context *context, Node *node);

typedef PODVector<Node *> hl_urho3d_scene_pod_node;
#define HL_URHO3D_POD_NODE _ABSTRACT(hl_urho3d_scene_pod_node)

typedef struct hl_urho3d_scene_scene
{
    void *finalizer;
    SharedPtr<Urho3D::Scene> ptr;
} hl_urho3d_scene_scene;

#define HL_URHO3D_SCENE _ABSTRACT(hl_urho3d_scene_scene)
hl_urho3d_scene_scene *hl_alloc_urho3d_scene_scene();




typedef struct hl_urho3d_graphics_animation
{
    void *finalizer;
    SharedPtr<Urho3D::Animation> ptr;
} hl_urho3d_graphics_animation;

#define HL_URHO3D_ANIMATION _ABSTRACT(hl_urho3d_graphics_animation)
hl_urho3d_graphics_animation *hl_alloc_urho3d_graphics_animation(urho3d_context *context);
hl_urho3d_graphics_animation *hl_alloc_urho3d_graphics_animation(Animation *animtion);

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

typedef Urho3D::AnimationState*  hl_urho3d_graphics_tanimation_state;
#define HL_URHO3D_TANIMATION_STATE _ABSTRACT(hl_urho3d_graphics_tanimation_state)
hl_urho3d_graphics_tanimation_state *hl_alloc_urho3d_graphics_tanimation_state(AnimationState *animtionState);


typedef struct hl_urho3d_graphics_animatedmodel
{
    void *finalizer;
    SharedPtr<Urho3D::AnimatedModel> ptr;
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
    SharedPtr<Urho3D::BillboardSet> ptr;
} hl_urho3d_graphics_billboardset;

#define HL_URHO3D_BILLBOARDSET _ABSTRACT(hl_urho3d_graphics_billboardset)
hl_urho3d_graphics_billboardset *hl_alloc_urho3d_graphics_billboardset();
hl_urho3d_graphics_billboardset *hl_alloc_urho3d_graphics_billboardset(BillboardSet *billboardSet);


typedef struct hl_urho3d_graphics_camera
{
    void *finalizer;
    SharedPtr<Urho3D::Camera> ptr;
} hl_urho3d_graphics_camera;

#define HL_URHO3D_CAMERA _ABSTRACT(hl_urho3d_graphics_camera)
hl_urho3d_graphics_camera *hl_alloc_urho3d_graphics_camera();
hl_urho3d_graphics_camera *hl_alloc_urho3d_graphics_camera(Camera *camera);


typedef struct hl_urho3d_graphics_light_cascade_parameters
{
    void *finalizer;
    CascadeParameters*  ptr;
} hl_urho3d_graphics_light_cascade_parameters;
#define HL_URHO3D_LIGHT_CASCADE_PARAMETERS _ABSTRACT(hl_urho3d_graphics_light_cascade_parameters)


typedef struct hl_urho3d_graphics_decalset
{
    void *finalizer;
    SharedPtr<Urho3D::DecalSet> ptr;
} hl_urho3d_graphics_decalset;

#define HL_URHO3D_DECALSET _ABSTRACT(hl_urho3d_graphics_decalset)
hl_urho3d_graphics_decalset *hl_alloc_urho3d_graphics_decalset();
hl_urho3d_graphics_decalset *hl_alloc_urho3d_graphics_decalset(DecalSet *decalSet);



typedef Urho3D::Drawable  hl_urho3d_graphics_drawable;
#define HL_URHO3D_DRAWABLE _ABSTRACT(hl_urho3d_graphics_drawable)


typedef struct hl_urho3d_graphics_light
{
    void *finalizer;
    SharedPtr<Urho3D::Light> ptr;
} hl_urho3d_graphics_light;

#define HL_URHO3D_LIGHT _ABSTRACT(hl_urho3d_graphics_light)
hl_urho3d_graphics_light *hl_alloc_urho3d_graphics_light();
hl_urho3d_graphics_light *hl_alloc_urho3d_graphics_light(Light *light);


typedef struct hl_urho3d_graphics_light_bias_parameters
{
    void *finalizer;
    BiasParameters*  ptr;
} hl_urho3d_graphics_light_bias_parameters;
#define HL_URHO3D_LIGHT_BIAS_PARAMETERS _ABSTRACT(hl_urho3d_graphics_light_bias_parameters)

typedef struct hl_urho3d_graphics_material
{
    void *finalizer;
    SharedPtr<Urho3D::Material> ptr;
} hl_urho3d_graphics_material;

#define HL_URHO3D_MATERIAL _ABSTRACT(hl_urho3d_graphics_material)
hl_urho3d_graphics_material *hl_alloc_urho3d_graphics_material(urho3d_context *context, const char *name);
hl_urho3d_graphics_material *hl_alloc_urho3d_graphics_material(Material *material);

typedef struct hl_urho3d_graphics_model
{
    void *finalizer;
    SharedPtr<Urho3D::Model> ptr;
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
    SharedPtr<Urho3D::RenderPath> ptr;
} hl_urho3d_graphics_render_path;

#define HL_URHO3D_RENDER_PATH _ABSTRACT(hl_urho3d_graphics_render_path)
hl_urho3d_graphics_render_path *hl_alloc_urho3d_graphics_render_path(urho3d_context *context);
hl_urho3d_graphics_render_path *hl_alloc_urho3d_graphics_render_path(Urho3D::RenderPath*);

typedef struct hl_urho3d_graphics_staticmodel
{
    void *finalizer;
    SharedPtr<Urho3D::StaticModel> ptr;
} hl_urho3d_graphics_staticmodel;

#define HL_URHO3D_STATICMODEL _ABSTRACT(hl_urho3d_graphics_staticmodel)
hl_urho3d_graphics_staticmodel *hl_alloc_urho3d_graphics_staticmodel(urho3d_context *context);
hl_urho3d_graphics_staticmodel *hl_alloc_urho3d_graphics_staticmodel(StaticModel *model);


typedef struct hl_urho3d_graphics_texture
{
    void *finalizer;
    SharedPtr<Urho3D::Texture> ptr;
} hl_urho3d_graphics_texture;

#define HL_URHO3D_TEXTURE _ABSTRACT(hl_urho3d_graphics_texture)
hl_urho3d_graphics_texture *hl_alloc_urho3d_graphics_texture(urho3d_context *context, const char *name);
hl_urho3d_graphics_texture *hl_alloc_urho3d_graphics_texture(Urho3D::Texture*);


typedef struct hl_urho3d_graphics_viewport
{
    void *finalizer;
    SharedPtr<Urho3D::Viewport> ptr;
} hl_urho3d_graphics_viewport;

#define HL_URHO3D_VIEWPORT _ABSTRACT(hl_urho3d_graphics_viewport)
hl_urho3d_graphics_viewport *hl_alloc_urho3d_graphics_viewport(hl_urho3d_scene_scene *scene, hl_urho3d_graphics_camera *camera);
hl_urho3d_graphics_viewport *hl_alloc_urho3d_graphics_viewport(Urho3D::Viewport * vp);

typedef struct hl_urho3d_graphics_zone
{
    void *finalizer;
    SharedPtr<Urho3D::Zone> ptr;
} hl_urho3d_graphics_zone;

#define HL_URHO3D_ZONE _ABSTRACT(hl_urho3d_graphics_zone)
hl_urho3d_graphics_zone *hl_alloc_urho3d_graphics_zone();
hl_urho3d_graphics_zone *hl_alloc_urho3d_graphics_zone(Zone *zone);


typedef Urho3D::TouchState*  hl_urho3d_input_touch_state;
#define HL_URHO3D_TOUCH_STATE _ABSTRACT(hl_urho3d_input_touch_state)

#endif
