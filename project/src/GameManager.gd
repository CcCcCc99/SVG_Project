extends Node

export(PackedScene) var player_scene
var player

onready var health_bar = get_node("Control/HBoxContainer")
var heart_full = preload("res://assets/cuore_pieno.png")
var heart_half = preload("res://assets/cuore_a_metà.png")
var heart_empty = preload("res://assets/cuore_vuoto.png")
var current_heart

var testlLevel = preload("res://levels/TestLevel.tres")

var rooms: Array
var current_room: int

# Called when the node enters the scene tree for the first time.
func _ready():
	player = player_scene.instance()
	player.connect("hp_changed", self, "_change_health_bar")
	_add_hearts()
	_load_level()

func _add_hearts() -> void:
	var i = 0
	while(i < player.hp / 2):
		var heart_i = TextureRect.new()
		health_bar.add_child(heart_i)
		heart_i.texture = heart_full
		i += 1
	current_heart = i - 1

func _change_health_bar(old_hp: int, new_hp: int) -> void:
	if new_hp > 0:
		if new_hp > old_hp:
			pass # GAIN HP
		elif new_hp < old_hp:
			_lose_hp(old_hp, new_hp)
	else:
		pass # GAME OVER

func _lose_hp(old_hp: int, new_hp: int) -> void:
	while(old_hp > new_hp):
		var heart = health_bar.get_child(current_heart)
		if (old_hp % 2) == 0:
			heart.texture = heart_half
		else:
			heart.texture = heart_empty
			current_heart -= 1
		old_hp -= 1

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
	rooms[r].connect("exited_room", self, "_switch_to_room")
	add_child(rooms[r])
	rooms[r].set_player_position(player, d)

func _unload_room():
	rooms[current_room].get_node("Objects").remove_child(player)
	rooms[current_room].disconnect("exited_room", self, "_switch_to_room")
	remove_child(rooms[current_room])

func _switch_to_room(r: int, d: int):
	call_deferred("_unload_room")
	call_deferred("_load_room", r, d)
