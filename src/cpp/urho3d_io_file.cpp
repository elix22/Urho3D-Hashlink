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

void finalize_urho3d_io_file(void *v)
{
    hl_urho3d_io_file *uptr = (hl_urho3d_io_file *)v;
    if (uptr)
    {
        if (uptr->ptr)
        {
            uptr->ptr->Close();
            //  delete uptr->ptr;
            uptr->ptr = NULL;
        }
        uptr->finalizer = NULL;
    }
}

hl_urho3d_io_file *hl_alloc_urho3d_io_file(Context *context, const char *name, int mode)
{
    File *file = new Urho3D::File(context, String(name), FileMode(mode));
    if (file)
    {
        hl_urho3d_io_file *p = (hl_urho3d_io_file *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_io_file));
        memset(p, 0, sizeof(hl_urho3d_io_file));
        p->finalizer = (void *)finalize_urho3d_io_file;
        p->ptr = file;
        p->dyn_obj = NULL;
        return p;
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_io_file *HL_NAME(_io_file_create)(Context *context, vstring *fileName, int mode)
{
    const char *name = (char *)hl_to_utf8(fileName->bytes);
    return hl_alloc_urho3d_io_file(context, name, mode);
}

DEFINE_PRIM(HL_URHO3D_FILE, _io_file_create, URHO3D_CONTEXT _STRING _I32);