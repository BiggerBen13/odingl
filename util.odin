package odingl

import gl "vendor:OpenGL"

Color :: distinct [4]f32

MaskBit :: enum u8 {
	Color   = 14, // gl.COLOR_BUFFER_BIT
	Depth   = 8, // gl.DEPTH_BUFFER_BIT
	Stencil = 10, // gl.STENCIL_BUFFER_BIT,
}

Capability :: enum u32 {
    Blend = gl.BLEND,
    ClipDistance0 = gl.CLIP_DISTANCE0,
    ClipDistance1 = gl.CLIP_DISTANCE1,
    ClipDistance2 = gl.CLIP_DISTANCE2,
    ClipDistance3 = gl.CLIP_DISTANCE3,
    ClipDistance4 = gl.CLIP_DISTANCE4,
    ClipDistance5 = gl.CLIP_DISTANCE5,
    ClipDistance6 = gl.CLIP_DISTANCE6,
    ClipDistance7 = gl.CLIP_DISTANCE7,
    ColorLogicOp = gl.COLOR_LOGIC_OP,
    CullFace = gl.CULL_FACE,
    DebugOutput = gl.DEBUG_OUTPUT,
    DebugOuputSynchronus = gl.DEBUG_OUTPUT_SYNCHRONOUS,
    DepthClamp = gl.DEPTH_CLAMP,
    DepthTest = gl.DEPTH_TEST,
    Dither = gl.DITHER,
    FrameBufferSRGB = gl.FRAMEBUFFER_SRGB,
    LineSmooth = gl.LINE_SMOOTH,
    Multisample = gl.MULTISAMPLE,
    PolygonOffsetFill = gl.POLYGON_OFFSET_FILL,
    PolygonOffsetLine = gl.POLYGON_OFFSET_LINE,
    PolygonOffsetPoint = gl.POLYGON_OFFSET_POINT,
    PolygonSmooth = gl.POLYGON_SMOOTH,
    PrimitiveRestart = gl.PRIMITIVE_RESTART,
    PrimitiveRestartFixedIndex = gl.PRIMITIVE_RESTART_FIXED_INDEX,
    RasterizerDiscard = gl.RASTERIZER_DISCARD,
    SampleAlphaToCoverate = gl.SAMPLE_ALPHA_TO_COVERAGE,
    SampleAlphaToOne = gl.SAMPLE_ALPHA_TO_ONE,
    SampleCoverage = gl.SAMPLE_COVERAGE,
    SampleShading = gl.SAMPLE_SHADING,
    SampleMask = gl.SAMPLE_MASK,
    ScissorTest = gl.SCISSOR_TEST,
    StencilTest = gl.STENCIL_TEST,
    TextureCubeMapSeamless = gl.TEXTURE_CUBE_MAP_SEAMLESS,
    ProgramPointSize = gl.PROGRAM_POINT_SIZE,
}

Mask :: bit_set[MaskBit; u32]

gl_init :: proc(proc_addr: gl.Set_Proc_Address_Type, major: int = 3, minor: int = 3) {
	gl.load_up_to(major, minor, proc_addr)
}

// Can be called to prevent leaking the last error message but shouldn't be problematic
gl_deinit :: proc() {
    delete(last_program_error_message)
    delete(last_shader_error_message)
}

gl_enable :: proc(cap: Capability) {
    gl.Enable(u32(cap))
}

gl_disable :: proc(cap: Capability) {
    gl.Disable(u32(cap))
}

viewport_set :: proc "c" (x, y, width, height: i32) {
	gl.Viewport(x, y, width, height)
}

viewport_clear :: proc "c" (mask: Mask) {
	gl.Clear(transmute(u32)mask)
}

@(private)
_clear_color_vec :: proc "c" (color: Color) {
	gl.ClearColor(color.x, color.y, color.z, color.w)
}

@(private)
_clear_color_val :: proc "c" (r, g, b, a: f32) {
	gl.ClearColor(r, g, b, a)
}

viewport_clear_color :: proc {
	_clear_color_val,
	_clear_color_vec,
}
