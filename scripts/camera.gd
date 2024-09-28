extends Camera3D

const RAY_LENGTH = 1000.0
const CORNER_THRESHOLD = 0.35

@export var grid_map: CustomGridMap;
@onready var viewport: Viewport = get_viewport()
@onready var world_3d: World3D = get_world_3d()

var _previous_tile: GridTileData
var _mouse_pressed: bool = false
var _mouse_pressed_start_pos: Vector2


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_mouse_pressed = true
			_mouse_pressed_start_pos = event.position

			if(_previous_tile):
				if Global.change_tile_top_enabled:
					_previous_tile.ground_texture_idx = 1
				if Global.change_tile_wall_enabled:
					_previous_tile.wall_texture_idx = 1
		
		else:
			_mouse_pressed = false
			
	if event is InputEventMouseMotion and _mouse_pressed:
		if Global.terraform_enabled and _previous_tile:
			var y_diff = _mouse_pressed_start_pos.y - event.position.y
			if y_diff > 28:
				_mouse_pressed_start_pos = event.position
				_previous_tile.shape_up_down(true)
			elif y_diff < -28:
				_mouse_pressed_start_pos = event.position
				_previous_tile.shape_up_down(false)


func _physics_process(_delta):
	cast_ray_to_ground()


func cast_ray_to_ground():
	if(_mouse_pressed):
		return

	var space_state = world_3d.direct_space_state
	var mouse_pos = viewport.get_mouse_position()

	var origin = project_ray_origin(mouse_pos)
	var end = origin + project_ray_normal(mouse_pos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_bodies = false
	query.collide_with_areas = true
	query.collision_mask = 2

	var result = space_state.intersect_ray(query)
	
	if(not result):
		if(_previous_tile):
			_previous_tile.highlighted = GridTileData.TileHighlight.DISABLED

		_previous_tile = null
		return
		
	var x = int(result.position.x/Global.WIDTH_SCALE)
	var z = int(result.position.z/Global.WIDTH_SCALE)
	var entered_new_tile = false
		
	if(not _previous_tile):
		_previous_tile = grid_map.get_tile_from_xz(x, z)
		entered_new_tile = true
	elif(_previous_tile.x != x or _previous_tile.z != z):
		entered_new_tile = true
	
	if(entered_new_tile):
		_previous_tile.highlighted = GridTileData.TileHighlight.DISABLED
		
		_previous_tile = grid_map.get_tile_from_xz(x, z)
	if Global.terraform_enabled:
		_highlight_tile(_previous_tile, result.position)


func _highlight_tile(tile: GridTileData, mouse_world_position: Vector3):
	var diff_vector = Vector2(
		mouse_world_position.x - tile.x * Global.WIDTH_SCALE,
		mouse_world_position.z - tile.z * Global.WIDTH_SCALE
	) / Global.WIDTH_SCALE
	
	if(diff_vector.x <= CORNER_THRESHOLD and diff_vector.y <= CORNER_THRESHOLD):
		_previous_tile.highlighted = GridTileData.TileHighlight.CORNER_1
	elif(diff_vector.x >= 1.0 - CORNER_THRESHOLD and diff_vector.y <= CORNER_THRESHOLD):
		_previous_tile.highlighted = GridTileData.TileHighlight.CORNER_2
	elif(diff_vector.x >= 1.0 - CORNER_THRESHOLD and diff_vector.y >= 1.0 - CORNER_THRESHOLD):
		_previous_tile.highlighted = GridTileData.TileHighlight.CORNER_3
	elif(diff_vector.x <= CORNER_THRESHOLD and diff_vector.y >= 1.0 - CORNER_THRESHOLD):
		_previous_tile.highlighted = GridTileData.TileHighlight.CORNER_4
	else:
		_previous_tile.highlighted = GridTileData.TileHighlight.FULL
