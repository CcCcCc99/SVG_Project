extends Node

export(PackedScene) var player_scene
export(PackedScene) var assistant_scene
var player
var assistant

var is_in_pause: bool = false
var pause_screen: Node

onready var health_bar = get_node("HUD/HealthBar")
onready var mana_bar = get_node("HUD/ManaBar")

var levels: Array
var currentLevel
var boss_room

export var loadlvl = 0

var rooms: Array
var current_room: int

var saved_state: GameState = GameState.new()

func _init():
	levels.append("res://levels/LvTutorial.tres")
	levels.append("res://levels/Lv1SciFi.tres")

func _ready():
	player = player_scene.instance()
	player.connect("is_dead", self, "_respawn")
	assistant = assistant_scene.instance()
	assistant.action_bar = $HUD/ActionBar
	health_bar.set_player(player)
	mana_bar.set_player(assistant)

	if get_node("/root/DefaultLoad").load_mode:
		load_savings()
	else:
		player.set_hp(player.max_hp)
		assistant.set_mana(assistant.max_mana)
	$Camera2D.set_process_input(false)
	call_deferred("_load_level",loadlvl)

func _input(event):
	if Input.is_action_just_pressed("pause_toggle"):
		if not is_in_pause:
			is_in_pause = true
			get_tree().paused = true
			pause_screen = load("res://scenes/menu/PauseScreen.tscn").instance()
			get_node("/root/AudioManager").add_music("res://assets/audio/fato_shadow_-_in_my_dreams.ogg", -5.0, 1.0)
			$HUD.add_child(pause_screen)
		else:
			resume()
			get_node("/root/AudioManager").resume_music()
	
	if Input.is_action_just_pressed("debug1"):
		_unload_level()
		_load_level(1)

func resume():
	is_in_pause = false
	get_tree().paused = false
	pause_screen.queue_free()

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
	_set_music(l)

	var room_scenes = currentLevel.get_rooms()
	for rs in room_scenes:
		rooms.append(rs.instance())
	for i in rooms.size():
		rooms[i].pos = MapPosition.new(l, i, Vector2(0,0))

	var start = currentLevel.get_first_room()
	boss_room = currentLevel.get_boss_room()
	if get_node("/root/DefaultLoad").load_mode:
		_load_room(player.checkpoint_room, null)
	else:
		_load_room(start, null)

func _set_music(l: int):
	if l == 0:
		get_node("/root/AudioManager").change_music("res://assets/audio/Destroyed Sanctuary.mp3", -10.0, 1.0)
	elif l == 1:
		get_node("/root/AudioManager").change_music("res://assets/audio/echelon.mp3", -10.0, 1.0)

func _unload_level():
	_unload_room()
	rooms.clear()

func _switch_to_level(l: int):
	call_deferred("_unload_level")
	call_deferred("_load_level", l)

func _load_room(r: int, d):
	current_room = r
	add_child(rooms[r])
	if d == null:
		player.position = player.checkpoint_position
	else:
		rooms[r].set_player_position(player, assistant, d)
	if r == boss_room:
		$Camera2D.current = false
		get_node("/root/AudioManager").change_music("res://assets/audio/hold the line.ogg", -5.0, 1.0)
		rooms[r].get_node("Camera2D").current = true
	else:
		$Camera2D.current = true
	
	rooms[r].load_events(saved_state.events)
	rooms[r].get_node("TimeToCheck").start()
	rooms[r].get_node("Objects").add_child(player)
	rooms[r].get_node("Objects").add_child(assistant)
	rooms[r].connect("exited_room", self, "_going_trough_door")

func _unload_room():
	player.destroy_portals()
	assistant.destroy_summons()
	rooms[current_room].close_doors()
	if rooms[current_room].get_node("Objects").has_node(player.name):
		rooms[current_room].get_node("Objects").remove_child(player)
	rooms[current_room].get_node("Objects").remove_child(assistant)
	rooms[current_room].disconnect("exited_room", self, "_going_trough_door")
	remove_child(rooms[current_room])
	var room_events: Dictionary = rooms[current_room].get_events()
	for e in room_events:
		saved_state.events[e] = room_events[e]
	print(saved_state.events)

func _switch_to_room(r: int, d):
	player.destroy_portals()
	assistant.destroy_summons()
	call_deferred("_unload_room")
	call_deferred("_load_room", r, d)

var destination_room
var door_used

func _going_trough_door(room, door):
	$HUD/ColorRect.show()
	$AnimationPlayer.play("fast_Fadeout")
	destination_room = room
	door_used = door

func _respawn(room):
	assistant.set_mana(assistant.max_mana)
	$HUD/ColorRect.show()
	$AnimationPlayer.play("Fadeout")
	destination_room = room
	var cp = player.checkpoint_position
	player = player_scene.instance()
	player.connect("is_dead", self, "_respawn")
	health_bar.set_player(player)
	player.set_hp(player.max_hp)
	player.checkpoint_position = cp
	
func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.stop()
	match anim_name:
		"Fadeout":
			_unload_level()
			_load_level(loadlvl)
			_switch_to_room(destination_room, null)
			$AnimationPlayer.play("Fadein")
		"fast_Fadeout":
			_switch_to_room(destination_room, door_used)
			$AnimationPlayer.play("fast_Fadein")
		_:
			$HUD/ColorRect.hide()

func load_summon(sum, cost):
	assistant.add_summon(sum, cost)

func get_cost() -> int:
	return assistant.get_current_cost()

func save():
	saved_state.set_hp(player.hp, player.max_hp)
	saved_state.set_mp(assistant.mana, assistant.max_mana)
	saved_state.set_actionbar(assistant.slot_number, assistant.summons)
	saved_state.check_point = MapPosition.new(currentLevel.lvl_num, player.checkpoint_room, player.checkpoint_position)
	get_node("/root/DefaultLoad").save_game_state(saved_state)

func load_savings():
	saved_state = get_node("/root/DefaultLoad").load_game_state()
	loadlvl = saved_state.check_point.level
	player.checkpoint_room = saved_state.check_point.room
	player.checkpoint_position = saved_state.check_point.position
	player.set_max_hp(saved_state.max_hp) 
	player.set_hp(saved_state.hp)
	assistant.set_max_mana(saved_state.max_mp)
	assistant.set_mana(saved_state.mp)
	assistant.slot_number = saved_state.slot_num
	assistant.set_summons(saved_state.get_action_bar()) 
	assistant.update_grafics()
