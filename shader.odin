package odingl

import os "core:os/os2"
import gl "vendor:OpenGL"

ShaderType :: enum {
	Fragment       = 0x8B30,
	Vertex         = 0x8B31,
	Geometry       = 0x8DD9,
	Compute        = 0x91B9,
	TessEvaluation = 0x8E87,
	TessControl    = 0x8E88,
}

Shader :: struct {
	id:   u32,
	type: ShaderType,
}

shader_compile_file :: proc(path: string, type: ShaderType) -> (id: u32, err: Error) {

	shader_file := os.open(path) or_return
	defer os.close(shader_file)


	shader_data := os.read_entire_file(shader_file, context.allocator) or_return
	defer delete(shader_data)

	shader_id := shader_compile_source(shader_data, type) or_return

	return shader_id, nil
}

shader_compile_source :: proc(src: []u8, type: ShaderType) -> (id: u32, err: Error) {
	id = gl.CreateShader(u32(type))
	length := i32(len(src))
	shader_cpy := cstring(raw_data(src))

	gl.ShaderSource(id, 1, &shader_cpy, &length)
	gl.CompileShader(id)

	return id, get_shader_error(id)
}

shader_create_from_file :: proc(path: string, type: ShaderType) -> (shader: Shader, err: Error) {
	id := shader_compile_file(path, type) or_return

	return Shader{id = id, type = type}, nil
}

shader_create_from_source :: proc(src: []u8, type: ShaderType) -> (shader: Shader, err: Error) {
	id, compile_err := shader_compile_source(src, type)

	return Shader{type = type, id = id}, compile_err
}

shader_create :: proc {
	shader_create_from_source,
	shader_create_from_file,
}

shader_delete :: proc(shader: Shader) {
	gl.DeleteShader(shader.id)
}
