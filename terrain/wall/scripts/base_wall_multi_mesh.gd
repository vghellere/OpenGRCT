@tool
extends MultiMeshInstance3D
class_name BaseWallMultiMesh

@export var mesh_material: Material

const ROTATION_ANGLES = [
	deg_to_rad(0),
	deg_to_rad(90),
	deg_to_rad(180),
	deg_to_rad(270),
]

#const TILE_OFFSET_VECTOR = Vector3(0.0, 0.0, Global.WIDTH_SCALE/2.0)

var array_mesh: ArrayMesh
var grid_map: CustomGridMap
var tile_to_instances_idx_map = {}

func _setup(_grid_map: CustomGridMap):
	grid_map = _grid_map
	tile_to_instances_idx_map.clear()
	_create_array_mesh()

	var mesh_data: Dictionary = _calculate_mesh_position_rotation()
	var instance_count = 0
	for value in mesh_data.values():
		instance_count += value.size()
	setup_multimesh(instance_count)
	setup_meshes(mesh_data)

func _create_array_mesh():
	pass


func _calculate_mesh_position_rotation():
	pass


func setup_meshes(mesh_data: Dictionary):
	var instance_idx = 0
	for tile_mesh_data in mesh_data:
		var mesh_instance_idx_list = []
		for mesh_instance_data in mesh_data[tile_mesh_data]:
			mesh_instance_idx_list.append(instance_idx)
			setup_mesh_instance(mesh_instance_data, instance_idx)
			instance_idx += 1
			
		tile_to_instances_idx_map[tile_mesh_data] = mesh_instance_idx_list


func setup_multimesh(instance_count):
	multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.use_custom_data = true
	multimesh.instance_count = instance_count
	multimesh.mesh = array_mesh


func setup_mesh_instance(mesh_instance_data: Dictionary, instance_idx):
	var t = Transform3D(transform)
	t = t.rotated_local(
			Vector3.UP, ROTATION_ANGLES[mesh_instance_data["rotation_idx"]]
		).translated(
			Vector3(
				mesh_instance_data["x"] * Global.WIDTH_SCALE,
				mesh_instance_data["y"] * Global.HEIGHT_SCALE,
				mesh_instance_data["z"] * Global.WIDTH_SCALE
			) + Vector3(Global.WIDTH_SCALE/2.0, 0.0, Global.WIDTH_SCALE/2.0)
		)
	multimesh.set_instance_transform(instance_idx, t)


func get_instance_idx_list_from_tile(tile: GridTileData) -> Array:
	return tile_to_instances_idx_map.get(tile, [])


func send_tile_data_to_shader(tile: GridTileData):
	var instance_idx_list = get_instance_idx_list_from_tile(tile)
	
	if instance_idx_list.size() == 0:
		return
	
	for instance_idx in instance_idx_list:
		if(instance_idx < multimesh.instance_count):
			multimesh.set_instance_custom_data(instance_idx, Color(tile.wall_texture_idx, 0.0, 0.0))
