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

/*
hl_urho3d_io_vector_buffer *hl_alloc_urho3d_io_vector_buffer(urho3d_context *context);
hl_urho3d_io_vector_buffer *hl_alloc_urho3d_io_vector_buffer(urho3d_context *context,Urho3D::VectorBuffer*);
#define HL_URHO3D_VECTOR_BUFFER _ABSTRACT(hl_urho3d_io_vector_buffer)
*/

void finalize_urho3d_io_vector_buffer(void *v)
{
    hl_urho3d_io_vector_buffer *uptr = (hl_urho3d_io_vector_buffer *)v;
    if (uptr)
    {
        if (uptr->ptr)
        {
            delete uptr->ptr;
            uptr->ptr = NULL;
        }
        uptr->finalizer = NULL;
    }
}

hl_urho3d_io_vector_buffer *hl_alloc_urho3d_io_vector_buffer()
{
    hl_urho3d_io_vector_buffer *p = (hl_urho3d_io_vector_buffer *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_io_vector_buffer));

    p->finalizer = (void *)finalize_urho3d_io_vector_buffer;
    p->ptr = new Urho3D::VectorBuffer();
    p->dyn_obj = NULL;
    return p;
}

hl_urho3d_io_vector_buffer *hl_alloc_urho3d_io_vector_buffer( Urho3D::VectorBuffer *buffer)
{
    hl_urho3d_io_vector_buffer *p = (hl_urho3d_io_vector_buffer *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_io_vector_buffer));

    p->finalizer = (void *)0;
    p->ptr = buffer;
    p->dyn_obj = NULL;
    return p;
}

HL_PRIM hl_urho3d_io_vector_buffer *HL_NAME(_io_vector_buffer_create)()
{
    return hl_alloc_urho3d_io_vector_buffer();
}

DEFINE_PRIM(HL_URHO3D_VECTOR_BUFFER, _io_vector_buffer_create, _NO_ARG);