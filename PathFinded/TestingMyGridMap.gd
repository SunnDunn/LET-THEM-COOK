extends Node3D

@onready var goal = $Goal

func _physics_process(delta):
	get_tree().call_group("enemies", "update_target_location",goal.global_transform.origin)
