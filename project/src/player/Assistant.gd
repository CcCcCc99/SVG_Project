extends Node2D

var summons: Array = [null, null, null, null, null, null]
var summoned_mobs: Array
export var summons_number: int = 1

export(int) var max_mana: int
var mana: int = 0 setget set_mana, get_mana

signal mana_changed(old_mana, new_mana)

var slot_number: int setget set_slot_number, get_slot_number
var action_bar setget set_actionbar

# Called every frame. 'delta' is the elapsed time since the previous frame.
var dialogue = preload("res://dialogues/Test.tres")
func _process(delta):
	if Input.is_action_just_released("debug1"):
		DialogueManager.show_example_dialogue_balloon("Room2Test", dialogue)
	#var active: summon = 
	if Input.is_action_just_pressed("summon") and is_instance_valid(summons[action_bar.current()]) and mana >= summons[action_bar.current()].mana_cost:
		var spawned = summons[action_bar.current()].spawn(
			get_parent(),
			get_global_mouse_position())
		if spawned:
			summons[action_bar.current()].connect("reset", self, "update_grafics")
			summoned_mobs.append(summons[action_bar.current()])
			set_mana(mana - summons[action_bar.current()].mana_cost)
		update_grafics()

func update_grafics():
	var g_array = action_bar.get_grafic_array()
	var i = 0
	while i < summons_number:
		if summons[i] != null:
			g_array[i].get_node("TextureRect").texture =summons[i].get_icon()
			g_array[i].out_of_mana(mana <  summons[i].mana_cost)
			g_array[i].summoned(summons[i].summoned)
		i+=1

func set_actionbar(bar):
	action_bar = bar

func add_summon(sum, cost):
	summons[action_bar.current()] = summon.new(sum, cost)
	var t = summons[action_bar.current()].get_icon()
	action_bar.set_slot(t)
	update_grafics()

func set_summons(sums):
	summons = sums

func add_slot():
	pass

func set_mana(new_mana: int):
	var old_mana = get_mana()
	if old_mana != new_mana:
		mana = int(clamp(new_mana, 0, max_mana))
		emit_signal("mana_changed", old_mana, get_mana())
		update_grafics()

func get_mana() -> int:
	return mana

func set_max_mana(new_max_mana: int):
	max_mana = new_max_mana
	set_mana(new_max_mana)

func get_current_cost() -> int:
	if summons[action_bar.current()] == null:
		return 0
	return summons[action_bar.current()].mana_cost

func destroy_summons():
	for mob in summoned_mobs:
		if is_instance_valid(mob):
			mob.reset()
			update_grafics()

func set_slot_number(num: int):
	action_bar.slot_number = num

func get_slot_number():
	return action_bar.slot_number
