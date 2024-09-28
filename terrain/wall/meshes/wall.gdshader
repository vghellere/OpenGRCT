// NOTE: Shader automatically converted from Godot Engine 4.2.2.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix,depth_draw_always,cull_back,diffuse_burley,specular_schlick_ggx;
uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo[16] : source_color,filter_linear_mipmap,repeat_enable;
uniform vec3 uv1_offset;
global uniform bool show_grid_lines = false;
global uniform float wall_alpha = 1.0;
varying vec4 custom_data;
const float grid_line_percent = 0.02;


// this is a workaround because in openGL 3 you can't index texture with variables, only consts
vec4 get_albedo_texture(int idx, vec2 uv) {
	vec4 albedo_tex;
	switch (idx){
        case 0:
            albedo_tex = texture(texture_albedo[0], uv);
            break;
        case 1:
            albedo_tex = texture(texture_albedo[1], uv);
            break;
        case 2:
            albedo_tex = texture(texture_albedo[2], uv);
            break;
		case 3:
            albedo_tex = texture(texture_albedo[3], uv);
            break;
		case 4:
            albedo_tex = texture(texture_albedo[4], uv);
            break;
		case 5:
            albedo_tex = texture(texture_albedo[5], uv);
            break;
		case 6:
            albedo_tex = texture(texture_albedo[6], uv);
            break;
		case 7:
            albedo_tex = texture(texture_albedo[7], uv);
            break;
		case 8:
            albedo_tex = texture(texture_albedo[8], uv);
            break;
		case 9:
            albedo_tex = texture(texture_albedo[9], uv);
            break;
		case 10:
            albedo_tex = texture(texture_albedo[10], uv);
            break;
		case 11:
            albedo_tex = texture(texture_albedo[11], uv);
            break;
		case 12:
            albedo_tex = texture(texture_albedo[12], uv);
            break;
		case 13:
            albedo_tex = texture(texture_albedo[13], uv);
            break;
		case 14:
            albedo_tex = texture(texture_albedo[14], uv);
            break;
		case 15:
            albedo_tex = texture(texture_albedo[15], uv);
            break;
    }
	return albedo_tex;
}

vec2 rotateUV(vec2 uv, float rotation)
{
	float rotation_rad = 0.0;
	switch(int(rotation)){
		case 0:
			rotation_rad = radians(0);
			break;
		case 1:
			rotation_rad = radians(90);
			break;
		case 2:
			rotation_rad = radians(180);
			break;
		case 3:
			rotation_rad = radians(270);
			break;
	}
	
    float mid = 0.5;
    float cosAngle = cos(rotation_rad);
    float sinAngle = sin(rotation_rad);
	vec2 p = uv - vec2(0.5);
    return vec2(
        cosAngle * p.x + sinAngle * p.y + mid,
        cosAngle * p.y - sinAngle * p.x + mid
    );
}

void vertex() {
	/*
		CUSTOM_DATA
		x == texture_id
		y == highlight
		z == rotation index
	*/
	custom_data = INSTANCE_CUSTOM;
	UV=UV; // rotateUV(UV, custom_data.z); //*uv1_scale.xy; //+vec2(INSTANCE_CUSTOM.x, 0.0);
}

void fragment() {
	vec2 base_uv = UV;
	int texture_index = int(custom_data.x);
	vec4 albedo_tex = get_albedo_texture(texture_index, base_uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
	ALPHA = albedo.a;
	ALPHA = wall_alpha;

	if(show_grid_lines &&
		((UV.x < grid_line_percent)
		 || (UV.x > 1.0-grid_line_percent)
		|| (UV.y < grid_line_percent)
		|| (UV.y > 1.0 - grid_line_percent))
	)
	{
		ALBEDO = ALBEDO * 0.4;
	}
}
