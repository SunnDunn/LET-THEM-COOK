extends Node3D

var players: Array = []
var index : int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	players = $"../PlayerGroup".get_children()
	
func switch_focus(x,y):
	players[x].focus()
	players[y].unfocus()

