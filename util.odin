package odingl

import gl "vendor:OpenGL"

Color :: distinct [4]f32

Mask :: enum u32 {
	Color   = gl.COLOR_BUFFER_BIT,
	Depth   = gl.DEPTH_BUFFER_BIT,
	Stencil = gl.STENCIL_BUFFER_BIT,
}

gl_init :: proc(proc_addr: gl.Set_Proc_Address_Type, major: int = 3, minor: int = 3) {
	gl.load_up_to(major, minor, proc_addr)
}

// Can be called to prevent leaking the last error message but shouldn't be problematic
gl_deinit :: proc() {
    delete(last_program_error_message)
    delete(last_shader_error_message)
}

viewport_set :: proc "c" (x, y, width, height: i32) {
	gl.Viewport(x, y, width, height)
}

viewport_clear :: proc "c" (mask: Mask) {
	gl.Clear(u32(mask))
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
