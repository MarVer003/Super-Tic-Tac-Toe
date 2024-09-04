class_name SuperTicTacToe extends Object

# Imports
const BoardConstants = preload("res://scripts/enums/constants.gd").Board

static var board_num := 0

var id: int
var focused_subboard: TicTacToe
var can_play_anywhere : bool
var subboards: Array[TicTacToe]
var board_state: Array[int]

func _init() -> void:
	self.id = board_num
	self.focused_subboard = null
	self.can_play_anywhere = true
	for i in range(9):
		self.board.append(BoardConstants.N)
	for i in range(9):
		self.board.append(TicTacToe.new())
	board_num += 1

func move(subboard: int, cell: int, player: int) -> void:
	var result = subboards[subboard].move(cell, player)
	if result != null:
		self.board_state[subboard] = result
	
	__what_to_focus(cell)
	
func __what_to_focus(cell : int) -> void:
	can_play_anywhere = not subboards[cell].active
	focused_subboard = subboards[cell]
	
func __check_super_win() -> bool:
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

func __check_super_tie() -> bool:
	var board = self.board_state
	for i in board:
		if i == BoardConstants.N:
			return false

	return true


# TODO: should there be active and inactive subboards array separate or just check board array for the actives one? WE WILL SEE.
# TODO: maybe another board_array that acts the same as TicTacToe array of integers so that it can be checked for 3 in a row? YES.
# TODO: super win and tie functions are copy-pasted from TicTacToe rn. Fix them.
