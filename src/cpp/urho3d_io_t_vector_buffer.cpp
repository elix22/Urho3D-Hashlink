#define HL_NAME(n) Urho3D_##n
extern "C"
{
#if defined(URHO3D_HAXE_HASHLINK)
#include <hashlink/hl.h>
#else
#include <hl.h>
#endif
}

#include "global_types.inc"

static Urho3D::VectorBuffer t_vector_buffer_stack[T_VECTOR_BUFFER_STACK_SIZE] = {VectorBuffer()};
static int index_t_vector_buffer_stack = 0;

Urho3D::VectorBuffer *hl_alloc_urho3d_io_t_vector_buffer()
{
    Urho3D::VectorBuffer *v = &(t_vector_buffer_stack[(++index_t_vector_buffer_stack) % T_VECTOR_BUFFER_STACK_SIZE]);
    v->Clear();
    return v;
}

Urho3D::VectorBuffer *hl_alloc_urho3d_io_t_vector_buffer(Urho3D::VectorBuffer & vb)
{
    Urho3D::VectorBuffer *v = &(t_vector_buffer_stack[(++index_t_vector_buffer_stack) % T_VECTOR_BUFFER_STACK_SIZE]);
    v->Clear();
    *v=vb;
    return v;
}

HL_PRIM Urho3D::VectorBuffer *HL_NAME(_io_t_vector_buffer_create)()
{
    Urho3D::VectorBuffer *v = &(t_vector_buffer_stack[(++index_t_vector_buffer_stack) % T_VECTOR_BUFFER_STACK_SIZE]);
    return v;
}

HL_PRIM Urho3D::VectorBuffer *HL_NAME(_io_t_vector_buffer_cast_from_vector_buffer)(hl_urho3d_io_vector_buffer *hv)
{
    Urho3D::VectorBuffer *v = (Urho3D::VectorBuffer *)hv->ptr;

    if (v != NULL)
    {
        // TBD ELI
        /*
    Urho3D::VectorBuffer *tv = &(t_vector_buffer_stack[(++index_t_vector_buffer_stack) % T_VECTOR_BUFFER_STACK_SIZE]);
    *tv = *v;
    return tv;
    */
        return v;
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_io_vector_buffer *HL_NAME(_io_t_vector_buffer_cast_to_vector_buffer)(Urho3D::VectorBuffer *v)
{

    if (v != NULL)
    {
        return hl_alloc_urho3d_io_vector_buffer(v);
    }
    else
    {
        return NULL;
    }
}


HL_PRIM bool HL_NAME(_io_t_vector_buffer_is_eof)(Urho3D::VectorBuffer *v)
{
    return v->IsEof();
}
DEFINE_PRIM(_BOOL, _io_t_vector_buffer_is_eof, HL_URHO3D_T_VECTOR_BUFFER);

HL_PRIM int HL_NAME(_io_t_vector_buffer_read_bool)(Urho3D::VectorBuffer *v)
{
    return v->ReadBool();
}
DEFINE_PRIM(_BOOL, _io_t_vector_buffer_read_bool, HL_URHO3D_T_VECTOR_BUFFER);

HL_PRIM int HL_NAME(_io_t_vector_buffer_read_int)(Urho3D::VectorBuffer *v)
{
    return v->ReadInt();
}
DEFINE_PRIM(_I32, _io_t_vector_buffer_read_int, HL_URHO3D_T_VECTOR_BUFFER);

HL_PRIM float HL_NAME(_io_t_vector_buffer_read_float)(Urho3D::VectorBuffer *v)
{
    return v->ReadFloat();
}
DEFINE_PRIM(_F32, _io_t_vector_buffer_read_float, HL_URHO3D_T_VECTOR_BUFFER);

HL_PRIM Urho3D::Vector2 *HL_NAME(_io_t_vector_buffer_read_vector2)(Urho3D::VectorBuffer *v)
{
    return hl_alloc_urho3d_math_tvector2(v->ReadVector2());
}
DEFINE_PRIM(HL_URHO3D_TVECTOR2, _io_t_vector_buffer_read_vector2, HL_URHO3D_T_VECTOR_BUFFER);

HL_PRIM Urho3D::Vector3 *HL_NAME(_io_t_vector_buffer_read_vector3)(Urho3D::VectorBuffer *v)
{
    return hl_alloc_urho3d_math_tvector3(v->ReadVector3());
}
DEFINE_PRIM(HL_URHO3D_TVECTOR3, _io_t_vector_buffer_read_vector3, HL_URHO3D_T_VECTOR_BUFFER);



DEFINE_PRIM(HL_URHO3D_T_VECTOR_BUFFER, _io_t_vector_buffer_create, _NO_ARG);

DEFINE_PRIM(HL_URHO3D_T_VECTOR_BUFFER, _io_t_vector_buffer_cast_from_vector_buffer, HL_URHO3D_VECTOR_BUFFER);
DEFINE_PRIM(HL_URHO3D_VECTOR_BUFFER, _io_t_vector_buffer_cast_to_vector_buffer, HL_URHO3D_T_VECTOR_BUFFER);