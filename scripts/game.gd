extends Control

@onready var node_main_grid := $CenterContainer/MainGrid

const Turn = preload("res://scripts/turn.gd").Turn

var player_turn := Turn.X

var grid_focus : GridContainer = null
var subgames : Dictionary
var playable_subgames : Array[GridContainer]
var finished_subgames : Array[GridContainer]

func _ready() -> void:
	node_main_grid.initiate_board()


func _on_main_grid_sig_button_pressed(btn: Button) -> void:
	var player_text = "X"
	if player_turn == Turn.O:
		player_text = "O"
	
	btn.text = player_text
	btn.disabled = true
	
	var tic_tac_toe_subgame : TicTacToe_deprecated = btn.get_parent().get_child(0)
	var position := int(str(btn.name).split("btn")[1])
	
	tic_tac_toe_subgame.draw_move(position, player_turn)
	print(tic_tac_toe_subgame.board)
	
	if subgames[btn.name.split("btn")[1]] in playable_subgames:
		grid_focus = subgames[btn.name.split("btn")[1]]
		enable_grid(subgames[btn.name.split("btn")[1]])
	
	for sg in playable_subgames:
		if sg != grid_focus:
			disable_grid(sg)
	
	if tic_tac_toe_subgame.who_won != null:
		finished_subgames.append(playable_subgames.pop_at(playable_subgames.find(btn.get_parent())))
		for obj in btn.get_parent().get_children():
			if(obj.name.contains("btn")):
				obj.disabled = true

	player_turn = Turn.O if player_turn == Turn.X  else Turn.X

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
	subgames[grid.name.split("grid")[1]] = grid
