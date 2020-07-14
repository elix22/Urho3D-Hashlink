#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

void finalize_urho3d_sprite(void *v)
{
   // printf("finalize_urho3d_sprite \n");
    hl_urho3d_sprite *hl_ptr = (hl_urho3d_sprite *)v;
    if (hl_ptr)
    {
        Urho3D::Sprite *urho3d_ptr = (Urho3D::Sprite *)hl_ptr->ptr;
        if (urho3d_ptr)
        {
            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_sprite *hl_alloc_urho3d_sprite(urho3d_context *context)
{

    hl_urho3d_sprite *p = (hl_urho3d_sprite *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_sprite));
    p->finalizer = (void *)finalize_urho3d_sprite;
    p->ptr = new Sprite(context);
    return p;
}

HL_PRIM hl_urho3d_sprite *HL_NAME(_create_sprite)(urho3d_context *context)
{
    hl_urho3d_sprite *v = hl_alloc_urho3d_sprite(context);
    return v;
}

HL_PRIM hl_urho3d_texture2d *HL_NAME(_sprite_set_texture)(urho3d_context *context, hl_urho3d_sprite *sprite, hl_urho3d_texture2d *texture)
{

    SharedPtr<Urho3D::Sprite> urho3d_sprite(sprite->ptr);
    SharedPtr<Urho3D::Texture2D> urho3d_texture(texture->ptr);
    if (urho3d_sprite && urho3d_texture)
    {
        
        urho3d_sprite->SetTexture(urho3d_texture);
    }
    else
    {
        printf("_sprite_set_texture  NULL\n");
    }
    

    return texture;
}

HL_PRIM hl_urho3d_texture2d *HL_NAME(_sprite_get_texture)(urho3d_context *context, hl_urho3d_sprite *sprite)
{

    Urho3D::Sprite *urho3d_sprite = sprite->ptr;
    hl_urho3d_texture2d *hl_texture = NULL;
    if (urho3d_sprite)
    {
        Urho3D::Texture2D * urho3d_texture2d = dynamic_cast<Texture2D*>(urho3d_sprite->GetTexture());
        SharedPtr<Urho3D::Texture2D> urho3d_texture(urho3d_texture2d);
        hl_texture = hl_alloc_urho3d_texture2d(urho3d_texture);
    }

    return hl_texture;
}

DEFINE_PRIM(HL_URHO3D_SPRITE, _create_sprite, URHO3D_CONTEXT);
DEFINE_PRIM(HL_URHO3D_TEXTURE2D, _sprite_set_texture, URHO3D_CONTEXT HL_URHO3D_SPRITE HL_URHO3D_TEXTURE2D);
DEFINE_PRIM(HL_URHO3D_TEXTURE2D, _sprite_get_texture, URHO3D_CONTEXT HL_URHO3D_SPRITE);