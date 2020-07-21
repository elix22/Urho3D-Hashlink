#define HL_NAME(n) Urho3D_##n
extern "C"
{
#include <hl.h>
}

#include <Urho3D/Urho3DAll.h>
#include "global_types.h"


void finalize_urho3d_color(void * v)
{
    hl_urho3d_color * hl_ptr = (hl_urho3d_color  * )v;
    if(hl_ptr)
    {
         Urho3D::Color *color = (Urho3D::Color *)hl_ptr->ptr;
         if(color)
         {
           //  printf("finalize_urho3d_vector2 %f:%f \n",vector2->x_,vector2->y_);
             delete color;
             hl_ptr->ptr = NULL;
             
         }
         hl_ptr->finalizer = NULL;
    }
    
}

hl_urho3d_color * hl_alloc_urho3d_color(const Urho3D::Color & color)
{
    hl_urho3d_color  * p= (hl_urho3d_color *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_color));

    p->finalizer = (void*)finalize_urho3d_color;
    Urho3D::Color *v = new Urho3D::Color(color);
    p->ptr = v;

    return p;
}

hl_urho3d_color * hl_alloc_urho3d_color(float r,float g,float b,float a)
{
    hl_urho3d_color  * p= (hl_urho3d_color *) hl_gc_alloc_finalizer(sizeof(hl_urho3d_color));

    p->finalizer = (void*)finalize_urho3d_color;
    Urho3D::Color *v = new Urho3D::Color(r,g,b,a);
    p->ptr = v;

    return p;
}



HL_PRIM  hl_urho3d_color  * HL_NAME(_math_create_color)(float r,float g,float b,float a)
{
    hl_urho3d_color * v =  hl_alloc_urho3d_color(r,g,b,a);
    return v;
}

HL_PRIM float HL_NAME(_math_color_set_r)(hl_urho3d_color * cp, float r)
{
    Urho3D::Color *  up = (Urho3D::Color*)cp->ptr;

    if(up != NULL)
    {
        up->r_ = r;
        return up->r_;
    }
    else
        return 0;
}

HL_PRIM float  HL_NAME(_math_color_get_r)(hl_urho3d_color * cp)
{
    Urho3D::Color *  up = (Urho3D::Color*)cp->ptr;

    if(up != NULL)
    {
        return up->r_;
    }
    else
    {
        return 0;
    }
}


HL_PRIM float HL_NAME(_math_color_set_g)(hl_urho3d_color * cp, float g)
{
    Urho3D::Color *  up = (Urho3D::Color*)cp->ptr;

    if(up != NULL)
    {
        up->g_ = g;
        return up->g_;
    }
    else
        return 0;
}

HL_PRIM float  HL_NAME(_math_color_get_g)(hl_urho3d_color * cp)
{
    Urho3D::Color *  up = (Urho3D::Color*)cp->ptr;

    if(up != NULL)
    {
        return up->g_;
    }
    else
    {
        return 0;
    }
}


HL_PRIM float HL_NAME(_math_color_set_b)(hl_urho3d_color * cp, float b)
{
    Urho3D::Color *  up = (Urho3D::Color*)cp->ptr;

    if(up != NULL)
    {
        up->b_ = b;
        return up->b_;
    }
    else
        return 0;
}

HL_PRIM float  HL_NAME(_math_color_get_b)(hl_urho3d_color * cp)
{
    Urho3D::Color *  up = (Urho3D::Color*)cp->ptr;

    if(up != NULL)
    {
        return up->b_;
    }
    else
    {
        return 0;
    }
}

HL_PRIM float HL_NAME(_math_color_set_a)(hl_urho3d_color * cp, float a)
{
    Urho3D::Color *  up = (Urho3D::Color*)cp->ptr;

    if(up != NULL)
    {
        up->a_ = a;
        return up->a_;
    }
    else
        return 0;
}

HL_PRIM float  HL_NAME(_math_color_get_a)(hl_urho3d_color * cp)
{
    Urho3D::Color *  up = (Urho3D::Color*)cp->ptr;

    if(up != NULL)
    {
        return up->a_;
    }
    else
    {
        return 0;
    }
}





DEFINE_PRIM(HL_URHO3D_COLOR, _math_create_color, _F32 _F32 _F32 _F32);
DEFINE_PRIM(_F32, _math_color_set_r,HL_URHO3D_COLOR _F32);
DEFINE_PRIM(_F32, _math_color_get_r,HL_URHO3D_COLOR);
DEFINE_PRIM(_F32, _math_color_set_g,HL_URHO3D_COLOR _F32);
DEFINE_PRIM(_F32, _math_color_get_g,HL_URHO3D_COLOR);
DEFINE_PRIM(_F32, _math_color_set_b,HL_URHO3D_COLOR _F32);
DEFINE_PRIM(_F32, _math_color_get_b,HL_URHO3D_COLOR);
DEFINE_PRIM(_F32, _math_color_set_a,HL_URHO3D_COLOR _F32);
DEFINE_PRIM(_F32, _math_color_get_a,HL_URHO3D_COLOR);

