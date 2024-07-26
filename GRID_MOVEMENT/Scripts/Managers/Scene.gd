extends Node

@onready var marker = $Movement/Marker/Marker
@onready var activeCharacter = $Movement/Characters/Character
#@onready var characters = get_tree().get_nodes_in_group("Players")

# Attributes
var material_selected
	#positions
var markerPos_initial = Vector3(1, 3, 1)
var target_position
	#relevant character attributes
var charAgility 
	#labels and text
@onready var distanceLabel = $Movement/MovementUI/Panel/HBoxContainer/VBoxContainer/Distance
@onready var errorLabel = $Movement/MovementUI/Panel/HBoxContainer/VBoxContainer/ErrorHandling

# MARKER AND CHARACTERS
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
		get_tree().call_group("Players", "update_target_location", target_position)
		reset_marker()
	else:
		reset_marker()

func _ready():
	charAgility = activeCharacter.get_agility()

func _physics_process(delta):
	# UPDATE DISTANCE LABEL
	distanceLabel.text = str(round_to_dec(distance_check(), 2))
	errorLabel_text()

	# DISABLING NAV AGENT
	if(activeCharacter.nav.is_navigation_finished()):
		activeCharacter.disable_nav_agent()

