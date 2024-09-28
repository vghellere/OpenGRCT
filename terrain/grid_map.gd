@tool
extends Node3D
class_name CustomGridMap

const GRID_SIZE = 16

@export var create_grid : bool = false : set = _create_grid
@export var refresh : bool = false : set = _set_refresh
@export var ground_material: Material
@export var floor_textures : Array[Resource]
@export var wall_material: Material
@export var wall_textures : Array[Resource]

@onready var ground_flat = $GroundFlat
@onready var ground_one_corner_up = $GroundOneCornerUp
@onready var ground_two_corner_up = $GroundTwoCornerUp
@onready var ground_three_corner_up = $GroundThreeCornerUp
@onready var ground_diagonal_slope = $GroundDiagonalSlope
@onready var ground_v_corner_up = $GroundVCornerUp
@onready var collision_area_3d = $CollisionArea3D

@onready var wall_rectangle = $WallRectangle
@onready var wall_triangle_up = $WallTriangleUp
@onready var wall_triangle_down = $WallTriangleDown


var grid_map: Array[GridTileData] = []

func _create_grid(_value):
	_create_random_grid()
	_setup()


func _set_refresh(_value):
	if(grid_map.is_empty()):
		_create_random_grid()
	_setup()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	if(not Engine.is_editor_hint()):
		_create_random_grid()
		_setup()
	

func _setup():
	print("Refreshing...")
	var time_start = Time.get_ticks_msec()
	
	_setup_textures()
	_setup_grid()

	print(Time.get_ticks_msec() - time_start)

func _setup_textures():
	ground_material.set_shader_parameter("texture_albedo", floor_textures)
	wall_material.set_shader_parameter("texture_albedo", wall_textures)


func clear_grid():
	disconnect_tiles_signals()
	grid_map.clear()


func _create_random_grid():
	clear_grid()

	for z in GRID_SIZE:
		for x in GRID_SIZE:
			var tile = GridTileData.new(x, z, 0,  randi_range(0, 0), randi_range(0, 0))
			
			grid_map.append(tile)
	connect_tiles_signals()


func connect_tiles_signals():
	for tile in grid_map:
		tile.drawing_property_changed.connect(_on_tile_drawing_data_changed)
		tile.tile_structure_changed.connect(_on_tile_structure_changed)


func disconnect_tiles_signals():
	for tile in grid_map:
		tile.drawing_property_changed.disconnect(_on_tile_drawing_data_changed)
		tile.tile_structure_changed.disconnect(_on_tile_structure_changed)


func _setup_grid():
	delete_all_collision_shapes()

	ground_flat._setup(grid_map.filter(func(tile: GridTileData): return tile._top_type == GridTileData.TileTopType.FLAT))
	ground_one_corner_up._setup(grid_map.filter(func(tile: GridTileData): return tile._top_type == GridTileData.TileTopType.ONE_CORNER_UP))
	ground_two_corner_up._setup(grid_map.filter(func(tile: GridTileData): return tile._top_type == GridTileData.TileTopType.TWO_CORNER_UP))
	ground_three_corner_up._setup(grid_map.filter(func(tile: GridTileData): return tile._top_type == GridTileData.TileTopType.THREE_CORNER_UP))
	ground_diagonal_slope._setup(grid_map.filter(func(tile: GridTileData): return tile._top_type == GridTileData.TileTopType.DIAGONAL_SLOPE))
	ground_v_corner_up._setup(grid_map.filter(func(tile: GridTileData): return tile._top_type == GridTileData.TileTopType.V))
	
	wall_rectangle._setup(self)
	wall_triangle_up._setup(self)
	wall_triangle_down._setup(self)
	
	_send_tiles_data_to_shader()

func delete_all_collision_shapes():
	for i in range(collision_area_3d.get_child_count()):
		var collision_shape = collision_area_3d.get_child(i)
		collision_shape.queue_free()


func _send_tiles_data_to_shader():
	for tile in grid_map:
		tile.on_change_drawing_property()

func _on_tile_structure_changed(_tile: GridTileData):
	_setup()

func _on_tile_drawing_data_changed(tile: GridTileData):
	ground_flat.send_tile_data_to_shader(tile)
	ground_one_corner_up.send_tile_data_to_shader(tile)
	ground_two_corner_up.send_tile_data_to_shader(tile)
	ground_three_corner_up.send_tile_data_to_shader(tile)
	ground_diagonal_slope.send_tile_data_to_shader(tile)
	ground_v_corner_up.send_tile_data_to_shader(tile)
	
	wall_rectangle.send_tile_data_to_shader(tile)
	wall_triangle_up.send_tile_data_to_shader(tile)
	wall_triangle_down.send_tile_data_to_shader(tile)

func get_tile_from_xz(x: int, z: int) -> GridTileData:
	if(
		x < 0 or x >= GRID_SIZE
		or z < 0 or z >= GRID_SIZE
	):
		return null

	var tile_idx = GRID_SIZE*z+x
	return grid_map[tile_idx]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
