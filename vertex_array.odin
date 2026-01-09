package odingl
import gl "vendor:OpenGl"

VertexArray :: struct {
	id: u32,
}

vertex_array_make :: proc() -> (vertex_array: VertexArray) {
	vertex_array_create(&vertex_array)
	return vertex_array
}

vertex_array_create :: proc(vertex_array: ^VertexArray) {
	gl.GenVertexArrays(1, &vertex_array.id)
}

vertex_arrays_make :: proc(num: int) -> (vertex_arrays: []VertexArray) {
    vertex_arrays = make([]VertexArray, num)
    vertex_arrays_create(vertex_arrays)
    return vertex_arrays
}

vertex_arrays_create :: proc(vertex_arrays: []VertexArray) {
	vertex_array_ids := make([]u32, len(vertex_arrays))
	defer delete(vertex_array_ids)

	gl.GenVertexArrays(i32(len(vertex_array_ids)), raw_data(vertex_array_ids))

	for vertex_array_id, index in vertex_array_ids {
		vertex_arrays[index].id = vertex_array_id
	}
}

vertex_array_unbind :: proc () {
    gl.BindVertexArray(0)
}

vertex_array_bind :: proc (vertex_array: VertexArray) {
    gl.BindVertexArray(vertex_array.id)
}

vertex_arrays_destroy :: proc(vertex_arrays: []VertexArray) {
    vertex_arrays_delete(vertex_arrays)
    delete(vertex_arrays)
}

vertex_arrays_delete :: proc(vertex_arrays: []VertexArray) {
    vertex_array_ids := make([]u32, len(vertex_arrays))
    defer delete(vertex_array_ids)

    for vertex_array, index in vertex_arrays {
        vertex_array_ids[index] = vertex_array.id
    }

    gl.DeleteVertexArrays(i32(len(vertex_array_ids)), raw_data(vertex_array_ids))
}

vertex_array_delete :: proc(vertex_array: ^VertexArray) {
    gl.DeleteVertexArrays(1, &vertex_array.id)
}

vertex_attributes_set :: proc(index: u32, attrib: AttribDescriptor) {
    gl.VertexAttribPointer(index, attrib.size, u32(attrib.type), attrib.normalize, attrib.stride, 0)
    gl.EnableVertexAttribArray(index)
}

vertex_attribute_set_divisor :: proc(index: u32, divisor: u32) {
    gl.VertexAttribDivisor(index, divisor)
}
