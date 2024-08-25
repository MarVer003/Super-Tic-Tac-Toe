extends Button



func _on_pressed() -> void:
	var main_script = get_tree().current_scene.get_node("VBoxContainer/HBoxContainer")
	main_script._move_was_made()
	if main_script.player == 0:
		text = "X"
	else:
		text = "O"
