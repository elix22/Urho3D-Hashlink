#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


static Urho3D::Vector3 tvector3_stack[TVECTOR3_STACK_SIZE] = {Urho3D::Vector3(0.0, 0.0,0.0)};
static int index_tvector3_stack = 0;


Urho3D::Vector3 *hl_alloc_urho3d_math_tvector3(float x, float y,float z)
{
  Urho3D::Vector3 *v = &(tvector3_stack[(++index_tvector3_stack) % TVECTOR3_STACK_SIZE]);
  v->x_ = x;
  v->y_ = y;
  v->z_ = z;
  return v;

}

Urho3D::Vector3 *hl_alloc_urho3d_math_tvector3(const Urho3D::Vector3 &rhs)
{
  Urho3D::Vector3 *v = &(tvector3_stack[(++index_tvector3_stack) % TVECTOR3_STACK_SIZE]);
  *v = rhs;
  return v;

}

HL_PRIM Urho3D::Vector3 *HL_NAME(_math_tvector3_create)(float x, float y,float z)
{
  Urho3D::Vector3 *v = &(tvector3_stack[(++index_tvector3_stack) % TVECTOR3_STACK_SIZE]);
  v->x_ = x;
  v->y_ = y;
  v->z_ = z;
  return v;
}

HL_PRIM Urho3D::Vector3 * HL_NAME(_math_tvector3_cast_from_vector3)(hl_urho3d_math_vector3 *hv)
{
    Urho3D::Vector3 *v = (Urho3D::Vector3 *)hv->ptr;

    if (v != NULL)
    {
        return hl_alloc_urho3d_math_tvector3(*v);
    }
    else
    {
        return NULL;
    }
}

HL_PRIM hl_urho3d_math_vector3 * HL_NAME(_math_tvector3_cast_to_vector3)(Urho3D::Vector3 *v)
{

    if (v != NULL)
    {
        return hl_alloc_urho3d_math_vector3(*v);
    }
    else
    {
        return NULL;
    }
}

HL_PRIM float HL_NAME(_math_tvector3_set_x)(Urho3D::Vector3 *v, float x)
{
  if (v != NULL)
  {
    v->x_ = x;
    return v->x_;
  }
  else
    return 0.0f;
}

HL_PRIM float HL_NAME(_math_tvector3_get_x)(Urho3D::Vector3 *v)
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

HL_PRIM float HL_NAME(_math_tvector3_set_y)(Urho3D::Vector3 *v, float y)
{
  if (v != NULL)
  {
    v->y_ = y;
    return v->y_;
  }
  else
    return 0.0f;
}

HL_PRIM float HL_NAME(_math_tvector3_get_y)(Urho3D::Vector3 *v)
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

HL_PRIM float HL_NAME(_math_tvector3_set_z)(Urho3D::Vector3 *v, float z)
{
  if (v != NULL)
  {
    v->z_ = z;
    return v->z_;
  }
  else
    return 0.0f;
}

HL_PRIM float HL_NAME(_math_tvector3_get_z)(Urho3D::Vector3 *v)
{
  if (v != NULL)
  {
    return v->z_;
  }
  else
  {
    return 0.0f;
  }
}

DEFINE_PRIM(HL_URHO3D_TVECTOR3, _math_tvector3_create, _F32 _F32 _F32);
DEFINE_PRIM(_F32, _math_tvector3_set_x, HL_URHO3D_TVECTOR3 _F32);
DEFINE_PRIM(_F32, _math_tvector3_get_x, HL_URHO3D_TVECTOR3);
DEFINE_PRIM(_F32, _math_tvector3_set_y, HL_URHO3D_TVECTOR3 _F32);
DEFINE_PRIM(_F32, _math_tvector3_get_y, HL_URHO3D_TVECTOR3);
DEFINE_PRIM(_F32, _math_tvector3_set_z, HL_URHO3D_TVECTOR3 _F32);
DEFINE_PRIM(_F32, _math_tvector3_get_z, HL_URHO3D_TVECTOR3);

DEFINE_PRIM(HL_URHO3D_TVECTOR3, _math_tvector3_cast_from_vector3, HL_URHO3D_VECTOR3);
DEFINE_PRIM(HL_URHO3D_VECTOR3, _math_tvector3_cast_to_vector3, HL_URHO3D_TVECTOR3);

