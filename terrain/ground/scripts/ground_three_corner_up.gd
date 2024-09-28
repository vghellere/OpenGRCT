@tool
extends BaseGroundMultiMesh


func _create_array_mesh():
	var st = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	st.set_material(mesh_material)
	
	var offset_vector = Vector3(Global.WIDTH_SCALE/2.0, 0.0, Global.WIDTH_SCALE/2.0)
	
	st.set_uv(Vector2(0, 0))
	st.add_vertex(Vector3(0, 0, 0) - offset_vector)
	st.set_uv(Vector2(1, 0))
	st.add_vertex(Vector3(Global.WIDTH_SCALE, Global.HEIGHT_SCALE, 0) - offset_vector)
	st.set_uv(Vector2(0, 1))
	st.add_vertex(Vector3(0, Global.HEIGHT_SCALE, Global.WIDTH_SCALE) - offset_vector)
	
	st.set_uv(Vector2(1, 0))
	st.add_vertex(Vector3(Global.WIDTH_SCALE, Global.HEIGHT_SCALE, 0) - offset_vector)
	st.set_uv(Vector2(1, 1))
	st.add_vertex(Vector3(Global.WIDTH_SCALE, Global.HEIGHT_SCALE, Global.WIDTH_SCALE) - offset_vector)
	st.set_uv(Vector2(0, 1))
	st.add_vertex(Vector3(0, Global.HEIGHT_SCALE, Global.WIDTH_SCALE) - offset_vector)
	
	st.generate_normals()
	array_mesh = st.commit()

