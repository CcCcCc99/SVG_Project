extends Node
class_name Event

var position: MapPosition setget set_map_pos, get_map_pos
var activated: bool = false

func set_map_pos(pos: MapPosition):
	pos.position = Vector2(0,0)
	position = pos

func get_map_pos() -> MapPosition:
	return position

func get_event_string() -> String:
	var s: String = ""
	s += str(position.level) + "-"
	s += str(position.room) + "-"
	s += "t" if activated else "f"
	return s
