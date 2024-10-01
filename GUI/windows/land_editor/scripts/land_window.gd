extends Window


@onready var selected_tile_top_idx : int = 0
@onready var selected_tile_edge_idx : int = 0
@onready var change_tile_top_enabled : bool = false
@onready var change_tile_edge_enabled : bool = false

var shovel_icon = load("res://art/shovel.png")

func _on_close_requested():
	hide()


func _on_visibility_changed():
	if visible:
		on_window_open()
	else:
		on_window_close()


func on_window_open():
	Global.show_grid_lines = true
	Input.set_custom_mouse_cursor(shovel_icon, 0, Vector2(0, 32))


func on_window_close():
	Input.set_custom_mouse_cursor(null)


func _on_land_style_options_item_selected(index):
	change_tile_top_enabled = false
	
	if index > 0:
		change_tile_top_enabled = true
		selected_tile_top_idx = index - 1


func _on_land_edge_options_item_selected(index):
	change_tile_edge_enabled = false
	
	if index > 0:
		change_tile_edge_enabled = true
		selected_tile_edge_idx = index - 1
