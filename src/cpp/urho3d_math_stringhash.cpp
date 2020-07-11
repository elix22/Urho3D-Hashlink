#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


void finalize_urho3d_stringhash(void * v)
{
   
    hl_urho3d_stringhash  * v2ptr = (hl_urho3d_stringhash  * )v;
    if(v2ptr)
    {
         Urho3D::StringHash *vector2 = (Urho3D::StringHash *)v2ptr->ptr;
         if(vector2)
         {
              //printf("finalize_urho3d_stringhash %s\n",vector2->ToString().CString());
             delete vector2;
             v2ptr->ptr = NULL;
         }
         v2ptr->finalizer = NULL;
    }
    
}


hl_urho3d_stringhash * hl_alloc_urho3d_stringhash(const char* str)
{
    hl_urho3d_stringhash  * p= (hl_urho3d_stringhash *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_stringhash));

    p->finalizer = (void*)finalize_urho3d_stringhash;
    Urho3D::StringHash *v = new Urho3D::StringHash(str);
    p->ptr = v;

   // printf("hl_alloc_urho3d_stringhash %s %s\n", str, v->ToString().CString());
    return p;
}


HL_PRIM  hl_urho3d_stringhash  * HL_NAME(_create_stringhash)(vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    hl_urho3d_stringhash * v =  hl_alloc_urho3d_stringhash(ch);
    return v;
}



DEFINE_PRIM(HL_URHO3D_STRINGHASH, _create_stringhash, _STRING);
