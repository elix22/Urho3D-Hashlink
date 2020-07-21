#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


void finalize_urho3d_math_quaternion(void * v)
{
    hl_urho3d_math_quaternion  * uptr = (hl_urho3d_math_quaternion  * )v;
    if(uptr)
    {
         if(uptr->ptr)
         {
             delete uptr->ptr;
             uptr->ptr = NULL;
             
         }
         uptr->finalizer = NULL;
    }
    
}


hl_urho3d_math_quaternion * hl_alloc_urho3d_math_quaternion(const Urho3D::Quaternion & rhs)
{
    hl_urho3d_math_quaternion  * p= (hl_urho3d_math_quaternion *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_quaternion));

    p->finalizer = (void*)finalize_urho3d_math_quaternion;
    p->ptr = new Urho3D::Quaternion(rhs);

    return p;

}

hl_urho3d_math_quaternion * hl_alloc_urho3d_math_quaternion(float x, float y,float z)
{
    hl_urho3d_math_quaternion  * p= (hl_urho3d_math_quaternion *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_math_quaternion));

    p->finalizer = (void*)finalize_urho3d_math_quaternion;
    p->ptr = new Urho3D::Quaternion(x,y,z);;
    return p;
}

HL_PRIM  hl_urho3d_math_quaternion  * HL_NAME(_math_quaternion_create)(float x, float y,float z)
{
    return  hl_alloc_urho3d_math_quaternion(x,y,z);
}


DEFINE_PRIM(HL_URHO3D_QUATERNION, _math_quaternion_create, _F32 _F32 _F32);