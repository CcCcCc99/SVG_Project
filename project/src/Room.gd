extends Node2D
class_name Room

var num_enemies: int

onready var door_container: Node2D = get_node("Doors")
onready var enemy_positions_container: Node2D = get_node("EnemyPositions")
onready var player_detector: Area2D = get_node("PlayerDetector")

export var closed: bool = false

export var left_room: int = -1
export var right_room: int = -1
export var top_room: int = -1
export var bottom_room: int = -1

var doors

func _ready() -> void:
	doors = door_container.get_children()
	_enable_doors()
	if not closed:
		num_enemies = enemy_positions_container.get_child_count()
		if num_enemies == 0:
			_open_doors()

func _enable_doors():
	if _is_valid_room(left_room):
		doors[0].enable()
	if _is_valid_room(right_room):
		doors[1].enable()
	if _is_valid_room(top_room):
		doors[2].enable()
	if _is_valid_room(bottom_room):
		doors[3].enable()

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

func _on_PlayerDetector_body_entered(_body: KinematicBody2D) -> void:
	player_detector.queue_free()
	_close_doors()
	#_spawn_enemies()

func _is_valid_room(room: int) -> bool:
	return room > -1
