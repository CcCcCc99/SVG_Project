extends Node

export(PackedScene) var player_scene
export(PackedScene) var assistant_scene
var player
var assistant

onready var health_bar = get_node("HUD/HealthBar")
onready var mana_bar = get_node("HUD/ManaBar")

var testlLevel = preload("res://levels/TestLevel.tres")

var rooms: Array
var current_room: int

func _ready():
	$Camera2D.set_process_input(false)
	player = player_scene.instance()
	assistant = assistant_scene.instance()
	assistant.action_bar = $HUD/ActionBar
	health_bar.set_player(player)
	mana_bar.set_player(assistant)
	_load_level()

func _load_level():
	var room_scenes = testlLevel.get_rooms()
	for rs in room_scenes:
		rooms.append(rs.instance())
	var start = testlLevel.get_first_room()
	_load_room(start, 0)

func _load_room(r: int, d: int):
	current_room = r
	player.position = Vector2(0,0)
	rooms[r].get_node("Objects").add_child(player)
	rooms[r].get_node("Objects").add_child(assistant)
	rooms[r].connect("exited_room", self, "_switch_to_room")
	add_child(rooms[r])
	rooms[r].set_player_position(player, assistant, d)

func _unload_room():
	rooms[current_room].get_node("Objects").remove_child(player)
	rooms[current_room].get_node("Objects").remove_child(assistant)
	rooms[current_room].disconnect("exited_room", self, "_switch_to_room")
	remove_child(rooms[current_room])

func _switch_to_room(r: int, d: int):
	call_deferred("_unload_room")
	call_deferred("_load_room", r, d)

func load_summon(sum, cost):
	var summon = load(sum).instance()
	assistant.add_summon(summon, cost)

func get_cost() -> int:
	return assistant.get_current_cost()

