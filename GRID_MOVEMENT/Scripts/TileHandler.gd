extends Area3D

@export var friendlyUnit : Node

var meshInst : MeshInstance3D

func _ready():
	input_ray_pickable = true
	meshInst = $MeshInstance3D
	return

func _process(delta):
	if (TurnManager.CurrentTurn == "Player"):
		friendlyUnit = TurnManager.CurrentUnitTurn
	else:
		friendlyUnit = null

func _input_event(camera, event, position, normal, shape_idx):
	if (event.is_pressed() && friendlyUnit != null):
		friendlyUnit.target_pos = self.position
	return


func _on_body_entered(body):
	if (body.is_in_group("FriendlyUnit")):
		meshInst.visible = false
	pass # Replace with function body.


func _on_body_exited(body):
	if (body.is_in_group("FriendlyUnit")):
		meshInst.visible = true
	pass # Replace with function body.
