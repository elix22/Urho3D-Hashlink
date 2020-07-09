
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

typedef struct hl_urho3d_stringhash
{
    void * finalizer;
    Urho3D::StringHash  * ptr;
}hl_urho3d_stringhash;

#define HL_URHO3D_STRINGHASH _ABSTRACT(hl_urho3d_stringhash)


typedef struct hl_urho3d_application
{
    void * finalizer;
    Urho3D::Application  * ptr;
}hl_urho3d_application;

#define HL_URHO3D_APPLICATION _ABSTRACT(hl_urho3d_application)