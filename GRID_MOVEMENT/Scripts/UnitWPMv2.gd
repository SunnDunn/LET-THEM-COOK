extends CharacterBody3D

@export var target_pos : Vector3

var speed = 100

func _physics_process(delta):
	var direction = position.direction_to(target_pos)
	velocity = direction * speed * delta
	move_and_slide()
