package urho3d;

typedef HL_URHO3D_VECTOR2 = hl.Abstract<"hl_urho3d_vector2">;

@:hlNative("Urho3D")
abstract Vector2(HL_URHO3D_VECTOR2) {

    public function new(?x_:Single = 0.0 , ?y_:Single=0.0) {
        this = Create();
        if(x_ != null)
        {
            x=x_;
        }
        if(y_ != null)
        {
            y=y_;
        }
    }

    public function destroy() {
        trace("Vector2 destroyed");
	}

	@:hlNative("Urho3D", "_create_vector2")
	private static function Create():HL_URHO3D_VECTOR2 {
		return null;
    }

    // calling trace(Vector2) , will show x:y
    @:to
    public function toString():String
    {
        var s:String = x+":"+y;
        return s;
    }

    @:op(A == B)
    public function isequal(rhs:Vector2):Bool {

        return (x == rhs.x && y == rhs.y);
    }

    @:op(A != B)
    public function isnotequal(rhs:Vector2):Bool {

        return !(x == rhs.x && y == rhs.y);
    }

    @:op(A + B)
    public function add(rhs:Vector2):Vector2 {

        var x1:Single = x + rhs.x;
        var y1:Single = y + rhs.y;

        return new Vector2(x1,y1);
    }

    @:op(A += B)
    public function add2(rhs:Vector2):HL_URHO3D_VECTOR2 {

        x += rhs.x;
        y += rhs.y;

        return this;
    }

    @:op(A - B)
    public function sub(rhs:Vector2):Vector2 {

        var x1:Single = x - rhs.x;
        var y1:Single = y - rhs.y;

        return new Vector2(x1,y1);
    }

    @:op(A -= B)
    public function sub2(rhs:Vector2):HL_URHO3D_VECTOR2 {

        x -= rhs.x;
        y -= rhs.y;

        return this;
    }

    @:op(-A) public function neg():HL_URHO3D_VECTOR2 {
        x = -x;
        y = -y;
        return this;
    }

    @:op(--A) public function preneg():HL_URHO3D_VECTOR2 {
        x = --x;
        y = --y;
        return this;
    }

    @:op(A--) public function postneg():HL_URHO3D_VECTOR2 {
        x = x--;
        y = y--;
        return this;
    }

    @:op(++A) public function preadd():HL_URHO3D_VECTOR2 {
        x = ++x;
        y = ++y;
        return this;
    }

    @:op(A++) public function postadd():HL_URHO3D_VECTOR2 {
        x = x++;
        y = y++;
        return this;
    }

  
    

    public var x(get, set):Single;
    public var y(get, set):Single;

	function get_x() {
		return _get_x(this);
	}
	@:hlNative("Urho3D", "_get_x")
	private static function _get_x(vec2:HL_URHO3D_VECTOR2):Single {
		return 0.0;
    }
    
	function set_x(x) {
		return _set_x(this, x);
	}
	@:hlNative("Urho3D", "_set_x")
	private static function _set_x(vec2:HL_URHO3D_VECTOR2, x:Single):Single {
		return 0.0;
    }
    

    function get_y() {
		return _get_y(this);
	}
	@:hlNative("Urho3D", "_get_y")
	private static function _get_y(vec2:HL_URHO3D_VECTOR2):Single {
		return 0.0;
    }
    
	function set_y(y) {
		return _set_y(this, y);
	}
	@:hlNative("Urho3D", "_set_y")
	private static function _set_y(vec2:HL_URHO3D_VECTOR2, x:Single):Single {
		return 0.0;
	}
}
