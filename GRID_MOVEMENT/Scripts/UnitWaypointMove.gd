extends Node3D

@onready var mainBody = $".."
@onready var turnHandler = $"../UnitTurnHandler"

var speed = 10

func _ready():
	turnHandler.canMove = true
	return

func _physics_process(delta):
	if (!turnHandler.canMove):
		return
		
	if Input.is_action_just_pressed("ui_focus_next"):
		position.x += 10
		
		#mainBody.position.x = move_toward(
			#mainBody.position.x,
			#position.x,
			#speed * delta
		#)
		
		var direction = mainBody.global_transform.origin.direction_to(position)
		mainBody.velocity = direction * speed * delta
		mainBody.move_and_slide()
		
	if (mainBody.position == position):
		print("Done!")
		turnHandler.EndTurn()
	return
