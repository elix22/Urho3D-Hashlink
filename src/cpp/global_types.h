
#include <Urho3D/Urho3DAll.h>


typedef void (* hl_finalizer)(void * v);

typedef  Urho3D::Context urho3d_context;
#define URHO3D_CONTEXT _ABSTRACT(urho3d_context)



typedef struct hl_urho3d_vector2
{
    void * finalizer;
    Urho3D::Vector2  * ptr;
}hl_urho3d_vector2;

#define HL_URHO3D_VECTOR2 _ABSTRACT(hl_urho3d_vector2)
hl_urho3d_vector2 * hl_alloc_urho3d_vector2();


typedef struct hl_urho3d_stringhash
{
    void * finalizer;
    Urho3D::StringHash  * ptr;
}hl_urho3d_stringhash;

#define HL_URHO3D_STRINGHASH _ABSTRACT(hl_urho3d_stringhash)
hl_urho3d_stringhash * hl_alloc_urho3d_stringhash(const char* str);



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
    Urho3D::VariantMap  * ptr;
}hl_urho3d_variantmap;

#define HL_URHO3D_VARIANTMAP _ABSTRACT(hl_urho3d_variantmap)
hl_urho3d_variantmap * hl_alloc_urho3d_variantmap();


typedef struct hl_urho3d_application
{
    void * finalizer;
    Urho3D::Application  * ptr;
}hl_urho3d_application;

#define HL_URHO3D_APPLICATION _ABSTRACT(hl_urho3d_application)