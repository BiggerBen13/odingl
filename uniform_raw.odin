package odingl

import intr "base:intrinsics"
import gl "vendor:OpenGl"

uniform_set_f32 :: proc(location: i32, value: f32) {
    gl.Uniform1f(location, value)
}

uniform_set_2f32 :: proc(location: i32, value: [2]f32) {
    gl.Uniform2f(location, value.x, value.y)
}

uniform_set_3f32 :: proc(location: i32, value: [3]f32) {
    gl.Uniform3f(location, value.x, value.y, value.z)
}

uniform_set_4f32 :: proc(location: i32, value: [4]f32) {
    gl.Uniform4f(location, value.x, value.y, value.z, value.w)
}

// 4x4 f32 Matrix single

uniform_set_mat4x4f32 :: proc(location: i32, transpose: bool, value: ^matrix[4,4]f32) {
    uniform_set_raw4x4f32(location, transpose, cast([^]f32)value)
}

uniform_set_raw4x4f32 :: proc(location: i32, transpose: bool, value: [^]f32) {
    gl.UniformMatrix4fv(location, 1, transpose, value)
}

uniform_set_4x4f32 :: proc {
    uniform_set_mat4x4f32,
    uniform_set_raw4x4f32,
}

// 3x3 f32 Matrix single

uniform_set_mat3x3f32 :: proc(location: i32, transpose: bool, value: matrix[3,3]f32) {
    flat_matrix := intr.matrix_flatten(value)
    uniform_set_raw3x3f32(location, transpose, flat_matrix[:])
}

uniform_set_raw3x3f32 :: proc(location: i32, transpose: bool, value: []f32) {
    gl.UniformMatrix3fv(location, 1, transpose, raw_data(value))
}

uniform_set_3x3f32 :: proc {
    uniform_set_mat3x3f32,
    uniform_set_raw3x3f32,
}

// 2x2 f32 Matrix single

uniform_set_mat2x2f32 :: proc(location: i32, transpose: bool, value: matrix[2,2]f32) {
    flat_matrix := intr.matrix_flatten(value)
    uniform_set_raw2x2f32(location, transpose, flat_matrix[:])
}

uniform_set_raw2x2f32 :: proc(location: i32, transpose: bool, value: []f32) {
    gl.UniformMatrix3fv(location, 1, transpose, raw_data(value))
}

uniform_set_2x2f32 :: proc {
    uniform_set_mat2x2f32,
    uniform_set_raw2x2f32,
}
