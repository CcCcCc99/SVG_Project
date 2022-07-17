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
var boss_room

export var loadlvl = 0

var rooms: Array
var current_room: int

func _init():
	levels.append("res://levels/LvTestRoomSkip.tres")
	levels.append("res://levels/LvTutorial.tres")
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
	
class loading_room:
	var r
	var d
	func _init(r, d):
		self.r = r
		self.d = d
var queueload: Array

func _process(delta):
	if not queueload.empty():
		var to_load = queueload.pop_front()
		_switch_to_room(to_load.r, to_load.d)
		queueload.clear()

func _load_level(l: int):
	currentLevel = load(levels[l])
	var room_scenes = currentLevel.get_rooms()
	for rs in room_scenes:
		rooms.append(rs.instance())
	var start = currentLevel.get_first_room()
	boss_room = currentLevel.get_boss_room()
	_load_room(start, null)
	#rooms[start].check_and_open()

func _unload_level():
	_unload_room()
	rooms.clear()
	#currentLevel.queue_free()
	pass

func _switch_to_level(l: int):
	#call_deferred("_unload_room")
	call_deferred("_unload_level")
	call_deferred("_load_level", l)

func _queue_load(r: int, d):
	queueload.push_back(loading_room.new(r,d))

func _load_room(r: int, d):
	current_room = r
	rooms[r].get_node("Objects").add_child(player)
	rooms[r].get_node("Objects").add_child(assistant)
	#rooms[r].position = Vector2(2000 * r, 0)
	#$Camera2D.position = Vector2(2000 * r, 0)
	rooms[r].connect("exited_room", self, "_queue_load")
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
	rooms[r].get_node("TimeToCheck").start()
	#rooms[r].close_doors()

func _unload_room():
	player.destroy_portals()
	assistant.destroy_summons()
	rooms[current_room].close_doors()
	rooms[current_room].get_node("Objects").remove_child(player)
	rooms[current_room].get_node("Objects").remove_child(assistant)
	rooms[current_room].disconnect("exited_room", self, "_switch_to_room")
	remove_child(rooms[current_room])

func _switch_to_room(r: int, d):
	player.destroy_portals()
	assistant.destroy_summons()
	call_deferred("_unload_room")
	#_unload_room()
	call_deferred("_load_room", r, d)
	#rooms[r].check_and_open()
	#_load_room(r,d)

var respawn_room
func _respawn(room):
	$HUD/ColorRect.show()
	$AnimationPlayer.play("Fadeout")
	respawn_room = room
	player = player_scene.instance()
	player.connect("is_dead", self, "_respawn")
	health_bar.set_player(player)
	
func _on_AnimationPlayer_animation_finished(anim_name):
	$AnimationPlayer.stop()
	if anim_name == "Fadeout":
		_unload_level()
		_load_level(loadlvl)
		_switch_to_room(respawn_room, null)
		#rooms[respawn_room].check_and_open()
		$AnimationPlayer.play("Fadein")
	else:
		$HUD/ColorRect.hide()

func load_summon(sum, cost):
	assistant.add_summon(sum, cost)

 
func get_cost() -> int:
	return assistant.get_current_cost()
