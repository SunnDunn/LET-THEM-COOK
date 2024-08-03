extends CharacterBody3D

@onready var _focus = $Focus
@onready var progress_bar = $PlayerHealthBar

@export var stats: Node
var MAX_HEALTH : float = 100
var health : float = 100:
	set(value):
		health = value
		_update_progress_bar()

func _ready() -> void:
	MAX_HEALTH = stats.MAXHP
	health = MAX_HEALTH
	
func _process(_delta) -> void:
	health = stats.HP

func _update_progress_bar():
	progress_bar.value = (health/MAX_HEALTH) * 100
		
		
func focus():
	_focus.show()
	
func unfocus():
	_focus.hide()
