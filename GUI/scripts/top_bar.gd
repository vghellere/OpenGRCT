extends ColorRect


@onready var land_window : Window = %LandWindow


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_land_button_pressed():
	if land_window.visible:
		land_window.hide()
	else:
		land_window.show()


func _on_show_hide_grid_lines_pressed():
	Global.show_grid_lines = not Global.show_grid_lines
