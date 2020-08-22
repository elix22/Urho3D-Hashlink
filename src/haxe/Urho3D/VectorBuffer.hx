package urho3d;


typedef HL_URHO3D_VECTOR_BUFFER = hl.Abstract<"hl_urho3d_io_vector_buffer">

abstract VectorBuffer(HL_URHO3D_VECTOR_BUFFER) {
	public inline function new() {
		this = Create();
	}

	@:hlNative("Urho3D", "_io_vector_buffer_create")
	private static function Create():HL_URHO3D_VECTOR_BUFFER {
		return null;
	}

}