extends Node

@onready var grid_map: CustomGridMap = $"../GridMap"
@onready var game_saver_loader = $"../GameSaverLoader"

func _ready():
	pass
	

func _on_save_game_pressed():
	game_saver_loader.save_game("user://savegame.save", grid_map.grid_map)


func _on_load_game_pressed():
	game_saver_loader.load_game("user://savegame.save", grid_map)
