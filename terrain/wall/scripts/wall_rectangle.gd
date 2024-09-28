@tool
extends BaseWallMultiMesh


func _create_array_mesh():
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_material(mesh_material)

	var offset_vector = Vector3(Global.WIDTH_SCALE/2.0, 0.0, Global.WIDTH_SCALE/2.0)

	st.set_uv(Vector2(0, 0))
	st.add_vertex(Vector3(0, 0, 0)-offset_vector)
	st.set_uv(Vector2(0, 1))
	st.add_vertex(Vector3(0, Global.HEIGHT_SCALE, 0)-offset_vector)
	st.set_uv(Vector2(1, 0))
	st.add_vertex(Vector3(0, 0, Global.WIDTH_SCALE)-offset_vector)
	
	st.set_uv(Vector2(0, 1))
	st.add_vertex(Vector3(0, Global.HEIGHT_SCALE, 0)-offset_vector)
	st.set_uv(Vector2(1, 1))
	st.add_vertex(Vector3(0, Global.HEIGHT_SCALE, Global.WIDTH_SCALE)-offset_vector)
	st.set_uv(Vector2(1, 0))
	st.add_vertex(Vector3(0, 0, Global.WIDTH_SCALE)-offset_vector)
	
	st.generate_normals()
	array_mesh = st.commit()


func _calculate_mesh_position_rotation():
	var mesh_data: Dictionary = {}
	
	for x in range(grid_map.GRID_SIZE):
		for z in range(grid_map.GRID_SIZE):
			var current_tile = grid_map.get_tile_from_xz(x, z)
			var tile_mesh_data = []
			var current_height = current_tile.height

			var previous_tile = grid_map.get_tile_from_xz(x-1, z)
			var previous_height = Global.MIN_HEIGHT
			if(previous_tile):
				previous_height = previous_tile.height
			
			if current_tile._top_type == GridTileData.TileTopType.TWO_CORNER_UP:
				var _rotation = wrapi(current_tile._rotation + 2, 0, 4)
				tile_mesh_data.append({ "x": x, "y": current_tile.height, "z": z, "rotation_idx": _rotation})
				
			if current_tile._top_type == GridTileData.TileTopType.THREE_CORNER_UP:
				var _rotation_1 = wrapi(current_tile._rotation + 1, 0, 4)
				var _rotation_2 = wrapi(current_tile._rotation + 2, 0, 4)
				tile_mesh_data.append({ "x": x, "y": current_tile.height, "z": z, "rotation_idx": _rotation_1})
				tile_mesh_data.append({ "x": x, "y": current_tile.height, "z": z, "rotation_idx": _rotation_2})
			
			for height in range(previous_height, current_height):
				tile_mesh_data.append({ "x": x, "y": height, "z": z, "rotation_idx": 0})
			if current_tile._top_type == GridTileData.TileTopType.DIAGONAL_SLOPE and current_tile._rotation in [2, 3]:
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": 0})
			
			previous_tile = grid_map.get_tile_from_xz(x, z-1)
			previous_height = Global.MIN_HEIGHT
			if(previous_tile):
				previous_height = previous_tile.height
			
			for height in range(previous_height, current_height):
				tile_mesh_data.append({ "x": x, "y": height, "z": z, "rotation_idx": 3})
			if current_tile._top_type == GridTileData.TileTopType.DIAGONAL_SLOPE and current_tile._rotation in [1, 2]:
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": 3})
			
			previous_tile = grid_map.get_tile_from_xz(x+1, z)
			previous_height = Global.MIN_HEIGHT
			if(previous_tile):
				previous_height = previous_tile.height
			
			for height in range(previous_height, current_height):
				tile_mesh_data.append({ "x": x, "y": height, "z": z, "rotation_idx": 2})
			if current_tile._top_type == GridTileData.TileTopType.DIAGONAL_SLOPE and current_tile._rotation in [0, 1]:
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": 2})
				
			previous_tile = grid_map.get_tile_from_xz(x, z+1)
			previous_height = Global.MIN_HEIGHT
			if(previous_tile):
				previous_height = previous_tile.height
			
			for height in range(previous_height, current_height):
				tile_mesh_data.append({ "x": x, "y": height, "z": z, "rotation_idx": 1})
			if current_tile._top_type == GridTileData.TileTopType.DIAGONAL_SLOPE and current_tile._rotation in [3, 0]:
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": 1})

			mesh_data[current_tile] = tile_mesh_data

	return mesh_data
