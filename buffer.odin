package odingl

import gl "vendor:OpenGL"
import "core:slice"

BufferTarget :: enum u32 {
    ArrayBuffer = gl.ARRAY_BUFFER,

    AtomicCounterBuffer = gl.ATOMIC_COUNTER_BUFFER,

    CopyReadBuffer = gl.COPY_READ_BUFFER,
    CopyWriteBuffer = gl.COPY_WRITE_BUFFER,

    DispatchIndirectBuffer = gl.DISPATCH_INDIRECT_BUFFER,
    DrawIndirectBuffer = gl.DRAW_INDIRECT_BUFFER,

    ElementArrayBuffer = gl.ELEMENT_ARRAY_BUFFER,

    PixelBackBuffer = gl.PIXEL_PACK_BUFFER,
    PixelUnpackBuffer = gl.PIXEL_UNPACK_BUFFER,

    QueryBuffer = gl.QUERY_BUFFER,

    ShaderStorageBuffer = gl.SHADER_STORAGE_BUFFER,
    TextureBuffer = gl.TEXTURE_BUFFER,
    TransformFeedbackBuffer = gl.TRANSFORM_FEEDBACK_BUFFER,
    UniformBuffer = gl.UNIFORM_BUFFER,
}

BufferUsage :: enum u32 {
    StreamDraw = gl.STREAM_DRAW,
    StreamRead = gl.STREAM_READ,
    StreamCopy = gl.STREAM_COPY,

    StaticDraw = gl.STATIC_DRAW,
    StaticRead = gl.STATIC_READ,
    StaticCopy = gl.STATIC_COPY,

    DynamicDraw = gl.DYNAMIC_DRAW,
    DynamicRead = gl.DYNAMIC_READ,
    DynamicCopy = gl.DYNAMIC_COPY,
}

Buffer :: struct {
	id: u32,
}

buffer_create :: proc(buffer: ^Buffer) {
	gl.GenBuffers(1, &buffer.id)
}

buffer_make :: proc() -> (buffer: Buffer) {
    buffer_create(&buffer)
    return buffer
}

buffers_create :: proc(buffers: []Buffer) {
	buf_ids := make([]u32, len(buffers))
	defer delete(buf_ids)
	gl.GenBuffers(i32(len(buffers)), raw_data(buf_ids))

	for id, index in buf_ids {
		buffers[index] = Buffer {
			id = id,
		}
	}
}

buffers_make :: proc(num: int) -> (buffers: []Buffer) {
    buffers = make([]Buffer, num)
    buffers_create(buffers)
    return buffers
}

buffer_delete :: proc(buffer: ^Buffer) {
    gl.DeleteBuffers(1, &buffer.id)
}

buffers_destroy :: proc(buffers: []Buffer) {
    buffers_delete(buffers)
    delete(buffers)
}

buffers_delete :: proc(buffers: []Buffer) {
	buffer_ids := make([]u32, len(buffers))
    defer delete(buffer_ids)

    for buffer, index in buffers {
        buffer_ids[index] = buffer.id
    }

	gl.DeleteBuffers(i32(len(buffers)), raw_data(buffer_ids))
}

buffer_bind :: proc(buffer: Buffer, target: BufferTarget) {
    gl.BindBuffer(u32(target), buffer.id)
}

buffer_data :: proc(buffer: Buffer, target: BufferTarget, data: []$T,  usage: BufferUsage) {
    gl.BufferData(u32(target), len(data) * size_of(T), raw_data(data), u32(usage))
}
