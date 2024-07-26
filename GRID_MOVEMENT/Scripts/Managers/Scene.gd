extends Node

@onready var marker = $Movement/Marker/Marker
@onready var activeCharacter = $Movement/Characters/Character

# Attributes
var markerPos_initial = Vector3(1, 3, 1)
	#positions
var target_position
	#replace this with in-character code later
var charAgility 
	#labels and text
@onready var distanceLabel = $Movement/MovementUI/Panel/HBoxContainer/VBoxContainer/Distance
@onready var errorLabel =$Movement/MovementUI/Panel/HBoxContainer/VBoxContainer/ErrorHandling

# MRKER AND CHARACTERS
func reset_marker():
	marker.position = markerPos_initial
func set_target_position(marker_position):
	target_position = marker_position
# DISTANCE CHECKING
func distance_check() -> float: # Called constantly; checks if distance is reachable
	return marker.position.distance_to(activeCharacter.position)/2
func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
# TEXT UPDATE
func errorLabel_text():
	if(distance_check() > 5):
		errorLabel.text = "Too Far!"
	elif(distance_check() <= 5):
		errorLabel.text = "OK to Land!"

# CONFIRMING DISTANCE
func _on_confirm_distance_pressed():
	if(distance_check() <= charAgility):
		set_target_position(marker.position)
		reset_marker()
		activeCharacter.position = target_position
	else:
		reset_marker()
		#get_tree().call_group("Players", "update_target_location", target_position)

func _ready():
	charAgility = activeCharacter.get_agility()

func _process(delta):
	pass

func _physics_process(delta):
	# Update Distance Label
	distanceLabel.text = str(round_to_dec(distance_check(), 2))
	errorLabel_text()
	
	# TENTATIVE: CODE'S JUST HERE UNTIL I FIGURE OUT HOW TO DISABLE NAV AGENT
	#if(_on_confirm_distance_pressed()):
		#get_tree().call_group("Players", "update_target_location", target_position)
		#activeCharacter.position = target_position
		#reset_marker()

	#if(activeCharacter.nav.is_navigation_finished()):
		#activeCharacter.disable_nav_agent()

