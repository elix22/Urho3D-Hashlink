#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"

#define TVECTOR2_STACK_SIZE 20000
static Urho3D::Vector2 tvector2_stack[TVECTOR2_STACK_SIZE] = {Urho3D::Vector2(0.0, 0.0)};
static int index_tvector2_stack = 0;

HL_PRIM Urho3D::Vector2 *HL_NAME(_math_tvector2_create)(float x, float y)
{
  Urho3D::Vector2 *v = &(tvector2_stack[(index_tvector2_stack++) % TVECTOR2_STACK_SIZE]);
  v->x_ = x;
  v->y_ = y;
  return v;
}

HL_PRIM float HL_NAME(_math_tvector2_set_x)(Urho3D::Vector2 *v, float x)
{
  if (v != NULL)
  {
    v->x_ = x;
    return v->x_;
  }
  else
    return 0.0f;
}

HL_PRIM float HL_NAME(_math_tvector2_get_x)(Urho3D::Vector2 *v)
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

HL_PRIM float HL_NAME(_math_tvector2_set_y)(Urho3D::Vector2 *v, float y)
{
  if (v != NULL)
  {
    v->y_ = y;
    return v->y_;
  }
  else
    return 0.0f;
}

HL_PRIM float HL_NAME(_math_tvector2_get_y)(Urho3D::Vector2 *v)
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

DEFINE_PRIM(HL_URHO3D_TVECTOR2, _math_tvector2_create, _F32 _F32);
DEFINE_PRIM(_F32, _math_tvector2_set_x, HL_URHO3D_TVECTOR2 _F32);
DEFINE_PRIM(_F32, _math_tvector2_get_x, HL_URHO3D_TVECTOR2);
DEFINE_PRIM(_F32, _math_tvector2_set_y, HL_URHO3D_TVECTOR2 _F32);
DEFINE_PRIM(_F32, _math_tvector2_get_y, HL_URHO3D_TVECTOR2);
