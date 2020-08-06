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

static Urho3D::StringHash tstringhash_stack[TSTRINGHASH_STACK_SIZE] = {Urho3D::StringHash("")};
static int index_tstringhash_stack = 0;

hl_urho3d_tstringhash *hl_alloc_urho3d_tstringhash(const char *str)
{
    Urho3D::StringHash *v = &(tstringhash_stack[(++index_tstringhash_stack) % TSTRINGHASH_STACK_SIZE]);
    *v = Urho3D::StringHash(str);
    return v;
}

hl_urho3d_tstringhash *hl_alloc_urho3d_tstringhash(Urho3D::StringHash &rhs)
{
    Urho3D::StringHash *v = &(tstringhash_stack[(++index_tstringhash_stack) % TSTRINGHASH_STACK_SIZE]);
    *v = rhs;
    return v;
}

HL_PRIM Urho3D::StringHash *HL_NAME(_math_tstringhash_create)(vstring *str)
{
    const char *ch = (char *)hl_to_utf8(str->bytes);
    return hl_alloc_urho3d_tstringhash(ch);
}

HL_PRIM hl_urho3d_tstringhash *HL_NAME(_math_tstringhash_cast_from_stringhash)(hl_urho3d_stringhash *sh)
{
    Urho3D::StringHash *v = (Urho3D::StringHash *)sh->ptr;

    if (v != NULL)
    {
        Urho3D::StringHash *tv = &(tstringhash_stack[(++index_tstringhash_stack) % TSTRINGHASH_STACK_SIZE]);
        *tv = *v;
        return tv;
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_stringhash *HL_NAME(_math_tstringhash_cast_to_stringhash)(Urho3D::StringHash *sh)
{

    if (sh != NULL)
    {
        return hl_alloc_urho3d_stringhash(*sh);
    }
    else
    {
        return NULL;
    }
}

HL_PRIM const char *HL_NAME(_math_tstringhash_get_string)(hl_urho3d_tstringhash *str_hash)
{

    if (str_hash)
        return str_hash->ToString().CString();

    return "null";
}

DEFINE_PRIM(HL_URHO3D_TSTRINGHASH, _math_tstringhash_create, _STRING);
DEFINE_PRIM(_BYTES, _math_tstringhash_get_string, HL_URHO3D_TSTRINGHASH);
DEFINE_PRIM(HL_URHO3D_TSTRINGHASH, _math_tstringhash_cast_from_stringhash, HL_URHO3D_STRINGHASH);
DEFINE_PRIM(HL_URHO3D_STRINGHASH, _math_tstringhash_cast_to_stringhash, HL_URHO3D_TSTRINGHASH);

//
