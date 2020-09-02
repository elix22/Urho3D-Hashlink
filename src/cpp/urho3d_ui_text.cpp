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

void finalize_urho3d_ui_text(void *v)
{

    hl_urho3d_ui_text *hl_ptr = (hl_urho3d_ui_text *)v;
    if (hl_ptr)
    {
        if (hl_ptr->ptr)
        {
            //printf("finalize_urho3d_texture2d  refs:%d\n", hl_ptr->ptr->Refs());
            /* hl_ptr->ptr is a SharedPtr , setting to NULL , decreases the reference count*/
            hl_ptr->ptr = NULL;
        }
        hl_ptr->finalizer = NULL;
    }
}

hl_urho3d_ui_text *hl_alloc_urho3d_ui_text(urho3d_context *context)
{

    hl_urho3d_ui_text *p = (hl_urho3d_ui_text *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_ui_text));
    memset(p, 0, sizeof(hl_urho3d_ui_text));
    p->finalizer = (void *)finalize_urho3d_ui_text;
    p->ptr = new Urho3D::Text(context);
    return p;
}

hl_urho3d_ui_text *hl_alloc_urho3d_ui_text(urho3d_context *context, Urho3D::Text *text)
{

    hl_urho3d_ui_text *p = (hl_urho3d_ui_text *)hl_gc_alloc_finalizer(sizeof(hl_urho3d_ui_text));
    memset(p, 0, sizeof(hl_urho3d_ui_text));
    p->finalizer = (void *)finalize_urho3d_ui_text;
    p->ptr = text;
    return p;
}

HL_PRIM hl_urho3d_ui_text *HL_NAME(_ui_text_create)(urho3d_context *context)
{
    return hl_alloc_urho3d_ui_text(context);
}

HL_PRIM void HL_NAME(_ui_text_addchild)(urho3d_context *context, hl_urho3d_ui_text *this_, hl_urho3d_uielement *ui_child)
{
    // TBD ELI , add null ptr protection
    this_->ptr->AddChild(ui_child->ptr);
}

HL_PRIM bool HL_NAME(_ui_text_set_font)(urho3d_context *context, hl_urho3d_ui_text *this_, hl_urho3d_ui_font *font, float size)
{
    // TBD ELI , add null ptr protection
    return this_->ptr->SetFont(font->ptr, size);
}

//
HL_PRIM void HL_NAME(_ui_text_set_text)(urho3d_context *context, hl_urho3d_ui_text *this_, vstring *text)
{
    // TBD ELI , add null ptr protection
    const char *ch = (char *)hl_to_utf8(text->bytes);
    this_->ptr->SetText(ch);
}

HL_PRIM vbyte *HL_NAME(_ui_text_get_text)(urho3d_context *context, hl_urho3d_ui_text *this_)
{
    // TBD ELI , add null ptr protection
    return HLCreateVBString(this_->ptr->GetText());
}

HL_PRIM void HL_NAME(_ui_text_set_text_alignment)(urho3d_context *context, hl_urho3d_ui_text *this_, int alignment)
{
    this_->ptr->SetTextAlignment(Urho3D::HorizontalAlignment(alignment));
}

HL_PRIM int HL_NAME(_ui_text_get_text_alignment)(urho3d_context *context, hl_urho3d_ui_text *this_)
{
    // TBD ELI , add null ptr protection;
    return this_->ptr->GetTextAlignment();
}

////SetHorizontalAlignment
HL_PRIM void HL_NAME(_ui_text_set_horizontal_alignment)(urho3d_context *context, hl_urho3d_ui_text *this_, int alignment)
{
    // TBD ELI , add null ptr protection;
    this_->ptr->SetHorizontalAlignment(Urho3D::HorizontalAlignment(alignment));
}

HL_PRIM int HL_NAME(_ui_text_get_horizontal_alignment)(urho3d_context *context, hl_urho3d_ui_text *this_)
{
    // TBD ELI , add null ptr protection;
    return this_->ptr->GetHorizontalAlignment();
}


HL_PRIM hl_urho3d_uielement *HL_NAME(_ui_text_cast_to_uielement)(urho3d_context *context, hl_urho3d_ui_text *this_)
{
    return hl_alloc_urho3d_uielement(context, this_->ptr);
}

HL_PRIM hl_urho3d_ui_text *HL_NAME(_ui_text_cast_from_uielement)(urho3d_context *context, hl_urho3d_uielement *ui_element)
{

    Urho3D::Text *text = dynamic_cast<Urho3D::Text *>(ui_element->ptr.Get());

    if (text)
        return hl_alloc_urho3d_ui_text(context, text);
    else
    {
        return NULL;
    }
}

DEFINE_PRIM(HL_URHO3D_UIELEMENT, _ui_text_cast_to_uielement, URHO3D_CONTEXT HL_URHO3D_UI_TEXT );
DEFINE_PRIM(HL_URHO3D_UI_TEXT, _ui_text_cast_from_uielement, URHO3D_CONTEXT HL_URHO3D_UIELEMENT);

DEFINE_PRIM(_VOID, _ui_text_set_horizontal_alignment, URHO3D_CONTEXT HL_URHO3D_UI_TEXT _I32);
DEFINE_PRIM(_I32, _ui_text_get_horizontal_alignment, URHO3D_CONTEXT HL_URHO3D_UI_TEXT);

DEFINE_PRIM(_VOID, _ui_text_set_text_alignment, URHO3D_CONTEXT HL_URHO3D_UI_TEXT _I32);
DEFINE_PRIM(_I32, _ui_text_get_text_alignment, URHO3D_CONTEXT HL_URHO3D_UI_TEXT);

DEFINE_PRIM(HL_URHO3D_UI_TEXT, _ui_text_create, URHO3D_CONTEXT);
DEFINE_PRIM(_VOID, _ui_text_addchild, URHO3D_CONTEXT HL_URHO3D_UI_TEXT HL_URHO3D_UIELEMENT);

DEFINE_PRIM(_BOOL, _ui_text_set_font, URHO3D_CONTEXT HL_URHO3D_UI_TEXT HL_URHO3D_UI_FONT _F32);

DEFINE_PRIM(_VOID, _ui_text_set_text, URHO3D_CONTEXT HL_URHO3D_UI_TEXT _STRING);
DEFINE_PRIM(_BYTES, _ui_text_get_text, URHO3D_CONTEXT HL_URHO3D_UI_TEXT);