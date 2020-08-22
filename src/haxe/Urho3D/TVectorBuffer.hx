package urho3d;

typedef HL_URHO3D_T_VECTOR_BUFFER = hl.Abstract<"hl_urho3d_io_t_vector_buffer">

abstract TVectorBuffer(HL_URHO3D_T_VECTOR_BUFFER) {
	public inline function new() {
		this = Create();
	}

	@:to
	public inline function toVectorBuffer():VectorBuffer {
		return _CastToVectorBuffer(cast this);
	}

	@:from
	public static inline function fromVectorBuffer(v:VectorBuffer):TVectorBuffer {
		return _CastFromVectorBuffer(v);
	}

	public var eof(get, never):Bool;

	function get_eof() {
		return _IsEOF(cast this);
	}

	public inline function ReadBool() {
		return _ReadBool(cast this);
	}

	public inline function ReadInt() {
		return _ReadInt(cast this);
	}

	public inline function ReadFloat():Float {
		return _ReadFloat(cast this);
	}

	public inline function ReadVector2():TVector2 {
		return _ReadVector2(cast this);
	}

	public inline function ReadVector3():TVector3 {
		return _ReadVector3(cast this);
	}

	@:hlNative("Urho3D", "_io_t_vector_buffer_create")
	private static function Create():HL_URHO3D_T_VECTOR_BUFFER {
		return null;
	}

	@:hlNative("Urho3D", "_io_t_vector_buffer_cast_from_vector_buffer")
	private static function _CastFromVectorBuffer(v:VectorBuffer):TVectorBuffer {
		return null;
	}

	@:hlNative("Urho3D", "_io_t_vector_buffer_cast_to_vector_buffer")
	private static function _CastToVectorBuffer(v:TVectorBuffer):VectorBuffer {
		return null;
	}

	@:hlNative("Urho3D", "_io_t_vector_buffer_is_eof")
	private static function _IsEOF(v:TVectorBuffer):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_io_t_vector_buffer_read_bool")
	private static function _ReadBool(v:TVectorBuffer):Bool {
		return false;
	}

	@:hlNative("Urho3D", "_io_t_vector_buffer_read_int")
	private static function _ReadInt(v:TVectorBuffer):Int {
		return 0;
	}

	@:hlNative("Urho3D", "_io_t_vector_buffer_read_float")
	private static function _ReadFloat(v:TVectorBuffer):Single {
		return 0.0;
	}

	@:hlNative("Urho3D", "_io_t_vector_buffer_read_vector2")
	private static function _ReadVector2(v:TVectorBuffer):TVector2 {
		return null;
	}

	@:hlNative("Urho3D", "_io_t_vector_buffer_read_vector3")
	private static function _ReadVector3(v:TVectorBuffer):TVector3 {
		return null;
	}
}
