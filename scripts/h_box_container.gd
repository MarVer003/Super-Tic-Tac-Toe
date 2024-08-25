extends HBoxContainer

var player = 0

func _move_was_made():
	if player == 0:
		player = 1
	else:
		player = 0
