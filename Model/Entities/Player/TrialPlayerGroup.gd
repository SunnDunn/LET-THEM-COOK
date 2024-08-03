extends Node3D

var enemies: Array = []
var players: Array = []
var action_queue : Array = []
var is_battling : bool = false 
var index: int = 0

var activePlayer
var playerActed : Array = []
var alreadyChose : bool = false 

#show player focus
signal next_player
@onready var choice = $"../UI/CanvasLayer/PlayerActions"

# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_children()
	enemies = $"../EnemyGroup".get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#will run inputs if the choice is not visible
	if playerActed.size() == 4:
		playerActed.resize(0)
	
	if not alreadyChose and playerActed.size() < 4:
		choice.hide()
		if Input.is_action_just_pressed("ui_up"):
			if index > 0:
				index -= 1
				switch_focus(index,index+1)
		if Input.is_action_just_pressed("ui_down"):
			if index < players.size() - 1:
				index += 1
				switch_focus(index,index-1)
		if Input.is_action_just_pressed("ui_accept"):
				
				var check = playerActed.find(index)
				if check == -1:
					activePlayer = players[index]
					playerActed.push_back(index)
					alreadyChose = true
					show_choice()
				
				

func show_choice():
	choice.show()
	choice.find_child("Attack").grab_focus()

func switch_focus(x,y):
	players[x].focus()
	players[y].unfocus()

#function to remove all indicators
func _reset_focus():
	index = 0
	for player in players:
		player.unfocus()

#function that focuses first enemy after every reset
func _start_choosing():
	_reset_focus()
	players[0].focus()

func _on_attack_pressed():
	activePlayer.get_node("Combat").attack()
	alreadyChose = false

func _on_defense_pressed():
	activePlayer.get_node("Combat").defend()
	alreadyChose = false

func _on_heal_pressed():
	activePlayer.get_node("Combat").heal()
	alreadyChose = false

