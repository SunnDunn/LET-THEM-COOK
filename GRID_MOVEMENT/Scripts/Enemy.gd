extends Area3D

#CONSTANTS
const ROT_SPEED = 2

#initialize values
var sceneNum = 1
var nextScene 

@onready var turnHandler = $UnitTurnHandler

# Called when the node enters the scene tree for the first time.
func _ready():
	input_ray_pickable = true
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg_to_rad(ROT_SPEED))
	
func _changeSceneToLoad():
	if(sceneNum == 1):
		sceneNum + 1
		nextScene = load("res://GRID_MOVEMENT/Scenes/Stage2_Sample.tscn")
	elif(sceneNum == 2):
		sceneNum - 1
		nextScene = load("res://GRID_MOVEMENT/Scenes/Stage1_Sample.tscn")
	
func _on_body_entered(body):
	queue_free()
	_changeSceneToLoad()
	get_tree().change_scene_to_packed(nextScene)
	
func _input_event(camera, event, position, normal, shape_idx):
	if (!turnHandler.canMove):
		return
	if (event.is_pressed()):
		print("Clicked!")
		turnHandler.EndTurn()
	return
