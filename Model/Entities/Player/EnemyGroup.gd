extends Node3D

var players: Array = []
var index : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	players = $"../PlayerGroup".get_children()
	players[0].focus()
	#for i in enemies.size():
	#enemies[i].position = Vector3(i*8,0,0)
 	

func _on_enemy_group_next_player():
	#with every signal player focus will just go down
	if index < players.size() - 1:
		index += 1
		switch_focus(index,index - 1)
	else:
		index = 0
		switch_focus(index, players.size() - 1)
	

func switch_focus(x,y):
	players[x].focus()
	players[y].unfocus()
