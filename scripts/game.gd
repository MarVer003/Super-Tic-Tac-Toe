extends Control

@onready var node_main_grid := $CenterContainer/MainGrid

const BoardConstants = preload("res://scripts/enums/constants.gd").Board
const EVERY_CELL = [0, 1, 2, 3, 4, 5, 6, 7, 8]

var subgames : Array[GridContainer]
var super_tic_tac_toe : SuperTicTacToe

func _ready() -> void:
	subgames.clear()
	super_tic_tac_toe = SuperTicTacToe.new()
	node_main_grid.initiate_board()


func _on_main_grid_sig_button_pressed(btn: Button, grid : GridContainer) -> void:
	var subgame_index := int(str(grid.name))
	var cell_index := int(str(btn.name))
	var result := super_tic_tac_toe.move(subgame_index, cell_index)
	btn.text = result[0]
	
	if len(result) > 1:
		var panel := Panel.new()
		var style := StyleBoxTexture.new()
		match result[1]:
			BoardConstants.X:
				style.texture = preload("res://sprite_X.png")
			BoardConstants.O:
				style.texture = preload("res://sprite_O.png")
			_:
				style.texture = preload("res://sprite_draw.png")
		panel.z_index = -1
		panel.custom_minimum_size = Vector2(180, 180)
		panel.add_theme_stylebox_override("panel", style)
		grid.add_sibling(panel)
	
	focus_on_grid()
	
	if len(result) > 2:
		game_over()

func game_over():
	print("GAME OVER!")
	disable_all_grids()

func disable_all_grids():
	for subgame in subgames:
		disable_grid(subgame, EVERY_CELL)

func focus_on_grid():
	var disable_enable := super_tic_tac_toe.disabled_enabled_status()
	var disable := disable_enable[0]
	var enable := disable_enable[1]
	for i in range(9):
		if i in disable:
			disable_grid(subgames[i], disable[i])
		if i in enable:
			enable_grid(subgames[i], enable[i])

func disable_grid(subgame : GridContainer, cells : Array):
	for btn : Button in subgame.get_children():
		if int(str(btn.name)) in cells:
			btn.disabled = true
			

func enable_grid(subgame : GridContainer, cells : Array):
	for btn : Button in subgame.get_children():
		if int(str(btn.name)) in cells:
			btn.disabled = false


func _on_main_grid_sig_grid_added(grid: GridContainer) -> void:
	subgames.append(grid)
	
