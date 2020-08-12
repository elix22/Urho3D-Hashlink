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

static Urho3D::IntVector2 tintvector2_stack[TINTVECTOR2_STACK_SIZE] = {Urho3D::IntVector2(0.0, 0.0)};
static int index_tintvector2_stack = 0;

Urho3D::IntVector2 *hl_alloc_urho3d_math_tintvector2(int x, int y)
{
  Urho3D::IntVector2 *v = &(tintvector2_stack[(++index_tintvector2_stack) % TINTVECTOR2_STACK_SIZE]);
  v->x_ = x;
  v->y_ = y;
  return v;
}

Urho3D::IntVector2 *hl_alloc_urho3d_math_tintvector2(const Urho3D::IntVector2 &rhs)
{
  Urho3D::IntVector2 *v = &(tintvector2_stack[(++index_tintvector2_stack) % TINTVECTOR2_STACK_SIZE]);
  *v = rhs;
  return v;
}

HL_PRIM Urho3D::IntVector2 *HL_NAME(_math_tintvector2_create)(int x, int y)
{
  Urho3D::IntVector2 *v = &(tintvector2_stack[(++index_tintvector2_stack) % TINTVECTOR2_STACK_SIZE]);
  v->x_ = x;
  v->y_ = y;
  return v;
}

HL_PRIM Urho3D::IntVector2 *HL_NAME(_math_tintvector2_cast_from_intvector2)(hl_urho3d_intvector2 *hv)
{
  Urho3D::IntVector2 *v = (Urho3D::IntVector2 *)hv->ptr;

  if (v != NULL)
  {
    Urho3D::IntVector2 *tv = &(tintvector2_stack[(++index_tintvector2_stack) % TINTVECTOR2_STACK_SIZE]);
    *tv = *v;
    return tv;
  }
  else
  {
    return NULL;
  }
}

HL_PRIM hl_urho3d_intvector2 *HL_NAME(_math_tintvector2_cast_to_intvector2)(Urho3D::IntVector2 *v)
{

  if (v != NULL)
  {
    return hl_alloc_urho3d_intvector2(v->x_, v->y_);
  }
  else
  {
    return NULL;
  }
}

HL_PRIM int HL_NAME(_math_tintvector2_set_x)(Urho3D::IntVector2 *v, int x)
{
  if (v != NULL)
  {
    v->x_ = x;
    return v->x_;
  }
  else
    return 0.0f;
}

HL_PRIM int HL_NAME(_math_tintvector2_get_x)(Urho3D::IntVector2 *v)
{
  if (v != NULL)
  {
    return v->x_;
  }
  else
  {
    return 0.0f;
  }
}

HL_PRIM int HL_NAME(_math_tintvector2_set_y)(Urho3D::IntVector2 *v, int y)
{
  if (v != NULL)
  {
    v->y_ = y;
    return v->y_;
  }
  else
    return 0.0f;
}

HL_PRIM int HL_NAME(_math_tintvector2_get_y)(Urho3D::IntVector2 *v)
{
  if (v != NULL)
  {
    return v->y_;
  }
  else
  {
    return 0.0f;
  }
}

DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _math_tintvector2_create, _I32 _I32);
DEFINE_PRIM(_I32, _math_tintvector2_set_x, HL_URHO3D_TINTVECTOR2 _I32);
DEFINE_PRIM(_I32, _math_tintvector2_get_x, HL_URHO3D_TINTVECTOR2);
DEFINE_PRIM(_I32, _math_tintvector2_set_y, HL_URHO3D_TINTVECTOR2 _I32);
DEFINE_PRIM(_I32, _math_tintvector2_get_y, HL_URHO3D_TINTVECTOR2);

DEFINE_PRIM(HL_URHO3D_TINTVECTOR2, _math_tintvector2_cast_from_intvector2, HL_URHO3D_INTVECTOR2);
DEFINE_PRIM(HL_URHO3D_INTVECTOR2, _math_tintvector2_cast_to_intvector2, HL_URHO3D_TINTVECTOR2);
