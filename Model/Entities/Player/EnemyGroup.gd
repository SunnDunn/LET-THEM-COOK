extends Node3D

var enemies: Array = []
var action_queue : Array = []
var is_battling : bool = false 
var index: int = 0

#show player focus
signal next_player
@onready var choice = $"../UI/CanvasLayer/PlayerActions"

# Called when the node enters the scene tree for the first time.
func _ready():
	enemies = get_children()
	#for i in enemies.size():
	#enemies[i].position = Vector3(i*8,0,0)
 	
	show_choice()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#will run inputs if the choice is not visible
	if not choice.visible:
		if Input.is_action_just_pressed("ui_up"):
			if index > 0:
				index -= 1
				switch_focus(index,index+1)
		if Input.is_action_just_pressed("ui_down"):
			if index < enemies.size() - 1:
				index += 1
				switch_focus(index,index-1)
		if Input.is_action_just_pressed("ui_accept"):
				action_queue.push_back(index)
				emit_signal("next_player")
	#when queue is full we call the action fucntion
	if action_queue.size() == enemies.size() and not is_battling:
		is_battling = true;
		_action(action_queue)

#we go throu each index and call take damage with 1 sec delay and clear the stack
func _action(stack):
	for i in stack:
		enemies[i].take_damage(10)
		await get_tree().create_timer(1).timeout
	action_queue.clear()
	is_battling = false
	show_choice()
	
func show_choice():
	choice.show()
	choice.find_child("Attack").grab_focus()

func switch_focus(x,y):
	enemies[x].focus()
	enemies[y].unfocus()

#function to remove all indicators
func _reset_focus():
	index = 0
	for enemy in enemies:
		enemy.unfocus()

#function that focuses first enemy after every reset
func _start_choosing():
	_reset_focus()
	enemies[0].focus()


func _on_attack_pressed():
	choice.hide()
	_start_choosing()
