package odingl

import gl "vendor:OpenGL"

AttribDescriptor :: struct {
	size:      i32,
	type:      AttribType,
	normalize: bool,
	stride:    i32,
	pointer:   uintptr,
}

AttribType :: enum u32 {
	Byte      = gl.BYTE,
	uByte     = gl.UNSIGNED_BYTE,
	Short     = gl.SHORT,
	uShort    = gl.UNSIGNED_SHORT,
	Int       = gl.INT,
	uInt      = gl.UNSIGNED_INT,
	HalfFloat = gl.HALF_FLOAT,
	Float     = gl.FLOAT,
	Double    = gl.DOUBLE,
}

Program :: struct {
	id:       u32,
	uniforms: gl.Uniforms,
}

program_create_and_link :: proc(shaders: []Shader) -> (program: Program, err: Error) {

	program.id = gl.CreateProgram()

    program_link(&program, shaders) or_return

	uniforms := gl.get_uniforms_from_program(program.id)

	return program, nil 
}

program_link :: proc(program: ^Program, shaders: []Shader) -> Error {

	for shader, index in shaders {
        gl.AttachShader(program.id, shader.id)
	}

	gl.LinkProgram(program.id)
    return get_program_error(program.id)
}

program_use :: proc(program: Program) {
	gl.UseProgram(program.id)
}

program_delete :: proc(program: Program) {
	gl.DeleteProgram(program.id)
	gl.destroy_uniforms(program.uniforms)
}
