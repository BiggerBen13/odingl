package odingl

import gl "vendor:OpenGL"

DrawMode :: enum u32 {
    Triangles = gl.TRIANGLES,
    TriangleStrip = gl.TRIANGLE_STRIP,
    TriangleFan = gl.TRIANGLE_FAN,
    TriangleFanAdjacency = gl.TRIANGLE_STRIP_ADJACENCY,
    TrianglesAdjacency = gl.TRIANGLES_ADJACENCY,

    Lines = gl.LINES,
    LineStrip = gl.LINE_STRIP,
    LineStripAdjacency = gl.LINE_STRIP_ADJACENCY,
    LinesAdjacency = gl.LINES_ADJACENCY,
    LineLoop = gl.LINE_LOOP,

    Patches = gl.PATCHES,
}

IndexType :: enum u32 {
    uByte = gl.UNSIGNED_BYTE,
    uShort = gl.UNSIGNED_SHORT,
    uInt = gl.UNSIGNED_INT,
}

draw_arrays :: proc(mode: DrawMode, first, count: i32) {
    gl.DrawArrays(u32(mode), first, count)
}

draw_elements_instanced_base_vertex :: proc(mode: DrawMode, count: i32, type: IndexType, indices: rawptr, instance_count: i32, base_vertex: i32) {
    gl.DrawElementsInstancedBaseVertex(u32(mode), count, u32(type), indices, instance_count, base_vertex)
}
