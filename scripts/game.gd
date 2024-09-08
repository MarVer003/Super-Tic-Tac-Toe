extends Control

@onready var node_main_grid := $CenterContainer/MainGrid

var grid_focus : GridContainer = null
var subgames : Array[GridContainer]
var playable_subgames : Array[GridContainer]
var finished_subgames : Array[GridContainer]
var super_tic_tac_toe : SuperTicTacToe

func _ready() -> void:
	node_main_grid.initiate_board()
	super_tic_tac_toe = SuperTicTacToe.new()


func _on_main_grid_sig_button_pressed(btn: Button, grid : GridContainer) -> void:
	var subgame_index := int(str(grid.name))
	var cell_index := int(str(btn.name))
	btn.text = super_tic_tac_toe.move(subgame_index, cell_index)
	
	focus_on_grid()
	

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
	playable_subgames.append(grid)
	subgames.append(grid)
