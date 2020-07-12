#include <hl.h>



#define hl_error(msg, ...) hl_throw(hl_alloc_strbytes(hl_to_utf16(msg), ## __VA_ARGS__))

#define HL_MAX_ARGS 9
static int TKIND[] = {0,1,1,1,4,2,3,1,5,5,5,5,5,5,5,5,5,5,5,5,5,5};
static int hlc_call_flags = 0;
#define TK2(a,b)		((a) | ((b)<<5))


static void fun_var_args() {
	hl_error("Variable fun args was not cast to typed function ");
}

static void invalid_cast( hl_type *from, hl_type *to ) {
	hl_error("Eli Can't cast %s to %s ",hl_type_str(from),hl_type_str(to));
}

bool hl_modified_safe_cast( hl_type *t, hl_type *to ) {
	if( t == to )
		return true;
	if( to->kind == HDYN )
		return hl_is_dynamic(t);
	if( t->kind != to->kind )
		return false;
	switch( t->kind ) {
	case HVIRTUAL:
		if( to->virt->nfields < t->virt->nfields ) {
			int i;
			for(i=0;i<to->virt->nfields;i++) {
				hl_obj_field *f1 = t->virt->fields + i;
				hl_obj_field *f2 = to->virt->fields + i;
				if( f1->hashed_name != f2->hashed_name || !hl_same_type(f1->t,f2->t) )
					break;
			}
			if( i == to->virt->nfields )
				return true;
		}
		break;
	case HOBJ:
	case HSTRUCT:
		{
			hl_type_obj *o = t->obj;
			hl_type_obj *oto = to->obj;
			while( true ) {
				if( o == oto ) return true;
				if( o->super == NULL ) return false;
				o = o->super->obj;
			}
		}
	case HFUN:
	case HMETHOD:
		if( t->fun->nargs == to->fun->nargs ) {
			int i;
			if( !hl_safe_cast(t->fun->ret,to->fun->ret) )
				return false;
			for(i=0;i<t->fun->nargs;i++) {
				hl_type *t1 = t->fun->args[i];
				hl_type *t2 = to->fun->args[i];
				if( !hl_safe_cast(t2,t1) && (t1->kind != HDYN || !hl_is_dynamic(t2)) )
					return false;
			}
			return true;
		}
		break;
	default:
		break;
	}

	// TBD ELI , hack
	bool result = hl_same_type(t,to);
	if(result == false)
	{
		if(t->kind == to->kind && t->kind == HABSTRACT )
		{
			return true;
		}
	}
	return result;
}


void *hl_modified_dyn_castp( void *data, hl_type *t, hl_type *to ) {
	hl_track_call(HL_TRACK_CAST, on_cast(t,to));
	if( to->kind == HDYN && hl_is_dynamic(t) )
		return *(vdynamic**)data;
	if( t->kind == HDYN || t->kind == HNULL ) {
		vdynamic *v = *(vdynamic**)data;
		if( v == NULL )
			return NULL;
		if( to->kind == HNULL && v->t == to->tparam && hl_is_gc_ptr(v) )
			return v; // v might be a vdynamic on the stack
		t = v->t;
		if( !hl_is_dynamic(t) ) data = &v->v;
	} else if( hl_is_dynamic(t) ) {
		vdynamic *v = *(vdynamic**)data;
		if( v == NULL ) return NULL;
		t = v->t;
	}
	if( t == to || hl_modified_safe_cast(t,to) )
		return *(void**)data;
	switch( TK2(t->kind,to->kind) ) {
	case TK2(HOBJ,HOBJ):
	case TK2(HSTRUCT,HSTRUCT):
		{
			hl_type_obj *t1 = t->obj;
			hl_type_obj *t2 = to->obj;
			while( true ) {
				if( t1 == t2 )
					return *(void**)data;
				if( t1->super == NULL )
					break;
				t1 = t1->super->obj;
			}
			if( t->obj->rt->castFun ) {
				vdynamic *v = t->obj->rt->castFun(*(vdynamic**)data,to);
				if( v ) return v;
			}
			break;
		}
	case TK2(HFUN,HFUN):
		{
			vclosure *c = *(vclosure**)data;
			if( c == NULL ) return NULL;
			c = hl_make_fun_wrapper(c,to);
			if( c ) return c;
		}
		break;
	case TK2(HOBJ,HVIRTUAL):
	case TK2(HDYNOBJ,HVIRTUAL):
	case TK2(HVIRTUAL,HVIRTUAL):
		return hl_to_virtual(to,*(vdynamic**)data);
	case TK2(HVIRTUAL,HOBJ):
		{
			vvirtual *v = *(vvirtual**)data;
			if( v->value == NULL ) break;
			return hl_dyn_castp( &v->value, v->value->t, to);
		}
	case TK2(HOBJ,HDYN):
	case TK2(HDYNOBJ,HDYN):
	case TK2(HFUN,HDYN):
	case TK2(HNULL,HDYN):
	case TK2(HARRAY,HDYN):
	// NO(HSTRUCT,HDYN)
		return *(void**)data;
	}
	if( to->kind == HDYN )
		return hl_make_dyn(data,t);
	if( to->kind == HNULL ) {
		if( to->tparam->kind == t->kind )
			return hl_make_dyn(data,t);
		switch( to->tparam->kind ) {
		case HUI8:
		case HUI16:
		case HI32:
		case HBOOL:
			{
				int v = hl_dyn_casti(data,t,to->tparam);
				return hl_make_dyn(&v,to->tparam);
			}
		case HF32:
			{
				float f = hl_dyn_castf(data,t);
				return hl_make_dyn(&f,to->tparam);
			}
		case HF64:
			{
				double d = hl_dyn_castd(data,t);
				return hl_make_dyn(&d,to->tparam);
			}
		default:
			break;
		}
	}
	if( to->kind == HREF ) {
		switch( to->tparam->kind ) {
		case HUI8:
		case HUI16:
		case HI32:
		case HBOOL:
			{
				int *v = (int*)hl_gc_alloc_noptr(sizeof(int));
				*v = hl_dyn_casti(data,t,to->tparam);
				return v;
			}
		case HF32:
			{
				float *f = (float*)hl_gc_alloc_noptr(sizeof(float));
				*f = hl_dyn_castf(data,t);
				return f;
			}
		case HF64:
			{
				double *d = (double*)hl_gc_alloc_noptr(sizeof(double));
				*d = hl_dyn_castd(data,t);
				return d;
			}
		default:
			{
				void **p = (void**)hl_gc_alloc_raw(sizeof(void*));
				*p = hl_dyn_castp(data,t,to->tparam);
				return p;
			}
			break;
		}
	}
	invalid_cast(t,to);
	return 0;
}


void *hlc_modified_static_call( void *fun, hl_type *t, void **args, vdynamic *out ) {
	int chk = TKIND[t->fun->ret->kind];
	vdynamic *d;
	switch( t->fun->nargs ) {
	case 0:
		switch( chk ) {
		case 5:
			return ((vdynamic* (*)(void))fun)();
		case 0:
			((void (*)(void))fun)();
			return NULL;
		case 1:
			out->v.i = ((int (*)(void))fun)();
			return &out->v.i;
		}
		break;
	case 1:
		chk |= TKIND[t->fun->args[0]->kind] << 3;
		switch( chk ) {
		case 41:
			out->v.i = ((int (*)(vdynamic*))fun)((vdynamic*)args[0]);
			return &out->v.i;
		case 45:
			return ((vdynamic* (*)(vdynamic*))fun)((vdynamic*)args[0]);
		case 21:
			return ((vdynamic* (*)(float))fun)(*(float*)args[0]);
		case 40:
			((void (*)(vdynamic*))fun)((vdynamic*)args[0]);
			return NULL;
		case 13:
			return ((vdynamic* (*)(int))fun)(*(int*)args[0]);
		case 9:
			out->v.i = ((int (*)(int))fun)(*(int*)args[0]);
			return &out->v.i;
		case 42:
			out->v.f = ((float (*)(vdynamic*))fun)((vdynamic*)args[0]);
			return &out->v.f;
		}
		break;
	case 2:
		chk |= TKIND[t->fun->args[0]->kind] << 3;
		chk |= TKIND[t->fun->args[1]->kind] << 6;
		switch( chk ) {
		case 169:
			out->v.i = ((int (*)(vdynamic*,float))fun)((vdynamic*)args[0],*(float*)args[1]);
			return &out->v.i;
		case 361:
			out->v.i = ((int (*)(vdynamic*,vdynamic*))fun)((vdynamic*)args[0],(vdynamic*)args[1]);
			return &out->v.i;
		case 168:
			((void (*)(vdynamic*,float))fun)((vdynamic*)args[0],*(float*)args[1]);
			return NULL;
		case 109:
			return ((vdynamic* (*)(vdynamic*,int))fun)((vdynamic*)args[0],*(int*)args[1]);
		case 73:
			out->v.i = ((int (*)(int,int))fun)(*(int*)args[0],*(int*)args[1]);
			return &out->v.i;
		case 105:
			out->v.i = ((int (*)(vdynamic*,int))fun)((vdynamic*)args[0],*(int*)args[1]);
			return &out->v.i;
		case 365:
			return ((vdynamic* (*)(vdynamic*,vdynamic*))fun)((vdynamic*)args[0],(vdynamic*)args[1]);
		case 333:
			return ((vdynamic* (*)(int,vdynamic*))fun)(*(int*)args[0],(vdynamic*)args[1]);
		case 170:
			out->v.f = ((float (*)(vdynamic*,float))fun)((vdynamic*)args[0],*(float*)args[1]);
			return &out->v.f;
		case 232:
			((void (*)(vdynamic*,double))fun)((vdynamic*)args[0],*(double*)args[1]);
			return NULL;
		case 233:
			out->v.i = ((int (*)(vdynamic*,double))fun)((vdynamic*)args[0],*(double*)args[1]);
			return &out->v.i;
		case 104:
			((void (*)(vdynamic*,int))fun)((vdynamic*)args[0],*(int*)args[1]);
			return NULL;
		case 360:
			((void (*)(vdynamic*,vdynamic*))fun)((vdynamic*)args[0],(vdynamic*)args[1]);
			return NULL;
		}
		break;
	case 3:
		chk |= TKIND[t->fun->args[0]->kind] << 3;
		chk |= TKIND[t->fun->args[1]->kind] << 6;
		chk |= TKIND[t->fun->args[2]->kind] << 9;
		switch( chk ) {
		case 2665:
			out->v.i = ((int (*)(vdynamic*,int,vdynamic*))fun)((vdynamic*)args[0],*(int*)args[1],(vdynamic*)args[2]);
			return &out->v.i;
		case 2925:
			return ((vdynamic* (*)(vdynamic*,vdynamic*,vdynamic*))fun)((vdynamic*)args[0],(vdynamic*)args[1],(vdynamic*)args[2]);
		case 1769:
			out->v.i = ((int (*)(vdynamic*,double,double))fun)((vdynamic*)args[0],*(double*)args[1],*(double*)args[2]);
			return &out->v.i;
		case 1193:
			out->v.i = ((int (*)(vdynamic*,float,float))fun)((vdynamic*)args[0],*(float*)args[1],*(float*)args[2]);
			return &out->v.i;
		case 2729:
			out->v.i = ((int (*)(vdynamic*,float,vdynamic*))fun)((vdynamic*)args[0],*(float*)args[1],(vdynamic*)args[2]);
			return &out->v.i;
		case 2793:
			out->v.i = ((int (*)(vdynamic*,double,vdynamic*))fun)((vdynamic*)args[0],*(double*)args[1],(vdynamic*)args[2]);
			return &out->v.i;
		case 1640:
			((void (*)(vdynamic*,int,double))fun)((vdynamic*)args[0],*(int*)args[1],*(double*)args[2]);
			return NULL;
		case 2669:
			return ((vdynamic* (*)(vdynamic*,int,vdynamic*))fun)((vdynamic*)args[0],*(int*)args[1],(vdynamic*)args[2]);
		case 2664:
			((void (*)(vdynamic*,int,vdynamic*))fun)((vdynamic*)args[0],*(int*)args[1],(vdynamic*)args[2]);
			return NULL;
		case 617:
			out->v.i = ((int (*)(vdynamic*,int,int))fun)((vdynamic*)args[0],*(int*)args[1],*(int*)args[2]);
			return &out->v.i;
		case 621:
			return ((vdynamic* (*)(vdynamic*,int,int))fun)((vdynamic*)args[0],*(int*)args[1],*(int*)args[2]);
		case 2920:
			((void (*)(vdynamic*,vdynamic*,vdynamic*))fun)((vdynamic*)args[0],(vdynamic*)args[1],(vdynamic*)args[2]);
			return NULL;
		case 616:
			((void (*)(vdynamic*,int,int))fun)((vdynamic*)args[0],*(int*)args[1],*(int*)args[2]);
			return NULL;
		case 873:
			out->v.i = ((int (*)(vdynamic*,vdynamic*,int))fun)((vdynamic*)args[0],(vdynamic*)args[1],*(int*)args[2]);
			return &out->v.i;
		case 2921:
			out->v.i = ((int (*)(vdynamic*,vdynamic*,vdynamic*))fun)((vdynamic*)args[0],(vdynamic*)args[1],(vdynamic*)args[2]);
			return &out->v.i;
		case 1128:
			((void (*)(vdynamic*,int,float))fun)((vdynamic*)args[0],*(int*)args[1],*(float*)args[2]);
			return NULL;
		}
		break;
	case 4:
		chk |= TKIND[t->fun->args[0]->kind] << 3;
		chk |= TKIND[t->fun->args[1]->kind] << 6;
		chk |= TKIND[t->fun->args[2]->kind] << 9;
		chk |= TKIND[t->fun->args[3]->kind] << 12;
		switch( chk ) {
		case 21096:
			((void (*)(vdynamic*,int,int,vdynamic*))fun)((vdynamic*)args[0],*(int*)args[1],*(int*)args[2],(vdynamic*)args[3]);
			return NULL;
		case 23400:
			((void (*)(vdynamic*,vdynamic*,vdynamic*,vdynamic*))fun)((vdynamic*)args[0],(vdynamic*)args[1],(vdynamic*)args[2],(vdynamic*)args[3]);
			return NULL;
		case 4712:
			((void (*)(vdynamic*,int,int,int))fun)((vdynamic*)args[0],*(int*)args[1],*(int*)args[2],*(int*)args[3]);
			return NULL;
		case 4968:
			((void (*)(vdynamic*,vdynamic*,int,int))fun)((vdynamic*)args[0],(vdynamic*)args[1],*(int*)args[2],*(int*)args[3]);
			return NULL;
		}
		break;
	case 5:
		chk |= TKIND[t->fun->args[0]->kind] << 3;
		chk |= TKIND[t->fun->args[1]->kind] << 6;
		chk |= TKIND[t->fun->args[2]->kind] << 9;
		chk |= TKIND[t->fun->args[3]->kind] << 12;
		chk |= TKIND[t->fun->args[4]->kind] << 15;
		switch( chk ) {
		case 37737:
			out->v.i = ((int (*)(vdynamic*,vdynamic*,int,int,int))fun)((vdynamic*)args[0],(vdynamic*)args[1],*(int*)args[2],*(int*)args[3],*(int*)args[4]);
			return &out->v.i;
		case 39528:
			((void (*)(vdynamic*,int,vdynamic*,int,int))fun)((vdynamic*)args[0],*(int*)args[1],(vdynamic*)args[2],*(int*)args[3],*(int*)args[4]);
			return NULL;
		case 37736:
			((void (*)(vdynamic*,vdynamic*,int,int,int))fun)((vdynamic*)args[0],(vdynamic*)args[1],*(int*)args[2],*(int*)args[3],*(int*)args[4]);
			return NULL;
		case 39529:
			out->v.i = ((int (*)(vdynamic*,int,vdynamic*,int,int))fun)((vdynamic*)args[0],*(int*)args[1],(vdynamic*)args[2],*(int*)args[3],*(int*)args[4]);
			return &out->v.i;
		case 53865:
			out->v.i = ((int (*)(vdynamic*,int,int,vdynamic*,int))fun)((vdynamic*)args[0],*(int*)args[1],*(int*)args[2],(vdynamic*)args[3],*(int*)args[4]);
			return &out->v.i;
		}
		break;
	case 6:
		chk |= TKIND[t->fun->args[0]->kind] << 3;
		chk |= TKIND[t->fun->args[1]->kind] << 6;
		chk |= TKIND[t->fun->args[2]->kind] << 9;
		chk |= TKIND[t->fun->args[3]->kind] << 12;
		chk |= TKIND[t->fun->args[4]->kind] << 15;
		chk |= TKIND[t->fun->args[5]->kind] << 18;
		switch( chk ) {
		case 316009:
			out->v.i = ((int (*)(vdynamic*,int,int,vdynamic*,int,int))fun)((vdynamic*)args[0],*(int*)args[1],*(int*)args[2],(vdynamic*)args[3],*(int*)args[4],*(int*)args[5]);
			return &out->v.i;
		case 299593:
			out->v.i = ((int (*)(int,int,int,int,int,int))fun)(*(int*)args[0],*(int*)args[1],*(int*)args[2],*(int*)args[3],*(int*)args[4],*(int*)args[5]);
			return &out->v.i;
		}
		break;
	case 7:
		chk |= TKIND[t->fun->args[0]->kind] << 3;
		chk |= TKIND[t->fun->args[1]->kind] << 6;
		chk |= TKIND[t->fun->args[2]->kind] << 9;
		chk |= TKIND[t->fun->args[3]->kind] << 12;
		chk |= TKIND[t->fun->args[4]->kind] << 15;
		chk |= TKIND[t->fun->args[5]->kind] << 18;
		chk |= TKIND[t->fun->args[6]->kind] << 21;
		switch( chk ) {
		case 2397032:
			((void (*)(vdynamic*,vdynamic*,int,int,int,int,int))fun)((vdynamic*)args[0],(vdynamic*)args[1],*(int*)args[2],*(int*)args[3],*(int*)args[4],*(int*)args[5],*(int*)args[6]);
			return NULL;
		case 2396776:
			((void (*)(vdynamic*,int,int,int,int,int,int))fun)((vdynamic*)args[0],*(int*)args[1],*(int*)args[2],*(int*)args[3],*(int*)args[4],*(int*)args[5],*(int*)args[6]);
			return NULL;
		}
		break;
	}
	hl_fatal("Unsupported dynamic call");
	return NULL;
}

 vdynamic* hl_call_method( vdynamic *c, varray *args ) {
	vclosure *cl = (vclosure*)c;
	vdynamic **vargs = hl_aptr(args,vdynamic*);
	void *pargs[HL_MAX_ARGS];
	void *ret;
	union { double d; int i; float f; } tmp[HL_MAX_ARGS];
	hl_type *tret;
	vdynamic *dret;
	vdynamic out;
	int i;
	if( args->size > HL_MAX_ARGS )
		hl_error("Too many arguments");
	if( cl->hasValue ) {
		if( cl->fun == fun_var_args ) {
			cl = (vclosure*)cl->value;
			return cl->hasValue ? ((vdynamic* (*)(vdynamic*, varray*))cl->fun)((vdynamic*)(cl->value), args) : ((vdynamic* (*)(varray*))cl->fun)(args);
		}
		hl_error("Can't call closure with value");
	}
	if( args->size < cl->t->fun->nargs )
		hl_error("Missing arguments : %d expected but %d passed",cl->t->fun->nargs, args->size);
	for(i=0;i<cl->t->fun->nargs;i++) {
		vdynamic *v = vargs[i];
		hl_type *t = cl->t->fun->args[i];
		void *p;
		if( v == NULL ) {
			if( hl_is_ptr(t) )
				p = NULL;
			else {
				tmp[i].d = 0;
				p = &tmp[i].d;
			}
		} else switch( t->kind ) {
		case HBOOL:
		case HUI8:
		case HUI16:
		case HI32:
			tmp[i].i = hl_dyn_casti(vargs + i, &hlt_dyn,t);
			p = &tmp[i].i;
			break;
		case HF32:
			tmp[i].f = hl_dyn_castf(vargs + i, &hlt_dyn);
			p = &tmp[i].f;
			break;
		case HF64:
			tmp[i].d = hl_dyn_castd(vargs + i, &hlt_dyn);
			p = &tmp[i].d;
			break;
		default:
			p = hl_modified_dyn_castp(vargs + i,&hlt_dyn,t);
			break;
		}
		pargs[i] = p;
	}
	ret = hlc_modified_static_call(hlc_call_flags & 1 ? &cl->fun : cl->fun,cl->t,pargs,&out);
	tret = cl->t->fun->ret;
	if( !hl_is_ptr(tret) ) {
		vdynamic *r;
		switch( tret->kind ) {
		case HVOID:
			return NULL;
		case HBOOL:
			return hl_alloc_dynbool(out.v.b);
		default:
			r = hl_alloc_dynamic(tret);
			r->t = tret;
			r->v.d = out.v.d; // copy
			return r;
		}
	}
	if( ret == NULL || hl_is_dynamic(tret) )
		return (vdynamic*)ret;
	dret = hl_alloc_dynamic(tret);
	dret->v.ptr = ret;
	return dret;
}

 vdynamic *hl_dyn_abstract_call( vclosure *c, vdynamic **args, int nargs ) {
	struct {
		varray a;
		vdynamic *args[HL_MAX_ARGS+1];
	} tmp;
	vclosure ctmp;
	int i = 0;
	//if( nargs > HL_MAX_ARGS ) hl_error("Too many arguments");
	tmp.a.t = &hlt_array;
	tmp.a.at = &hlt_dyn;
	tmp.a.size = nargs;
	if( c->hasValue && c->t->fun->nargs >= 0 ) {
		ctmp.t = c->t->fun->parent;
		ctmp.hasValue = 0;
		ctmp.fun = c->fun;
		tmp.args[0] = hl_make_dyn(&c->value,ctmp.t->fun->args[0]);
		tmp.a.size++;
		for(i=0;i<nargs;i++)
			tmp.args[i+1] = args[i];
		c = &ctmp;
	} else {
		for(i=0;i<nargs;i++)
			tmp.args[i] = args[i];
	}
	return hl_call_method((vdynamic*)c,&tmp.a);
}

