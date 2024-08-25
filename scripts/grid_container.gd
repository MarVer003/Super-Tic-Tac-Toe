extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(9):
		var grid = GridContainer.new()
		grid.custom_minimum_size = Vector2(100, 100)
		grid.columns = 3
		grid.name = "grid" + str(i)
		
		for j in range(9):
			var btn = Button.new()
			btn.custom_minimum_size = Vector2(30, 30)
			btn.name = "btn" + str(i) + str(j)
			btn.connect("pressed", _on_button_pressed.bind(btn))
			grid.add_child(btn)
		
		add_child(grid)



func _on_button_pressed(btn) -> void:
	var main_script = get_tree().current_scene.get_node("VBoxContainer/HBoxContainer")
	main_script._move_was_made()
	print("click")
	if main_script.player == 0:
		btn.text = "X"
	else:
		btn.text = "O"
