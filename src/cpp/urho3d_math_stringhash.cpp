#define HL_NAME(n) Urho3D_##n
extern "C"
{
#if defined(URHO3D_HAXE_HASHLINK)
#include <hashlink/hl.h>
#else
#include <hl.h>
#endif
}

#include "global_types.h"


hl_urho3d_stringhash * hl_alloc_urho3d_existing_stringhash(hl_urho3d_stringhash * str_hash)
{
    hl_urho3d_stringhash  * p= (hl_urho3d_stringhash *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_stringhash));

    p->finalizer = (void*)0;
    p->ptr = str_hash->ptr;
    return p;
}

void finalize_urho3d_stringhash(void * v)
{
   
    hl_urho3d_stringhash  * hl_type_ptr = (hl_urho3d_stringhash  * )v;
    if(hl_type_ptr)
    {
         Urho3D::StringHash *urh3d_type_ptr = (Urho3D::StringHash *)hl_type_ptr->ptr;
         if(urh3d_type_ptr)
         {
              //printf("finalize_urho3d_stringhash %s\n",vector2->ToString().CString());
             delete urh3d_type_ptr;
             hl_type_ptr->ptr = NULL;
         }
         hl_type_ptr->finalizer = NULL;
    }
    
}

hl_urho3d_stringhash *hl_alloc_urho3d_stringhash(Urho3D::StringHash &rhs)
{

       hl_urho3d_stringhash  * p= (hl_urho3d_stringhash *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_stringhash));

    p->finalizer = (void*)finalize_urho3d_stringhash;
    Urho3D::StringHash *v = new Urho3D::StringHash(rhs);
    p->ptr = v;

   // printf("hl_alloc_urho3d_stringhash %s %s\n", str, v->ToString().CString());
    return p; 
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

hl_urho3d_stringhash * hl_alloc_urho3d_stringhash_no_finlizer()
{
    hl_urho3d_stringhash  * p= (hl_urho3d_stringhash *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_stringhash));

    p->finalizer = (void*)0;
    return p;
}


HL_PRIM  hl_urho3d_stringhash  * HL_NAME(_create_stringhash)(vstring  * str)
{
    const char *ch = (char*)hl_to_utf8(str->bytes);
    hl_urho3d_stringhash * v =  hl_alloc_urho3d_stringhash(ch);
    return v;
}

HL_PRIM const char *HL_NAME(_get_stringhash_string)(hl_urho3d_stringhash  * stringhash)
{
    if(stringhash )
    {
        Urho3D::StringHash * str_hash=  stringhash->ptr;
        if(str_hash)
             return str_hash->ToString().CString();
    }

    return "null";

}



DEFINE_PRIM(HL_URHO3D_STRINGHASH, _create_stringhash, _STRING);
DEFINE_PRIM(_BYTES, _get_stringhash_string, HL_URHO3D_STRINGHASH);
