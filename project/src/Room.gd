extends Node2D
class_name Room2D

var num_enemies: int

onready var door_container: Node2D = get_node("Doors")

export var closed: bool = false

export var left_room: int = -1
export var right_room: int = -1
export var top_room: int = -1
export var bottom_room: int = -1

var doors

enum {LEFT = 0, RIGHT = 1, TOP = 2, BOTTOM = 3}

signal exited_room(next_room, door_used)

func _ready() -> void:
	doors = door_container.get_children()
	_enable_doors()
	if not closed:
		num_enemies = 0#enemy_positions_container.get_child_count()
		if num_enemies == 0:
			_open_doors()

func _enable_doors():
	_enable_door(LEFT, left_room)
	_enable_door(RIGHT, right_room)
	_enable_door(TOP, top_room)
	_enable_door(BOTTOM, bottom_room)

func _enable_door(i: int, room):
	if _is_valid_room(room):
		doors[i].enable(room)
		doors[i].connect("entered", self, "_on_player_exit", [i])

func _on_player_exit(next_room: int, door_used: int):
	emit_signal("exited_room", next_room, door_used)

func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies == 0:
		_open_doors()

func _open_doors() -> void:
	for door in doors:
		door.open()

func _close_doors() -> void:
	for door in doors:
		door.close()

func _is_valid_room(room: int) -> bool:
	return room > -1

func set_player_position(player: Character, assistant: Node, door_used: int):
	match door_used:
		LEFT:
			doors[RIGHT].set_player_position(player, assistant);
		RIGHT:
			doors[LEFT].set_player_position(player, assistant);
		TOP:
			doors[BOTTOM].set_player_position(player, assistant);
		BOTTOM:
			doors[TOP].set_player_position(player, assistant);
