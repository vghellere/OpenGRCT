extends RefCounted
class_name GridTileData

signal drawing_property_changed(tile: GridTileData)
signal tile_structure_changed(tile: GridTileData)

enum TileTopType { FLAT, ONE_CORNER_UP, TWO_CORNER_UP, THREE_CORNER_UP, DIAGONAL_SLOPE, V }
enum TileHighlight { DISABLED, FULL, CORNER_1, CORNER_2, CORNER_3, CORNER_4 }

var x: int
var z: int

var height: int
var _rotation: int
var _top_type: TileTopType

var ground_texture_idx: int:
	set(value):
		ground_texture_idx = value
		on_change_drawing_property()

var wall_texture_idx: int:
	set(value):
		wall_texture_idx = value
		on_change_drawing_property()


var highlighted: TileHighlight:
	set(value):
		highlighted = value
		on_change_drawing_property()


func save():
	var save_dict = {
		"x": x,
		"z": z,
		"y": height,
		"g_tex_idx": ground_texture_idx,
		"w_tex_idx": wall_texture_idx,
		"tt": _top_type,
		"r": _rotation,
	}
	return save_dict


func _init(_x: int, _z: int, _height: int, _ground_texture_idx: int, _wall_texture_idx: int,
		__top_type: TileTopType = TileTopType.FLAT, __rotation: int = 0):
	x = _x
	z = _z
	height = _height
	ground_texture_idx = _ground_texture_idx
	wall_texture_idx = _wall_texture_idx
	_top_type = __top_type
	_rotation = __rotation
	highlighted = TileHighlight.DISABLED


func shape_up_down(is_up: bool):
	var highlight_delta = int(TileHighlight.FULL)
	
	if highlighted in [TileHighlight.CORNER_1, TileHighlight.CORNER_2, TileHighlight.CORNER_3, TileHighlight.CORNER_4]:
		highlight_delta = highlighted + _rotation
		if highlight_delta > TileHighlight.CORNER_4:
			highlight_delta -= 4
	
	var shape_up_down_info = GroundTileHelpers.SHAPE_UP_DOWN_INFO.get(_top_type).get(highlight_delta)
	var action = "up" if is_up else "down"
	
	if(shape_up_down_info[action].has("height")):
		if(height + shape_up_down_info[action]["height"] < Global.MIN_HEIGHT):
			return
		height += shape_up_down_info[action]["height"]
		
	if(shape_up_down_info[action].has("rotation")):
		var _temp_rotation = shape_up_down_info[action]["rotation"] + _rotation
		if _temp_rotation > 3:
			_temp_rotation -= 4
		_rotation = _temp_rotation
		
	if(shape_up_down_info[action].has("new_tile_type")):
		_top_type = shape_up_down_info[action]["new_tile_type"]
	
	on_change_tile_structure()


func on_change_tile_structure():
	tile_structure_changed.emit(self)


func on_change_drawing_property():
	drawing_property_changed.emit(self)
