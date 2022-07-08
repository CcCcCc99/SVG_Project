extends Node

export(PackedScene) var player_scene
export(PackedScene) var assistant_scene
var player
var assistant

onready var health_bar = get_node("HUD/HealthBar")
onready var mana_bar = get_node("HUD/ManaBar")

#var testlLevel #= preload("res://levels/TestLevel.tres")
var levels: Array
var currentLevel

export var loadlvl = 0

var rooms: Array
var current_room: int

func _init():
	levels.append("res://levels/TestLevel.tres")
	levels.append("res://levels/TestLevel2.tres")

func _ready():
	$Camera2D.set_process_input(false)
	player = player_scene.instance()
	player.connect("is_dead", self, "_respawn")
	assistant = assistant_scene.instance()
	assistant.action_bar = $HUD/ActionBar
	health_bar.set_player(player)
	mana_bar.set_player(assistant)
	call_deferred("_load_level",loadlvl)

func _load_level(l: int):
	currentLevel = load(levels[l])
	var room_scenes = currentLevel.get_rooms()
	for rs in room_scenes:
		rooms.append(rs.instance())
	var start = currentLevel.get_first_room()
	_load_room(start, null)

func _unload_level():
	_unload_room()
	rooms.clear()
	#currentLevel.queue_free()
	pass

func _switch_to_level(l: int):
	#call_deferred("_unload_room")
	call_deferred("_unload_level")
	call_deferred("_load_level", l)

func _load_room(r: int, d):
	current_room = r
	rooms[r].get_node("Objects").add_child(player)
	rooms[r].get_node("Objects").add_child(assistant)
	rooms[r].connect("exited_room", self, "_switch_to_room")
	add_child(rooms[r])
	if d == null:
		player.set_hp(player.max_hp)
		player.position = player.checkpoint_position
	else:
		rooms[r].set_player_position(player, assistant, d)

func _unload_room():
	player.destroy_portals()
	assistant.destroy_summons()
	rooms[current_room].get_node("Objects").remove_child(player)
	rooms[current_room].get_node("Objects").remove_child(assistant)
	rooms[current_room].disconnect("exited_room", self, "_switch_to_room")
	remove_child(rooms[current_room])


func _switch_to_room(r: int, d):
	player.destroy_portals()
	assistant.destroy_summons()
	call_deferred("_unload_room")
	call_deferred("_load_room", r, d)

func _respawn(room):
	_unload_level()
	_load_level(loadlvl)
	_switch_to_room(room, null)

func load_summon(sum, cost):
	assistant.add_summon(sum, cost)

 
func get_cost() -> int:
	return assistant.get_current_cost()

