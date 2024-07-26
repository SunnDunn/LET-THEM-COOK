extends CharacterBody3D

#CONSTANTS
const SPEED = 2.0
const JUMP_VELOCITY = 4.5
#VARIABLES
var curPos = [1, 1, 1] #initialize position
var isCollided = false

var moveCap = 3
var freeMoves = moveCap
var usedMoves = 0

# Get Gravity
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func onMove():
	if(freeMoves != 0 and usedMoves != moveCap):
		freeMoves - 1
		usedMoves + 1
	else:
		freeMoves = 0
		usedMoves = moveCap

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if(freeMoves != 0):
		#X-axis gridlock
		if (Input.is_action_just_pressed("ui_right")):
			if(self.position.x > -9):
				curPos[0] -= 2
				onMove()
			else:
				self.position = self.position
		if (Input.is_action_just_pressed("ui_left")):
			if(self.position.x < 9):
				curPos[0] += 2
				onMove()
			else:
				self.position = self.position
		#Z-axis gridlock
		if (Input.is_action_just_pressed("ui_up")):
			if(self.position.z < 9):
				curPos[2] += 2
				onMove()
			else:
				self.position = self.position
		if (Input.is_action_just_pressed("ui_down")):
			if(self.position.z > -9):
				curPos[2] -= 2
				onMove()
			else:
				self.position = self.position
	else:
		self.position = self.position
		isCollided = false
	
	self.position = Vector3(curPos[0], self.position.y , curPos[2])

func _on_rigid_body_3d_body_entered(body):
	isCollided = true
