extends Node

var LEVEL = 1
var EXP
var EXP_THRESHOLD = get_exp_threshold(LEVEL + 1)

var MAXHP
var DMG
var SPD
var RANGE

func level_up():
	LEVEL += 1
	
	MAXHP = MAXHP + (randi() % 3) + 1
	DMG = DMG + (randi() % 3) + 1
	SPD = round_to_dec(SPD + randf(), 2)
	RANGE = round_to_dec(RANGE + randf(), 2)
	
	EXP_THRESHOLD = get_exp_threshold(LEVEL + 1)

func gain_exp(exp_gained):
	
	EXP = EXP + exp_gained
	
	while EXP >= EXP_THRESHOLD:
		EXP = EXP - EXP_THRESHOLD
		level_up()
	return EXP

func get_exp_threshold(level):
	return round(pow(level, 1.8) + (level * 4))


func increment_stat(stat, valueAdded):
	match stat:
		'HP':
			MAXHP = MAXHP + valueAdded
		'DMG':
			DMG = DMG + valueAdded
		'SPD':
			SPD = SPD + valueAdded
		'RANGE':
			RANGE = RANGE + valueAdded
		_:
			print("stat not found")

func load_stats():
	load_stat("HP")
	load_stat("DMG")
	load_stat("SPD")
	load_stat("RANGE")
	load_stat("LEVEL")
	load_stat("EXP")

func load_stat(choice):
	
	var startPos: int = 0
	var endPos: int = 0
	var previPos: int = 0
	var info: int = 0
	
	var file = FileAccess.open("res://Player/PlayerStats.txt",FileAccess.READ)
	var content = file.get_line()
	
	match choice:
		'HP':
			endPos = content.find(",")
			startPos = 0
			info = int(float(content.substr(startPos, endPos)))
			MAXHP = info
			
		'DMG':
			startPos = content.find(",")
			
			for n in 1:
				previPos = startPos
				startPos = content.find(",", startPos + 1)
			
			endPos = startPos
			startPos = previPos
			
			info = int(float(content.substr(startPos + 1, endPos)))
			DMG = info
			
		'SPD':
			startPos = content.find(",")
			
			for n in 2:
				previPos = startPos
				startPos = content.find(",", startPos + 1)
			
			endPos = startPos
			startPos = previPos
			
			info = int(float(content.substr(startPos + 1, endPos)))
			SPD = info
			
		'RANGE':
			startPos = content.find(",")
			
			for n in 3:
				previPos = startPos
				startPos = content.find(",", startPos + 1)
			
			endPos = startPos
			startPos = previPos
			
			info = int(float(content.substr(startPos + 1, endPos)))
			RANGE = info
			
		'LEVEL':
			startPos = content.find(",")
			
			for n in 4:
				previPos = startPos
				startPos = content.find(",", startPos + 1)
			
			endPos = startPos
			startPos = previPos
			
			info = int(float(content.substr(startPos + 1, endPos)))
			LEVEL = info
			
		'EXP':
			startPos = content.find(",")
			
			for n in 5:
				previPos = startPos
				startPos = content.find(",", startPos + 1)
			
			endPos = startPos
			startPos = previPos
			
			info = int(float(content.substr(startPos + 1, endPos)))
			EXP = info
			
		_:
			print("Stat not found")

func update_stats():
	var format_str = "%d,%d,%d,%d,%d,%d"
	var stat_str = format_str % [MAXHP, DMG, SPD, RANGE, LEVEL, EXP]
	
	var file = FileAccess.open("res://Player/PlayerStats.txt",FileAccess.WRITE)
	file.store_string(stat_str)
	
	return stat_str

func get_stats(choice):
	
	var stat
	
	match choice:
		'HP':
			stat = MAXHP
		'DMG':
			stat = DMG
		'SPD':
			stat = SPD
		'RANGE':
			stat = RANGE
		'LEVEL':
			stat = LEVEL
		'EXP':
			stat = EXP
		_:
			print("Stat not found")
	
	return stat

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)
