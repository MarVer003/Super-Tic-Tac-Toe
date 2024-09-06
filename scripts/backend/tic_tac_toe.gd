class_name TicTacToe extends Object

# Imports
const BoardConstants = preload("res://scripts/enums/constants.gd").Board

static var board_num := 0

var id: int
var board_state: Array[int]
var who_won = null
var is_active : bool

func _init() -> void:
	self.id = board_num
	for i in range(9):
		self.board_state.append(BoardConstants.N)
	board_num += 1

func move(cell: int, player: int) -> Variant:
	self.board_state[cell] = player
	
	if __check_win():
		self.who_won = player
		self.is_active = false
	if __check_tie():
		self.who_won = BoardConstants.N
		self.is_active = false	
	
	return self.who_won

func __check_win() -> bool:
	var board = self.board_state
	for i in range(0, 9, 3):
		if board[i] == board[i+1] and board[i] == board[i+2] and board[i] != BoardConstants.N:
			return true

	for i in range(3):
		if board[i] == board[i+3] and board[i] == board[i+6] and board[i] != BoardConstants.N:
			return true

	if board[0] == board[4] and board[0] == board[8] and board[0] != BoardConstants.N:
		return true

	if board[2] == board[4] and board[2] == board[6] and board[2] != BoardConstants.N:
		return true

	return false

func __check_tie() -> bool:
	var board = self.board_state
	for i in board:
		if i == BoardConstants.N:
			return false

	return true
