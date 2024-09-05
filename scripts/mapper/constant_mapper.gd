class_name ConstantMapper extends Object

const Board = preload("res://scripts/enums/constants.gd").Board

static func constant_to_string(c : Board) -> String:
	match c:
		Board.N:
			return 'N'
		Board.X:
			return 'X'
		Board.O:
			return 'O'
		Board.T:
			return 'T'
		_:
			return ''
