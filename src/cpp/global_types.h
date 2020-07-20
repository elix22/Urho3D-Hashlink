#ifndef _HL_URHO3D_GLOBAL_TYPES_
#define _HL_URHO3D_GLOBAL_TYPES_

#include <Urho3D/Urho3DAll.h>


typedef void (* hl_finalizer)(void * v);

typedef  Urho3D::Context urho3d_context;
#define URHO3D_CONTEXT _ABSTRACT(urho3d_context)


typedef struct hl_urho3d_color
{
    void * finalizer;
    Urho3D::Color  * ptr;
}hl_urho3d_color;

#define HL_URHO3D_COLOR _ABSTRACT(hl_urho3d_color)
hl_urho3d_color * hl_alloc_urho3d_color(float r=0.0,float g=0.0,float b=0.0,float a=1.0);


typedef struct hl_urho3d_intvector2
{
    void * finalizer;
    Urho3D::IntVector2  * ptr;
}hl_urho3d_intvector2;

#define HL_URHO3D_INTVECTOR2 _ABSTRACT(hl_urho3d_intvector2)
hl_urho3d_intvector2 * hl_alloc_urho3d_intvector2(int x=0,int y=0);


typedef struct hl_urho3d_math_vector2
{
    void * finalizer;
    Urho3D::Vector2  * ptr;
}hl_urho3d_math_vector2;

#define HL_URHO3D_VECTOR2 _ABSTRACT(hl_urho3d_math_vector2)
hl_urho3d_math_vector2 * hl_alloc_urho3d_math_vector2(float x=0.0,float y=0.0);
hl_urho3d_math_vector2 * hl_alloc_urho3d_math_vector2(const Urho3D::Vector2 &);


typedef struct hl_urho3d_math_vector3
{
    void * finalizer;
    Urho3D::Vector3  * ptr;
}hl_urho3d_math_vector3;

#define HL_URHO3D_VECTOR3 _ABSTRACT(hl_urho3d_math_vector3)
hl_urho3d_math_vector3 * hl_alloc_urho3d_math_vector3(float x=0.0,float y=0.0,float z=0.0);
hl_urho3d_math_vector3 * hl_alloc_urho3d_math_vector3(const Urho3D::Vector3 &);



typedef struct hl_urho3d_math_boundingbox
{
    void * finalizer;
    Urho3D::BoundingBox  * ptr;
}hl_urho3d_math_boundingbox;

#define HL_URHO3D_BOUNDINGBOX _ABSTRACT(hl_urho3d_math_boundingbox)
hl_urho3d_math_boundingbox * hl_alloc_urho3d_math_boundingbox(float x,float y);
hl_urho3d_math_boundingbox * hl_alloc_urho3d_math_boundingbox(const Urho3D::Vector3 & a,const Urho3D::Vector3 & b);



typedef struct hl_urho3d_stringhash
{
    void * finalizer;
    Urho3D::StringHash  * ptr;
}hl_urho3d_stringhash;

#define HL_URHO3D_STRINGHASH _ABSTRACT(hl_urho3d_stringhash)
hl_urho3d_stringhash * hl_alloc_urho3d_stringhash(const char* str);
hl_urho3d_stringhash * hl_alloc_urho3d_stringhash_no_finlizer();



typedef struct hl_urho3d_variant
{
    void * finalizer;
    Urho3D::Variant  * ptr;
}hl_urho3d_variant;

#define HL_URHO3D_VARIANT _ABSTRACT(hl_urho3d_variant)
hl_urho3d_variant * hl_alloc_urho3d_variant();


typedef struct hl_urho3d_variantmap
{
    void * finalizer;
    Urho3D::VariantMap * ptr;
}hl_urho3d_variantmap;

#define HL_URHO3D_VARIANTMAP _ABSTRACT(hl_urho3d_variantmap)
hl_urho3d_variantmap * hl_alloc_urho3d_variantmap();
hl_urho3d_variantmap * hl_alloc_urho3d_variantmap_no_finlizer();


typedef struct hl_urho3d_application
{
    void * finalizer;
    SharedPtr<Urho3D::Application> ptr;
}hl_urho3d_application;

#define HL_URHO3D_APPLICATION _ABSTRACT(hl_urho3d_application)



typedef struct hl_urho3d_resource
{
    void * finalizer;
    SharedPtr<Urho3D::Resource> ptr;
}hl_urho3d_resource;

#define HL_URHO3D_RESOURCE _ABSTRACT(hl_urho3d_resource)
hl_urho3d_resource * hl_alloc_urho3d_resource();


typedef struct hl_urho3d_texture2d
{
    void * finalizer;
    SharedPtr<Urho3D::Texture2D>   ptr;
}hl_urho3d_texture2d;

#define HL_URHO3D_TEXTURE2D _ABSTRACT(hl_urho3d_texture2d)
hl_urho3d_texture2d * hl_alloc_urho3d_texture2d();
hl_urho3d_texture2d * hl_alloc_urho3d_texture2d(SharedPtr<Urho3D::Texture2D> texture2d);


typedef struct hl_urho3d_sprite
{
    void * finalizer;
    SharedPtr<Urho3D::Sprite> ptr;
}hl_urho3d_sprite;

#define HL_URHO3D_SPRITE _ABSTRACT(hl_urho3d_sprite)
hl_urho3d_sprite * hl_alloc_urho3d_sprite();



typedef struct hl_urho3d_uielement
{
    void * finalizer;
    SharedPtr<Urho3D::UIElement> ptr;
}hl_urho3d_uielement;

#define HL_URHO3D_UIELEMENT _ABSTRACT(hl_urho3d_uielement)
hl_urho3d_uielement * hl_alloc_urho3d_uilement();
hl_urho3d_uielement * hl_alloc_urho3d_uielement(urho3d_context *context, Urho3D::UIElement * uielement );




typedef struct hl_urho3d_scene_component
{
    void * finalizer;
    SharedPtr<Urho3D::Component> ptr;
}hl_urho3d_scene_component;

#define HL_URHO3D_COMPONENT _ABSTRACT(hl_urho3d_scene_component)
hl_urho3d_scene_component * hl_alloc_urho3d_scene_component();
hl_urho3d_scene_component *hl_alloc_urho3d_scene_component(Component *component);



typedef struct hl_urho3d_scene_node
{
    void * finalizer;
    SharedPtr<Urho3D::Node> ptr;
}hl_urho3d_scene_node;

#define HL_URHO3D_NODE _ABSTRACT(hl_urho3d_scene_node)
hl_urho3d_scene_node * hl_alloc_urho3d_scene_node();
hl_urho3d_scene_node *hl_alloc_urho3d_scene_node(urho3d_context *context, Node * node);


typedef struct hl_urho3d_scene_scene
{
    void * finalizer;
    SharedPtr<Urho3D::Scene> ptr;
}hl_urho3d_scene_scene;

#define HL_URHO3D_SCENE _ABSTRACT(hl_urho3d_scene_scene)
hl_urho3d_scene_scene * hl_alloc_urho3d_scene_scene();



typedef struct hl_urho3d_graphics_zone
{
    void * finalizer;
    SharedPtr<Urho3D::Zone> ptr;
}hl_urho3d_graphics_zone;

#define HL_URHO3D_ZONE _ABSTRACT(hl_urho3d_graphics_zone)
hl_urho3d_graphics_zone * hl_alloc_urho3d_graphics_zone();
hl_urho3d_graphics_zone *hl_alloc_urho3d_graphics_zone(Zone *zone);




#endif