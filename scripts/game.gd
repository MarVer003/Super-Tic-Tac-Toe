extends Control

@onready var node_main_grid := $CenterContainer/MainGrid

const Turn = preload("res://scripts/turn.gd").Turn

var player_turn := Turn.X

var grid_focus : GridContainer = null
var subgames : Array[GridContainer]
var playable_subgames : Array[GridContainer]
var finished_subgames : Array[GridContainer]
var super_tic_tac_toe : SuperTicTacToe

func _ready() -> void:
	node_main_grid.initiate_board()
	super_tic_tac_toe = SuperTicTacToe.new()


func _on_main_grid_sig_button_pressed(btn: Button, grid : GridContainer) -> void:
	var subgame_index := int(grid.name)
	var cell_index := int(btn.name)
	btn.text = super_tic_tac_toe.move(subgame_index, cell_index)

	if subgames[cell_index] in playable_subgames:
		grid_focus = subgames[cell_index]
		enable_grid(subgames[cell_index])
	
	for subgame in playable_subgames:
		if subgame != grid_focus:
			disable_grid(subgame)
	
	enable_grid(subgames[super_tic_tac_toe.focused_subboard.id])
	
	# Make the game playable


func disable_grid(subgame : GridContainer):
	for obj in subgame.get_children():
		if(obj.name.contains("btn")):
			obj.disabled = true
			
func enable_grid(subgame : GridContainer):
	for obj in subgame.get_children():
		if(obj.name.contains("btn") and str(obj.text) == ""):
			obj.disabled = false


func _on_main_grid_sig_grid_added(grid: GridContainer) -> void:
	playable_subgames.append(grid)
	subgames.append(grid)
