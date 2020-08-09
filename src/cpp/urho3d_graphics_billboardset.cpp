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

void finalize_urho3d_graphics_billboardset(void *v)
{
    hl_urho3d_graphics_billboardset *hl_ptr = (hl_urho3d_graphics_billboardset *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_graphics_billboardset *hl_alloc_urho3d_graphics_billboardset(urho3d_context *context)
{

// printf("hl_alloc_urho3d_graphics_billboardset %d \n",__LINE__);
    hl_urho3d_graphics_billboardset *p = (hl_urho3d_graphics_billboardset *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_billboardset));
    memset(p,0,sizeof(hl_urho3d_graphics_billboardset));
    p->finalizer = (void *)finalize_urho3d_graphics_billboardset;
    p->ptr = new BillboardSet(context);
    return p;
}

hl_urho3d_graphics_billboardset *hl_alloc_urho3d_graphics_billboardset(BillboardSet *model)
{
 //printf("hl_alloc_urho3d_graphics_billboardset %d \n",__LINE__);
    hl_urho3d_graphics_billboardset *p = (hl_urho3d_graphics_billboardset *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_graphics_billboardset));
    memset(p,0,sizeof(hl_urho3d_graphics_billboardset));
    p->finalizer = (void *)finalize_urho3d_graphics_billboardset;
    p->ptr = model;
    return p;
}

HL_PRIM hl_urho3d_graphics_billboardset *HL_NAME(_graphics_billboardset_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_graphics_billboardset(context);

}

HL_PRIM hl_urho3d_scene_component *HL_NAME(_graphics_billboardset_cast_to_component)(urho3d_context *context, hl_urho3d_graphics_billboardset * t)
{
    BillboardSet * cam = t->ptr;
    return  hl_alloc_urho3d_scene_component(dynamic_cast<Component*>(cam));
}


HL_PRIM hl_urho3d_graphics_billboardset *HL_NAME(_graphics_billboardset_cast_from_component)(urho3d_context *context, hl_urho3d_scene_component * component)
{
    Component * cmp = component->ptr;
    return  hl_alloc_urho3d_graphics_billboardset(dynamic_cast<BillboardSet*>(cmp));
}


HL_PRIM void HL_NAME(_graphics_billboardset_set_material)(urho3d_context *context, hl_urho3d_graphics_billboardset *t, hl_urho3d_graphics_material *material)
{
    t->ptr->SetMaterial(material->ptr);
}

HL_PRIM hl_urho3d_graphics_material *HL_NAME(_graphics_billboardset_get_material)(urho3d_context *context, hl_urho3d_graphics_billboardset *t)
{
    return hl_alloc_urho3d_graphics_material(t->ptr->GetMaterial());
}

//numBillboards
HL_PRIM void HL_NAME(_graphics_billboardset_set_numBillboards)(urho3d_context *context, hl_urho3d_graphics_billboardset * t , int n)
{
   t->ptr->SetNumBillboards(n);
}

HL_PRIM int HL_NAME(_graphics_billboardset_get_numBillboards)(urho3d_context *context, hl_urho3d_graphics_billboardset * t )
{
    return t->ptr->GetNumBillboards();
}

HL_PRIM void HL_NAME(_graphics_billboardset_set_sorted)(urho3d_context *context, hl_urho3d_graphics_billboardset * t , bool n)
{
   t->ptr->SetSorted(n);
}

HL_PRIM bool HL_NAME(_graphics_billboardset_get_sorted)(urho3d_context *context, hl_urho3d_graphics_billboardset * t )
{
    return t->ptr->IsSorted();
}


HL_PRIM void HL_NAME(_graphics_billboardset_commit)(urho3d_context *context, hl_urho3d_graphics_billboardset * t )
{
   t->ptr->Commit();
}

HL_PRIM Urho3D::Billboard * HL_NAME(_graphics_billboardset_get_billboard)(urho3d_context *context, hl_urho3d_graphics_billboardset * t, int index )
{
   return t->ptr->GetBillboard(index);
}

HL_PRIM PODVector<Billboard> * HL_NAME(_graphics_billboardset_get_billboards)(urho3d_context *context, hl_urho3d_graphics_billboardset * t )
{
   return &(t->ptr->GetBillboards());
}

HL_PRIM Urho3D::Billboard * HL_NAME(_graphics_billboardset_get_billboard_from_pod)(urho3d_context *context, PODVector<Billboard> *pod,int index )
{
   return &((*pod)[index]);
}


DEFINE_PRIM(HL_URHO3D_BILLBOARDSET, _graphics_billboardset_create, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_COMPONENT, _graphics_billboardset_cast_to_component, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET);
DEFINE_PRIM(HL_URHO3D_BILLBOARDSET, _graphics_billboardset_cast_from_component,URHO3D_CONTEXT HL_URHO3D_COMPONENT );

DEFINE_PRIM(_VOID, _graphics_billboardset_set_material, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET HL_URHO3D_MATERIAL);
DEFINE_PRIM(HL_URHO3D_MATERIAL, _graphics_billboardset_get_material, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET);

DEFINE_PRIM(_VOID, _graphics_billboardset_set_numBillboards, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET _I32);
DEFINE_PRIM(_I32, _graphics_billboardset_get_numBillboards, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET);

DEFINE_PRIM(_VOID, _graphics_billboardset_set_sorted, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET _BOOL);
DEFINE_PRIM(_BOOL, _graphics_billboardset_get_sorted, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET);

DEFINE_PRIM(_VOID, _graphics_billboardset_commit, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET);

DEFINE_PRIM(HL_URHO3D_BILLBOARD, _graphics_billboardset_get_billboard, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET _I32);
DEFINE_PRIM(HL_URHO3D_POD_BILLBOARD, _graphics_billboardset_get_billboards, URHO3D_CONTEXT HL_URHO3D_BILLBOARDSET );
DEFINE_PRIM(HL_URHO3D_BILLBOARD, _graphics_billboardset_get_billboard_from_pod, URHO3D_CONTEXT HL_URHO3D_POD_BILLBOARD _I32);



