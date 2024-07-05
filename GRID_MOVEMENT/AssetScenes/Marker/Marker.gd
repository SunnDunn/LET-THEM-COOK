extends CharacterBody3D

const SPEED = 300

var click_position = Vector3()
var target_position = Vector3()

func _ready():
	click_position = position

func _physics_process(delta):
	#if Input.is_action_just_pressed("left_click"):
		

	if (position.distance_to(click_position) > 3):
		target_position = (click_position - position).normalized()
		velocity = target_position * SPEED
		move_and_slide()
