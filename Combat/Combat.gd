extends Node

class_name Combat

@export var parentNode: Node3D
var parent

func _ready() -> void:
	parent = parentNode.get_node("Stats")

func attack():
	var raycast = parentNode.get_node("RayCast3D")
	
	raycast.set_target_position(Vector3(parent.RANGE, 0, 0))
	
	print(raycast.get_parent().name + " Target Position " + str(raycast.get_target_position().x))
	
	raycast.force_raycast_update()
	
	if raycast.is_colliding():
		if raycast.get_collider().get_parent().name != parent.name:
			var opponent = get_tree().root.find_child(raycast.get_collider().name, true, false).get_node("Stats")
			
			if opponent.defendCheck == true:
				opponent.takeDMG(opponent.defend(parent.DMG))
			else:
				opponent.takeDMG(parent.DMG)
	else:
		print("ice wallow come")

func defend():
	parent.defendCheck = true

func heal():
	parent.heal(randi() % (3 + parent.LVL) + 1)

func groupCheck(nodeToCheck):
	var thingToCheck = nodeToCheck.get_parent().get_groups()[0]
	
	match thingToCheck:
		"Player":
			return true
		"Enemy":
			return true
		_:
			return false
			
	


