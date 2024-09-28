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
	
	st.generate_normals()
	array_mesh = st.commit()


func _calculate_mesh_position_rotation():
	var mesh_data: Dictionary = {}
	
	for x in range(grid_map.GRID_SIZE):
		for z in range(grid_map.GRID_SIZE):
			var current_tile = grid_map.get_tile_from_xz(x, z)
			var tile_mesh_data = []

			if(current_tile._top_type == GridTileData.TileTopType.FLAT):
				continue
			
			var current_height = current_tile.height
			
			if current_tile._top_type == GridTileData.TileTopType.DIAGONAL_SLOPE:
				var _rotation_1 = wrapi(current_tile._rotation + 3, 0, 4)
				var _rotation_2 = wrapi(current_tile._rotation + 2, 0, 4)
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": _rotation_1})
				tile_mesh_data.append({ "x": x, "y": current_height+1, "z": z, "rotation_idx": _rotation_2})
			
			if current_tile._top_type == GridTileData.TileTopType.ONE_CORNER_UP:
				var _rotation = wrapi(current_tile._rotation+2, 0, 4)
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": _rotation})
			
			if current_tile._top_type == GridTileData.TileTopType.TWO_CORNER_UP:
				var _rotation = wrapi(current_tile._rotation + 3, 0, 4)
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": _rotation})
			
			if current_tile._top_type == GridTileData.TileTopType.THREE_CORNER_UP:
				var _rotation = wrapi(current_tile._rotation - 1, 0, 4)
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": _rotation})
				
			if current_tile._top_type == GridTileData.TileTopType.V:
				var _rotation_1 = wrapi(current_tile._rotation, 0, 4)
				var _rotation_2 = wrapi(current_tile._rotation+2, 0, 4)
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": _rotation_1})
				tile_mesh_data.append({ "x": x, "y": current_height, "z": z, "rotation_idx": _rotation_2})

			mesh_data[current_tile] = tile_mesh_data

	return mesh_data
