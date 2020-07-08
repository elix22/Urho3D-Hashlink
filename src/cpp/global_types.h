
#include <Urho3D/Urho3DAll.h>

typedef  Urho3D::Context urho3d_context;
#define URHO3D_CONTEXT _ABSTRACT(urho3d_context)



typedef struct hl_urho3d_vector2
{
    void * finalizer;
    Urho3D::Vector2  * ptr;
}hl_urho3d_vector2;

#define HL_URHO3D_VECTOR2 _ABSTRACT(hl_urho3d_vector2)