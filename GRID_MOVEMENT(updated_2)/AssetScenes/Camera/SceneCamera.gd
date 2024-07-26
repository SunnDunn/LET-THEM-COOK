extends Camera3D

var mouse = Vector2()

func _input(event):
	if(event is InputEventMouse):
		mouse = event.position
	if (event is InputEventMouseButton and event.pressed):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			get_selection()
