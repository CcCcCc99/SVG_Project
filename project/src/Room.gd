extends Node2D
class_name Room

var num_enemies: int

onready var door_container: Node2D = get_node("Doors")
onready var enemy_positions_container: Node2D = get_node("EnemyPositions")
onready var player_detector: Area2D = get_node("PlayerDetector")

export var closed: bool = false

export var left_door_enabled: bool = false
export var left_room: PackedScene
export var right_door_enabled: bool = false
export var right_door: PackedScene
export var top_door_enabled: bool = false
export var top_door: PackedScene
export var bottom_door_enabled: bool = false
export var bottom_door: PackedScene

var doors

func _ready() -> void:
	doors = door_container.get_children()
	_enable_doors()
	if not closed:
		num_enemies = enemy_positions_container.get_child_count()
		if num_enemies == 0:
			_open_doors()

func _enable_doors():
	if left_door_enabled:
		doors[0].enable()
	if right_door_enabled:
		doors[1].enable()
	if top_door_enabled:
		doors[2].enable()
	if bottom_door_enabled:
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

func enable_left():
	doors[0].enable()
	left_door_enabled = true

func enable_right():
	doors[1].enable()
	right_door_enabled = true

func enable_top():
	doors[2].enable()
	top_door_enabled = true

func enable_bottom():
	doors[3].enable()
	bottom_door_enabled = true
