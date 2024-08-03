extends Node

var LVL = 1
var MAXHP = 1
var HP = MAXHP
var DMG = 1
var SPD = 1
var RANGE = 1

var defendCheck = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	LevelSystem.load_stats()
	
	if self.get_parent().get_parent().name == "PlayerGroup":
		LVL = LevelSystem.get_stats("LEVEL")
		MAXHP = LevelSystem.get_stats("HP")
		HP = MAXHP
		DMG = LevelSystem.get_stats("DMG")
		SPD = LevelSystem.get_stats("SPD")
		RANGE = LevelSystem.get_stats("RANGE")
		
	else:
		var Max = LevelSystem.get_stats("LEVEL") + 3
		var Min = LevelSystem.get_stats("LEVEL") - 3
		var enemyLevel = randi() % (Max - Min + 1) + Min
		
		LVL = enemyLevel
		MAXHP = MAXHP + (randi() % (3 + LVL)) + 1
		HP = MAXHP
		DMG = DMG + (randi() % (3 + LVL)) + 1
		SPD = LevelSystem.round_to_dec(SPD + randf(), 2)
		RANGE = LevelSystem.round_to_dec(RANGE + randf(), 2)

func takeDMG(dmg):
	HP = HP - DMG
	
	print(get_parent().name, " got their balls fried and received ", dmg, " damage!")
	
	if HP <= 0:
		HP = 0

func defend(dmg):
	defendCheck = false
	dmg = dmg * 0.8
	
	return dmg

func heal(heal):
	HP = HP + heal
	
	if HP > MAXHP:
		HP = MAXHP
