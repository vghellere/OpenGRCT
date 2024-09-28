extends Node


@onready var grid_map: CustomGridMap = $"../GridMap"
@onready var game_saver_loader = $"../GameSaverLoader"


func _ready():
	$"../GUI/ShowHideGridLines".button_pressed = Global.show_grid_lines
	$"../GUI/TerraformEnabled".button_pressed = Global.terraform_enabled
	$"../GUI/ChangeTileTopEnabled".button_pressed = Global.change_tile_top_enabled
	$"../GUI/ChangeTileWallEnabled".button_pressed = Global.change_tile_wall_enabled
	$"../GUI/TerrainAlphaSlider".value = Global.terrain_alpha
	$"../GUI/WallAlphaSlider".value = Global.wall_alpha


func _on_show_hide_grid_lines():
	Global.show_grid_lines = not Global.show_grid_lines


func _on_terraform_enabled_pressed():
	Global.terraform_enabled = not Global.terraform_enabled


func _on_change_tile_wall_enabled_pressed():
	Global.change_tile_wall_enabled = not Global.change_tile_wall_enabled


func _on_change_tile_top_enabled_pressed():
	Global.change_tile_top_enabled = not Global.change_tile_top_enabled


func _on_save_game_pressed():
	game_saver_loader.save_game("user://savegame.save", grid_map.grid_map)


func _on_load_game_pressed():
	game_saver_loader.load_game("user://savegame.save", grid_map)


func _on_terrain_alpha_slider_value_changed(value):
	Global.terrain_alpha = value


func _on_wall_alpha_slider_value_changed(value):
	Global.wall_alpha = value
