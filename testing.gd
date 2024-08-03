extends Node

func getEnemyGroupNode():
	var playerChara = $PlayerGroup/Player01/Combat
	
	#playerChara.attack()
	
	print(playerChara.name + " from getenemy func")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	getEnemyGroupNode()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
