class_name TicTacToe_deprecated

extends Node

const Turn = preload("res://scripts/turn.gd").Turn

var id: int
var board: Array[int]
var who_won = null

@warning_ignore("shadowed_variable")
func _init(id: int) -> void:
	self.id = id
	self.board = [-1, -1, -1, 
				  -1, -1, -1, 
				  -1, -1, -1]

func draw_move(pos: int, player: Turn) -> void:
	self.board[pos] = player
	if check_win():
		self.who_won = player
	if check_tie():
		self.who_won = -1

func check_win() -> bool:
	for i in range(0, 9, 3):
		if board[i] == board[i+1] and board[i] == board[i+2] and board[i] != -1:
			return true

	for i in range(3):
		if board[i] == board[i+3] and board[i] == board[i+6] and board[i] != -1:
			return true

	if board[0] == board[4] and board[0] == board[8] and board[0] != -1:
		return true

	if board[2] == board[4] and board[2] == board[6] and board[2] != -1:
		return true

	return false

func check_tie() -> bool:
	for i in board:
		if i == -1:
			return false

	return true
