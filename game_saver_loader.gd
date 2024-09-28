extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func save_game(file_name: String, tiles: Array[GridTileData]):
	var save_file = FileAccess.open(file_name, FileAccess.WRITE)
	var save_dict = {}
	
	save_dict["tiles"] = []
	for tile in tiles:
		save_dict["tiles"].append(tile.save())
	
	var json_string = JSON.stringify(save_dict)
	save_file.store_line(json_string)


func load_game(file_name: String, grid_map: CustomGridMap):
	if not FileAccess.file_exists(file_name):
		return # Error! We don't have a save to load.
	
	var save_file = FileAccess.open(file_name, FileAccess.READ)
	var json_string = save_file.get_line()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

	# Get the data from the JSON object
	var load_data = json.get_data()
	
	load_grid(grid_map, load_data["tiles"])


func load_grid(grid_map: CustomGridMap, tiles_data: Array):
	grid_map.clear_grid()

	for tile_data in tiles_data:
		var tile = GridTileData.new(tile_data["x"], tile_data["z"], tile_data["y"], tile_data["g_tex_idx"],
			tile_data["w_tex_idx"], tile_data["tt"], tile_data["r"])
		grid_map.grid_map.append(tile)

	grid_map.connect_tiles_signals()
	grid_map._setup_grid()
