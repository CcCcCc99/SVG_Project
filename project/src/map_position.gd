extends Resource
class_name MapPosition

export var level: int
export var room: int
export var position: Vector2

func _init(l: int, r: int, pos: Vector2):
	level = l
	room = r
	position = pos
