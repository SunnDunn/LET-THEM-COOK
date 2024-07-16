extends RayCast3D

@onready var mainBody = $".."
var camera : Camera3D
var rayOrigin = Vector3()
var rayEnd = Vector3()

func _ready():
	camera = get_viewport().get_camera_3d()
	return

func _process(delta):
	#_lookAtMouse()
	return

func _lookAtMouse():
	var space_state = get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	rayOrigin = camera.project_ray_origin(mouse_pos)
	rayEnd = rayOrigin + camera.project_ray_normal(mouse_pos) * 200
	var query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	var intersection = space_state.intersect_ray(query)
	if not intersection.is_empty():
		var pos = intersection.position
		target_position = Vector3(-pos.x, mainBody.transform.origin.y, -pos.z).normalized() * 3
	return
