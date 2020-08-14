package urho3d;



/// Texture filtering mode.
enum abstract TextureFilterMode(Int) to Int from Int {
	var FILTER_NEAREST = 0;
	var FILTER_BILINEAR;
	var FILTER_TRILINEAR;
	var FILTER_ANISOTROPIC;
	var FILTER_NEAREST_ANISOTROPIC;
	var FILTER_DEFAULT;
	var MAX_FILTERMODES;
}

/// Texture addressing mode.
enum abstract TextureAddressMode(Int) to Int from Int {
	var ADDRESS_WRAP = 0;
	var ADDRESS_MIRROR;
	var ADDRESS_CLAMP;
	var ADDRESS_BORDER;
	var MAX_ADDRESSMODES;
}

/// Texture coordinates.
enum abstract TextureCoordinate(Int) to Int from Int {
	var COORD_U = 0;
	var COORD_V;
	var COORD_W;
	var MAX_COORDS;
}

/// Texture usage types.
enum abstract TextureUsage(Int) to Int from Int {
	var TEXTURE_STATIC = 0;
	var TEXTURE_DYNAMIC;
	var TEXTURE_RENDERTARGET;
	var TEXTURE_DEPTHSTENCIL;
}

/// Cube map faces.
enum abstract CubeMapFace(Int) to Int from Int {
	var FACE_POSITIVE_X = 0;
	var FACE_NEGATIVE_X;
	var FACE_POSITIVE_Y;
	var FACE_NEGATIVE_Y;
	var FACE_POSITIVE_Z;
	var FACE_NEGATIVE_Z;
	var MAX_CUBEMAP_FACES;
}

/// Cubemap single image layout modes.
enum abstract CubeMapLayout(Int) to Int from Int {
	var CML_HORIZONTAL = 0;
	var CML_HORIZONTALNVIDIA;
	var CML_HORIZONTALCROSS;
	var CML_VERTICALCROSS;
	var CML_BLENDER;
}

/// Update mode for render surface viewports.
enum abstract RenderSurfaceUpdateMode(Int) to Int from Int {
	var SURFACE_MANUALUPDATE = 0;
	var SURFACE_UPDATEVISIBLE;
	var SURFACE_UPDATEALWAYS;
}

/// Shader types.
enum abstract ShaderType(Int) to Int from Int {
	var VS = 0;
	var PS;
}

/// Shader parameter groups for determining need to update. On APIs that support constant buffers; these correspond to different constant buffers.
enum abstract ShaderParameterGroup(Int) to Int from Int {
	var SP_FRAME = 0;
	var SP_CAMERA;
	var SP_ZONE;
	var SP_LIGHT;
	var SP_MATERIAL;
	var SP_OBJECT;
	var SP_CUSTOM;
	var MAX_SHADER_PARAMETER_GROUPS;
}

/// Texture units.
enum abstract TextureUnit(Int) to Int from Int {
	var TU_DIFFUSE = 0;
	var TU_ALBEDOBUFFER = 0;
	var TU_NORMAL = 1;
	var TU_NORMALBUFFER = 1;
	var TU_SPECULAR = 2;
	var TU_EMISSIVE = 3;
	var TU_ENVIRONMENT = 4;
	#if DESKTOP_GRAPHICS_OR_GLES3
	var TU_VOLUMEMAP = 5;
	var TU_CUSTOM1 = 6;
	var TU_CUSTOM2 = 7;
	var TU_LIGHTRAMP = 8;
	var TU_LIGHTSHAPE = 9;
	var TU_SHADOWMAP = 10;
	var TU_FACESELECT = 11;
	var TU_INDIRECTION = 12;
	var TU_DEPTHBUFFER = 13;
	var TU_LIGHTBUFFER = 14;
	var TU_ZONE = 15;
	var MAX_MATERIAL_TEXTURE_UNITS = 8;
	var MAX_TEXTURE_UNITS = 16;
	#else
	var TU_LIGHTRAMP = 5;
	var TU_LIGHTSHAPE = 6;
	var TU_SHADOWMAP = 7;
	var MAX_MATERIAL_TEXTURE_UNITS = 5;
	var MAX_TEXTURE_UNITS = 8;
	#end
}

/// Billboard camera facing modes.
enum abstract FaceCameraMode(Int) to Int from Int {
	var FC_NONE = 0;
	var FC_ROTATE_XYZ;
	var FC_ROTATE_Y;
	var FC_LOOKAT_XYZ;
	var FC_LOOKAT_Y;
	var FC_LOOKAT_MIXED;
	var FC_DIRECTION;
}

/// Shadow type.
enum abstract ShadowQuality(Int) to Int from Int {
	var SHADOWQUALITY_SIMPLE_16BIT = 0;
	var SHADOWQUALITY_SIMPLE_24BIT;
	var SHADOWQUALITY_PCF_16BIT;
	var SHADOWQUALITY_PCF_24BIT;
	var SHADOWQUALITY_VSM;
	var SHADOWQUALITY_BLUR_VSM;
}

enum abstract MaterialQuality(Int) to Int from Int {
	var QUALITY_LOW = 0;
	var QUALITY_MEDIUM = 1;
	var QUALITY_HIGH = 2;
	var QUALITY_MAX = 15;
}

enum abstract ClearTarget(Int) to Int from Int {
	var CLEAR_COLOR = 0x1;
	var CLEAR_DEPTH = 0x2;
	var CLEAR_STENCIL = 0x4;
}

// Legacy vertex element bitmasks.
enum abstract VertexMask(Int) to Int from Int {
	var MASK_NONE = 0x0;
	var MASK_POSITION = 0x1;
	var MASK_NORMAL = 0x2;
	var MASK_COLOR = 0x4;
	var MASK_TEXCOORD1 = 0x8;
	var MASK_TEXCOORD2 = 0x10;
	var MASK_CUBETEXCOORD1 = 0x20;
	var MASK_CUBETEXCOORD2 = 0x40;
	var MASK_TANGENT = 0x80;
	var MASK_BLENDWEIGHTS = 0x100;
	var MASK_BLENDINDICES = 0x200;
	var MASK_INSTANCEMATRIX1 = 0x400;
	var MASK_INSTANCEMATRIX2 = 0x800;
	var MASK_INSTANCEMATRIX3 = 0x1000;
	var MASK_OBJECTINDEX = 0x2000;
}

enum abstract GraphicsConst(Int) to Int from Int {
	var MAX_RENDERTARGETS = 4;
	var MAX_VERTEX_STREAMS = 4;
	var MAX_CONSTANT_REGISTERS = 256;
	var BITS_PER_COMPONENT = 8;
}

enum abstract GLDefines(Int) to Int from Int {
	var GL_RED = 0x1903;
	var GL_GREEN = 0x1904;
	var GL_BLUE = 0x1905;
	var GL_ALPHA = 0x1906;
	var GL_RGB = 0x1907;
	var GL_RGBA = 0x1908;
	var GL_LUMINANCE = 0x1909;
	var GL_LUMINANCE_ALPHA = 0x190A;
	var GL_RGBA8UI = 0x8D7C;
	var GL_VERTEX_ELEMENT_SWIZZLE_AMD = 0x91A4;
	var GL_VERTEX_ID_SWIZZLE_AMD = 0x91A5;
	var GL_R8 = 0x8229;
	var GL_R16 = 0x822A;
	var GL_RG8 = 0x822B;
	var GL_RG16 = 0x822C;
	var GL_R16F = 0x822D;
	var GL_R32F = 0x822E;
	var GL_RG16F = 0x822F;
	var GL_RG32F = 0x8230;
	var GL_R8I = 0x8231;
	var GL_R8UI = 0x8232;
	var GL_R16I = 0x8233;
	var GL_R16UI = 0x8234;
	var GL_R32I = 0x8235;
	var GL_R32UI = 0x8236;
	var GL_RG8I = 0x8237;
	var GL_RG8UI = 0x8238;
	var GL_RG16I = 0x8239;
	var GL_RG16UI = 0x823A;
	var GL_RG32I = 0x823B;
	var GL_RG32UI = 0x823C;
	var GL_RGB4 = 0x804F;
	var GL_RGB5 = 0x8050;
	var GL_RGB8 = 0x8051;
	var GL_RGB10 = 0x8052;
	var GL_RGB12 = 0x8053;
	var GL_RGB16 = 0x8054;
	var GL_RGBA2 = 0x8055;
	var GL_RGBA4 = 0x8056;
	var GL_RGB5_A1 = 0x8057;
	var GL_RGBA8 = 0x8058;
	var GL_RGB10_A2 = 0x8059;
	var GL_RGBA12 = 0x805A;
	var GL_RGBA16 = 0x805B;
	var GL_DEPTH_COMPONENT16 = 0x81A5;
	var GL_DEPTH_COMPONENT24 = 0x81A6;
	var GL_DEPTH_COMPONENT32 = 0x81A7;
	var GL_DEPTH_STENCIL = 0x84F9;
	var GL_UNSIGNED_INT_24_8 = 0x84FA;
	var GL_DEPTH24_STENCIL8 = 0x88F0;
	var GL_TEXTURE_STENCIL_SIZE = 0x88F1;
	var GL_UNSIGNED_NORMALIZED = 0x8C17;
	var GL_DEPTH_STENCIL_EXT = 0x84F9;
	var GL_UNSIGNED_INT_24_8_EXT = 0x84FA;
	var GL_DEPTH24_STENCIL8_EXT = 0x88F0;
	var GL_TEXTURE_STENCIL_SIZE_EXT = 0x88F1;
	var GL_RGBA32F_ARB = 0x8814;
	var GL_RGB32F_ARB = 0x8815;
	var GL_ALPHA32F_ARB = 0x8816;
	var GL_INTENSITY32F_ARB = 0x8817;
	var GL_LUMINANCE32F_ARB = 0x8818;
	var GL_LUMINANCE_ALPHA32F_ARB = 0x8819;
	var GL_RGBA16F_ARB = 0x881A;
	var GL_RGB16F_ARB = 0x881B;
	var GL_ALPHA16F_ARB = 0x881C;
	var GL_INTENSITY16F_ARB = 0x881D;
	var GL_LUMINANCE16F_ARB = 0x881E;
	var GL_LUMINANCE_ALPHA16F_ARB = 0x881F;
	var GL_TEXTURE_RED_TYPE_ARB = 0x8C10;
	var GL_TEXTURE_GREEN_TYPE_ARB = 0x8C11;
	var GL_TEXTURE_BLUE_TYPE_ARB = 0x8C12;
	var GL_TEXTURE_ALPHA_TYPE_ARB = 0x8C13;
	var GL_TEXTURE_LUMINANCE_TYPE_ARB = 0x8C14;
	var GL_TEXTURE_INTENSITY_TYPE_ARB = 0x8C15;
	var GL_TEXTURE_DEPTH_TYPE_ARB = 0x8C16;
	var GL_UNSIGNED_NORMALIZED_ARB = 0x8C17;
}
