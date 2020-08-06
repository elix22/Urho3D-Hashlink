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


static Urho3D::Color tcolor_stack[TCOLOR_STACK_SIZE] = {Urho3D::Color(0.0, 0.0,0.0,1.0)};
static int index_tcolor_stack = 0;


Urho3D::Color *hl_alloc_urho3d_math_tcolor(float r, float g,float b,float a)
{
  Urho3D::Color *v = &(tcolor_stack[(++index_tcolor_stack) % TCOLOR_STACK_SIZE]);
  v->r_ = r;
  v->g_ = g;
  v->b_ = b;
  v->a_ = a;
  return v;

}

Urho3D::Color *hl_alloc_urho3d_math_tcolor(const Urho3D::Color &rhs)
{
  Urho3D::Color *v = &(tcolor_stack[(++index_tcolor_stack) % TCOLOR_STACK_SIZE]);
  *v = rhs;
  return v;

}

HL_PRIM Urho3D::Color *HL_NAME(_math_tcolor_create)(float r, float g,float b,float a)
{
  Urho3D::Color *v = &(tcolor_stack[(++index_tcolor_stack) % TCOLOR_STACK_SIZE]);
  v->r_ = r;
  v->g_ = g;
  v->b_ = b;
  v->a_ = a;
  return v;
}

HL_PRIM Urho3D::Color * HL_NAME(_math_tcolor_cast_from_color)(hl_urho3d_color *hv)
{
    Urho3D::Color *v = (Urho3D::Color *)hv->ptr;

    if (v != NULL)
    {
        return hl_alloc_urho3d_math_tcolor(*v);
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_color * HL_NAME(_math_tcolor_cast_to_color)(Urho3D::Color *v)
{

    if (v != NULL)
    {
        return hl_alloc_urho3d_color(*v);
    }
    else
    {
        return NULL;
    }
}

DEFINE_PRIM(HL_URHO3D_TCOLOR, _math_tcolor_create,_F32 _F32 _F32 _F32);


DEFINE_PRIM(HL_URHO3D_TCOLOR, _math_tcolor_cast_from_color, HL_URHO3D_COLOR);
DEFINE_PRIM(HL_URHO3D_COLOR, _math_tcolor_cast_to_color, HL_URHO3D_TCOLOR);
