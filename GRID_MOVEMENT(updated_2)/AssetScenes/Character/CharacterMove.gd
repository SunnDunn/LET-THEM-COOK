extends CharacterBody3D

# Attributes
var speed = 3
var accel = 10
# Other Attributes
var agility = 5

@onready var nav: NavigationAgent3D = $NavigationAgent3D

# GETTERS AND SETTERS
func get_agility() -> int:
	return agility

func _ready():
	set_physics_process(false)
	await get_tree().physics_frame
	set_physics_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = velocity.move_toward(new_velocity, 0.25)
	move_and_slide()

func update_target_location(target_location):
	nav.set_target_position(target_location)
	
func disable_nav_agent():
	#nav.NODE_PROCESS_DISABLED
	pass
