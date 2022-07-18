extends Node

export(PackedScene) var player_scene
export(PackedScene) var assistant_scene
var player
var assistant

var is_in_pause: bool = false

onready var health_bar = get_node("HUD/HealthBar")
onready var mana_bar = get_node("HUD/ManaBar")

#var testlLevel #= preload("res://levels/TestLevel.tres")
var levels: Array
var currentLevel
var boss_room

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

func _input(event):
	var parent = get_parent()
	if not is_in_pause:
		if Input.is_action_just_pressed("ui_accept"):
			_hide_main(parent)
	else:
		if parent.get_child_count() == 3:
			_show_main()

func _hide_main(parent):
	is_in_pause = not is_in_pause
	
	parent.add_child(load("res://scenes/menu/PauseScreen.tscn").instance())
	
	rooms[current_room].get_node("Objects").remove_child(player)
	rooms[current_room].get_node("Objects").remove_child(assistant)
	remove_child(rooms[current_room])
	
	health_bar.visible = false
	mana_bar.visible = false
	$HUD/ActionBar.visible = false
	
	$Camera2D.anchor_mode = 0

func _show_main():
	is_in_pause = not is_in_pause
	
	rooms[current_room].get_node("Objects").add_child(player)
	rooms[current_room].get_node("Objects").add_child(assistant)
	add_child(rooms[current_room])
	
	health_bar.visible = true
	mana_bar.visible = true
	$HUD/ActionBar.visible = true
	
	$Camera2D.anchor_mode = 1

func _load_level(l: int):
	currentLevel = load(levels[l])
	var room_scenes = currentLevel.get_rooms()
	for rs in room_scenes:
		rooms.append(rs.instance())
	var start = currentLevel.get_first_room()
	boss_room = currentLevel.get_boss_room()
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
		assistant.set_mana(assistant.max_mana)
		player.position = player.checkpoint_position
	else:
		rooms[r].set_player_position(player, assistant, d)
	if r == boss_room:
		$Camera2D.current = false
		rooms[r].get_node("Camera2D").current = true
	else:
		$Camera2D.current = true

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

