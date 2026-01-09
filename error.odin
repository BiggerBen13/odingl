package odingl

import os "core:os/os2"
import gl "vendor:OpenGL"

@(private, thread_local)
last_shader_error_message: []u8

@(private, thread_local)
last_program_error_message: []u8

ShaderError :: distinct string

ProgramError :: distinct string

OsError :: os.Error

ErrorLen :: 256

Error :: union {
	OsError,
    ShaderError,
    ProgramError,
}

get_shader_error :: proc(id: u32) -> (err: Error) {
	result, log_len: i32
	gl.GetShaderiv(id, gl.COMPILE_STATUS, cast(^i32)&result)

	if result != 0 {
		return err
	}

	gl.GetShaderiv(id, gl.INFO_LOG_LENGTH, &log_len)

    delete(last_shader_error_message)
    last_shader_error_message = make([]u8, log_len)

	gl.GetShaderInfoLog(id, log_len, nil, raw_data(last_shader_error_message))

    return ShaderError(string(last_shader_error_message[:log_len - 1]))
}

get_program_error :: proc(id: u32) -> (err: Error) {
	result, log_len: i32
	gl.GetProgramiv(id, gl.LINK_STATUS, cast(^i32)&result)

	if result != 0 {
		return nil
	}

	gl.GetProgramiv(id, gl.INFO_LOG_LENGTH, &log_len)

    delete(last_program_error_message)
    last_shader_error_message = make([]u8, log_len)

	gl.GetProgramInfoLog(id, log_len, nil, raw_data(last_program_error_message))

    return ProgramError(string(last_program_error_message[:log_len - 1]))
}
