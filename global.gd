extends Node

const WIDTH_SCALE = 3
const HEIGHT_SCALE = 1.2
const MIN_HEIGHT = -5

var show_grid_lines : bool = true : set = _set_show_grid_lines;
var terrain_alpha : float = 1.0 : set = _set_terrain_alpha;
var wall_alpha : float = 1.0 : set = _set_wall_alpha;

func _set_show_grid_lines(value):
	show_grid_lines = value
	RenderingServer.global_shader_parameter_set("show_grid_lines", show_grid_lines)

func _set_terrain_alpha(value: float):
	terrain_alpha = value
	RenderingServer.global_shader_parameter_set("terrain_alpha", terrain_alpha)
	

func _set_wall_alpha(value: float):
	wall_alpha = value
	RenderingServer.global_shader_parameter_set("wall_alpha", wall_alpha)
