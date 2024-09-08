class_name SuperTicTacToe extends Object

# Imports
const BoardConstants = preload("res://scripts/enums/constants.gd").Board
const ConstantMapper = preload("res://scripts/mapper/constant_mapper.gd")

static var board_num := 0

var id: int
var focused_subboard: TicTacToe
var can_play_anywhere: bool
var subboards: Array[TicTacToe]
var board_state: Array[int]
var player_turn : BoardConstants

func _init() -> void:
	self.player_turn = BoardConstants.X
	self.id = board_num
	self.focused_subboard = null
	self.can_play_anywhere = true
	for i in range(9):
		self.board_state.append(BoardConstants.N)
	for i in range(9):
		self.subboards.append(TicTacToe.new())
	board_num += 1

func move(subboard: int, cell: int) -> String:
	var player_string := ConstantMapper.constant_to_string(player_turn)
	var result = subboards[subboard].move(cell, self.player_turn)
	if result != null:
		self.board_state[subboard] = result
	__what_to_focus(cell)
	
	if __check_super_win():
		print("A WIN FOR ", ConstantMapper.constant_to_string(player_turn), "!!!")
	elif __check_super_tie():
		print("IT'S A TIE!!!")
		
	player_turn = BoardConstants.X if player_turn == BoardConstants.O else BoardConstants.O
	return player_string

## Disabled/Unfocused grids and cells - 0th index
## Enabled/focused grids and cells - 1st index
func disabled_enabled_status() -> Array[Dictionary]:
	var disabled : Dictionary
	var enabled : Dictionary
	if can_play_anywhere:
		for i in range(9):
			disabled[i] = subboards[i].disabled_status()
			enabled[i] = subboards[i].enabled_status()
	else:
		for i in range(9):
			if subboards[i] != focused_subboard:
				disabled[i] = range(9)
			else:
				disabled[i] = subboards[i].disabled_status()
				enabled[i] = subboards[i].enabled_status()
	
	return [disabled, enabled]
	
func __what_to_focus(cell : int) -> void:
	can_play_anywhere = not subboards[cell].is_active
	focused_subboard = subboards[cell]
	
func __check_super_win() -> bool:
	var board = self.board_state
	for i in range(0, 9, 3):
		if board[i] == board[i+1] and \
		board[i] == board[i+2] and    \
		board[i] not in [BoardConstants.N, BoardConstants.T]: 
			return true

	for i in range(3):
		if board[i] == board[i+3] and \
		board[i] == board[i+6] and    \
		board[i] not in [BoardConstants.N, BoardConstants.T]:
			return true

	if board[0] == board[4] and \
	board[0] == board[8] and    \
	board[0] not in [BoardConstants.N, BoardConstants.T]:
		return true

	if board[2] == board[4] and \
	board[2] == board[6] and    \
	 board[2] not in [BoardConstants.N, BoardConstants.T]:
		return true

	return false

func __check_super_tie() -> bool:
	var board = self.board_state
	for i in board:
		if i == BoardConstants.N:
			return false

	return true


# TODO: should there be active and inactive subboards array separate or just check board array for the actives one? 
# TODO-answer: We will see.
