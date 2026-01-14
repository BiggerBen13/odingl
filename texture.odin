package odingl

import gl "vendor:OpenGL"

Texture :: struct {
	id: u32,
}

TextureParameterName :: enum {
	DepthStencilTextureMode = gl.DEPTH_STENCIL_TEXTURE_MODE,
	TextureBaseLevel = gl.TEXTURE_BASE_LEVEL,
	TextureCompareFunc = gl.TEXTURE_COMPARE_FUNC,
	TextureCompareMode = gl.TEXTURE_COMPARE_MODE,
	TextureLodBias = gl.TEXTURE_LOD_BIAS,
	TextureMinFilter = gl.TEXTURE_MIN_FILTER,
	TextureMagFilter = gl.TEXTURE_MAG_FILTER,
	TextureMinLod = gl.TEXTURE_MIN_LOD,
	TextureMaxLod = gl.TEXTURE_MAX_LOD,
	TextureMaxLevel = gl.TEXTURE_MAX_LEVEL,
	TextureSwizzleR = gl.TEXTURE_SWIZZLE_R,
	TextureSwizzleG = gl.TEXTURE_SWIZZLE_G,
	TextureSwizzleB = gl.TEXTURE_SWIZZLE_B,
	TextureWrapS = gl.TEXTURE_WRAP_S,
	TextureWrapT = gl.TEXTURE_WRAP_T,
	TextureWrapR = gl.TEXTURE_WRAP_R,
}

texture_create :: proc(texture: ^Texture) {
	gl.GenTextures(1, &texture.id)
}

texture_make :: proc() -> (texture: Texture) {
	texture_create(&texture)
	return texture
}

textures_create :: proc(textures: []Texture) {
	texture_ids := make([]u32, len(textures))
	defer delete(texture_ids)

	gl.GenTextures(i32(len(textures)), raw_data(texture_ids))

	for id, index in texture_ids {
		textures[index] = Texture {
			id = id,
		}
	}
}

textures_make :: proc(num: int) -> (textures: []Texture) {
	textures = make([]Texture, num)
	textures_create(textures)
	return textures
}

texture_delete :: proc(texture: ^Texture) {
	gl.DeleteTextures(1, &texture.id)
}

textures_destroy :: proc(textures: []Texture) {
	textures_delete(textures)
	delete(textures)
}

textures_delete :: proc(textures: []Texture) {
	texture_ids := make([]u32, len(textures))
	defer delete(texture_ids)

	for texture, index in textures {
		texture_ids[index] = texture.id
	}

	gl.DeleteTextures(i32(len(textures)), raw_data(texture_ids))
}

texture_bind :: proc(texture: Texture) {

}

texture_parameter :: proc(texture: Texture, parameter_name: TextureParameter, parameter: i32) {
    gl.TexParameteri()

}
