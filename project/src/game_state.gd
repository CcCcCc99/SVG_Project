extends Reference
class_name GameState

var hp: int setget ,get_hp
var max_hp: int setget ,get_max_hp

var mp: int setget ,get_mp
var max_mp: int setget ,get_max_mp

var slot_num: int setget ,get_slot_num
var action_bar: Array setget ,get_action_bar

var check_point: MapPosition
var events: Dictionary

func _init():
	hp = 0
	max_hp = 0
	mp = 0
	max_mp = 0
	slot_num = 0
	action_bar = []
	check_point = MapPosition.new(0,0, Vector2(0,0))
	events = {}

func get_hp():
	return hp

func get_max_hp():
	return max_hp

func get_mp():
	return mp

func get_max_mp():
	return max_mp

func get_slot_num():
	return slot_num

func get_action_bar():
	return action_bar

func set_hp(hp: int, max_hp: int):
	self.hp = hp
	self.max_hp = max_hp

func set_mp(mp: int, max_mp: int):
	self.mp = mp
	self.max_mp = max_mp

func set_actionbar(slot_num: int, action_bar: Array):
	self.slot_num = slot_num
	self.action_bar = action_bar

