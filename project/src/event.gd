extends Node
class_name Event

var position: MapPosition setget , get_map_pos
var is_ever_used: bool = false
export var activated: bool = false

func _ready():
	position = get_parent().get_parent().pos

func get_map_pos() -> MapPosition:
	return position

func get_event_string() -> String:
	var s: String = ""
	s += str(position.level) + "-"
	s += str(position.room) + "-"
	s += name
	return s
