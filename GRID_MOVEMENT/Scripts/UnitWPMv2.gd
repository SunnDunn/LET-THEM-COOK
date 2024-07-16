extends CharacterBody3D

var target_pos
@onready var turnHandler = $UnitTurnHandler

var speed = 6

func _ready():
	target_pos = position

func _physics_process(delta):
	if (!turnHandler.canMove):
		return
	#var direction = position.direction_to(target_pos)
	#velocity = direction * speed * delta
	#move_and_slide()
	position.x = move_toward(position.x, target_pos.x, speed * delta)
	position.z = move_toward(position.z, target_pos.z, speed * delta)
	
	if (Input.is_action_pressed("ui_accept")):
		turnHandler.EndTurn()
