extends Sprite3D

#CONSTANTS
const SPEED = 2
#OTHER ATTRIBUTES
var _coinCount = 5
var _hearts = 3.5

var _name = "Robot"

func _ready():
	print(_name)

func _process(delta):
	if(Input.is_action_pressed("ui_left")):
		rotate_y(deg_to_rad(-SPEED))
	elif(Input.is_action_pressed("ui_right")):
		rotate_y(deg_to_rad(SPEED))
