extends GridContainer

signal sig_button_pressed(button : Button, grid : GridContainer)
signal sig_grid_added(grid : GridContainer)

var width := 190
var height := width


func initiate_board() -> void:
	# For grids inside the main grid #
	for i in range(9):
		var grid = GridContainer.new()
		grid.custom_minimum_size = Vector2(width, height)
		grid.columns = 3
		grid.name = str(i)
		
		# For buttons (cells) inside every smaller grid #
		for j in range(9):
			var btn = Button.new()
			btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
			btn.name = str(j)
			btn.add_theme_stylebox_override("focus", StyleBox.new())
			btn.connect("pressed", _on_button_pressed.bind(btn, grid))
			grid.add_child(btn)
		
		add_child(grid)
		sig_grid_added.emit(grid)
		


func _on_button_pressed(btn: Button, grid : GridContainer) -> void:
	sig_button_pressed.emit(btn, grid)
	
