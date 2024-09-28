extends Node3D

const ROTATION_OFFSET = deg_to_rad(90.0)
const MOVE_SPEED = 15.0
const ROTATION_MATRIX = [deg_to_rad(0.0), deg_to_rad(90.0), deg_to_rad(180.0), deg_to_rad(270.0)]
const MOVE_MATRIX: Array[Vector3] = [Vector3(-1.0, 0, 1.0), Vector3(1.0, 0, 1.0), Vector3(1.0, 0, -1.0), Vector3(-1.0, 0, -1.0)]

var camera_rotation: int = 0

func _input(event):
	if event.is_action_pressed("camera_rotate"):
		camera_rotation = wrapi(camera_rotation + 1, 0, 4)
		rotation.y = ROTATION_MATRIX[camera_rotation]


func _process(delta):
	if Input.is_action_pressed("camera_move_right"):
		var move_idx = wrapi(0 + camera_rotation, 0, 4)
		position = position + (MOVE_MATRIX[move_idx] * MOVE_SPEED * delta)
		
	if Input.is_action_pressed("camera_move_up"):
		var move_idx = wrapi(1 + camera_rotation, 0, 4)
		position = position + (MOVE_MATRIX[move_idx] * MOVE_SPEED * delta)
		
	if Input.is_action_pressed("camera_move_left"):
		var move_idx = wrapi(2 + camera_rotation, 0, 4)
		position = position + (MOVE_MATRIX[move_idx] * MOVE_SPEED * delta)
		
	if Input.is_action_pressed("camera_move_down"):
		var move_idx = wrapi(3 + camera_rotation, 0, 4)
		position = position + (MOVE_MATRIX[move_idx] * MOVE_SPEED * delta)
