extends Node2D
class_name Room2D

var num_enemies: int

onready var door_container: Node2D = get_node("Doors")
onready var rewarder: Node2D = get_node("Objects/StandardReward")

export var closed: bool = false

export var left_room: int = -2
export var right_room: int = -2
export var top_room: int = -2
export var bottom_room: int = -2

var pos: MapPosition

var doors

enum {LEFT = 0, RIGHT = 1, TOP = 2, BOTTOM = 3}

signal exited_room(next_room, door_used)
signal completed

func _ready() -> void:
	doors = door_container.get_children()
	enable_doors()
	close_doors()

func check_and_open():
	if not closed:
		open_doors()
	else:
		num_enemies = _count_enemies()
		if num_enemies == 0:
			open_doors()

func _count_enemies() -> int:
	var objs = $Objects.get_children()
	var cont = 0
	for o in objs:
		if o.is_in_group("Mob"):
			o.connect("killed", self, "_on_enemy_killed")
			cont += 1
	return cont

func get_events() -> Dictionary:
	var events = $Events.get_children()
	var to_save: Dictionary = {}
	for e in events:
		if e.is_ever_used:
			to_save[e.get_event_string()] = e.activated
	return to_save

func load_events(events_state: Dictionary):
	var events = $Events.get_children()
	for e in events:
		var key = e.get_event_string()
		if events_state.has(key):
			e.load_event(events_state[key])

func start_events():
	var events = $Events.get_children()
	for e in events:
		if e.auto_start:
			e.start()

func enable_doors():
	_enable_door(LEFT, left_room)
	_enable_door(RIGHT, right_room)
	_enable_door(TOP, top_room)
	_enable_door(BOTTOM, bottom_room)

func _enable_door(i: int, room):
	if _is_valid_room(room):
		doors[i].enable(room)
		doors[i].connect("entered", self, "_on_player_exit", [i])

func _on_player_exit(next_room: int, door_used: int):
	if doors[door_used].is_open():
		emit_signal("exited_room", next_room, door_used)

func _on_enemy_killed() -> void:
	num_enemies -= 1
	if num_enemies == 0:
		open_doors()
		get_node("/root/AudioManager").add_effect("res://assets/audio/42972454_door-opening-05.mp3", 0.0, 1.0, false)
		emit_signal("completed")

func open_doors() -> void:
	for door in doors:
		door.open()

func close_doors() -> void:
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

func _on_TimeToCheck_timeout():
	check_and_open()
