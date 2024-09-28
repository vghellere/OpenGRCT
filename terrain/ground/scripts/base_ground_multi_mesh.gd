@tool
extends MultiMeshInstance3D
class_name BaseGroundMultiMesh

@export var collision_area_3d : Area3D
@export var mesh_material: Material

const ROTATION_ANGLES = [
	deg_to_rad(0),
	deg_to_rad(90),
	deg_to_rad(180),
	deg_to_rad(270),
]

const TILE_OFFSET_VECTOR = Vector3(Global.WIDTH_SCALE/2.0, 0.0, Global.WIDTH_SCALE/2.0)

var array_mesh: ArrayMesh
var tile_to_instance_idx_map = {}

func _setup(tiles: Array[GridTileData]):
	tile_to_instance_idx_map.clear()
	_create_array_mesh()
	setup_multimesh(tiles.size())
	setup_mesh_and_collision_shapes(tiles)

func _create_array_mesh():
	pass
	#var st = SurfaceTool.new()
	#st.begin(Mesh.PRIMITIVE_TRIANGLES)
	#st.set_material(mesh_material)
	#st.set_normal(Vector3.UP)
	#st.set_uv(Vector2(0, 0))
	#st.add_vertex(Vector3(0, 0, 0))
	#st.set_uv(Vector2(1, 0))
	#st.add_vertex(Vector3(3, 0, 0))
	#st.set_uv(Vector2(0, 1))
	#st.add_vertex(Vector3(0, 0, 3))
	#
	##st.set_normal(Vector3.UP.rotated(Vector3.BACK, deg_to_rad(45.0)).rotated(Vector3.RIGHT, deg_to_rad(-45.0)))
	#st.set_uv(Vector2(1, 0))
	#st.add_vertex(Vector3(3, 0, 0))
	#st.set_uv(Vector2(1, 1))
	##st.add_vertex(Vector3(3, Global.HEIGHT_SCALE, 3))
	#st.add_vertex(Vector3(3, 0, 3))
	#st.set_uv(Vector2(0, 1))
	#st.add_vertex(Vector3(0, 0, 3))
	#
	#array_mesh = st.commit()


func setup_mesh_and_collision_shapes(tiles: Array[GridTileData]):
	var triangle_data = PackedVector3Array()

	var instance_idx = 0
	for tile in tiles:
		tile_to_instance_idx_map[tile] = instance_idx
		setup_mesh_instance(tile, instance_idx)
		triangle_data.append_array(setup_collision_triangle_data(tile))
		instance_idx += 1

	var collision_shape = CollisionShape3D.new()
	var concave_poly_shape = ConcavePolygonShape3D.new()

	# TODO: simplify the triangle data by removing redundunt triangles in order to improve performance
	concave_poly_shape.set_faces(triangle_data)
	collision_shape.shape = concave_poly_shape

	collision_area_3d.add_child(collision_shape, false, Node.INTERNAL_MODE_DISABLED)
	collision_shape.owner = get_owner()


func setup_multimesh(instance_count):
	multimesh = MultiMesh.new()
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.use_custom_data = true
	multimesh.instance_count = instance_count
	multimesh.mesh = array_mesh


func setup_mesh_instance(tile: GridTileData, instance_idx):
	var t = Transform3D(transform)
	t = t.rotated_local(
			Vector3.UP, ROTATION_ANGLES[tile._rotation]
		).translated(
			Vector3(
				tile.x * Global.WIDTH_SCALE,
				tile.height * Global.HEIGHT_SCALE,
				tile.z * Global.WIDTH_SCALE
			) + Vector3(Global.WIDTH_SCALE/2.0, 0.0, Global.WIDTH_SCALE/2.0)
		)
	multimesh.set_instance_transform(instance_idx, t)


func setup_collision_triangle_data(tile: GridTileData):
	var offset_position = Vector3(
		tile.x * Global.WIDTH_SCALE,
		tile.height * Global.HEIGHT_SCALE,
		tile.z * Global.WIDTH_SCALE
	)
	var faces = array_mesh.get_faces()
	for face_idx in faces.size():
		var face = faces[face_idx].rotated(Vector3.UP, ROTATION_ANGLES[tile._rotation])
		faces[face_idx] = face + TILE_OFFSET_VECTOR + offset_position

	return faces


func get_instance_idx_from_tile(tile: GridTileData) -> int:
	return tile_to_instance_idx_map.get(tile, -1)


func send_tile_data_to_shader(tile: GridTileData):
	var instance_idx = get_instance_idx_from_tile(tile)
	
	if(instance_idx>=0 and instance_idx<multimesh.instance_count):
		multimesh.set_instance_custom_data(instance_idx, Color(tile.ground_texture_idx, tile.highlighted, tile._rotation))
