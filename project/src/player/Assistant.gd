extends StaticBody2D

class summon:
	var mob: Mob
	var mana_cost: int
	var summoned: bool

	func _init(m, c):
		mob = m
		mana_cost = c
		summoned = false

	func spawn(parent: Node, pos: Vector2) -> Mob:
		if summoned:
			return null
		summoned = true
		mob.is_summoned = true
		mob.position = pos
		mob.modulate = Color.darkblue
		mob.get_node("Shadow").hide()
		parent.add_child(mob)
		return mob

var summons: Array = [null, null, null, null, null, null]
var summoned_mobs: Array
export var summons_number: int = 1

export(int) var max_mana: int
var mana: int = 0 setget set_mana, get_mana

signal mana_changed(old_mana, new_mana)

var action_bar setget set_actionbar

func _ready():
	set_mana(max_mana)

# Called every frame. 'delta' is the elapsed time since the previous frame.
var dialogue = preload("res://dialogues/Test.tres")
func _process(delta):
	if Input.is_action_just_released("debug1"):
		DialogueManager.show_example_dialogue_balloon("Room2Test", dialogue)
	var active: summon = summons[action_bar.current()]
	if Input.is_action_just_pressed("summon") and is_instance_valid(active) and mana >= active.mana_cost:
		var spawned = active.spawn(
			get_parent(),
			get_global_mouse_position())
		if spawned != null:
			summoned_mobs.append(spawned)
			set_mana(mana - active.mana_cost)
		_update_grafics()

func _update_grafics():
	var g_array = action_bar.get_grafic_array()
	var i = 0
	while i < summons_number:
		if summons[i] != null:
			g_array[i].out_of_mana(mana <  summons[i].mana_cost)
			g_array[i].summoned(summons[i].summoned)
		i+=1

func set_actionbar(bar):
	action_bar = bar
	action_bar.slot_number = summons_number

func add_summon(sum, cost):
	summons[action_bar.current()] = summon.new(sum, cost)
	var t = sum.icon
	action_bar.set_slot(t)
	_update_grafics()

func add_slot():
	pass

func set_mana(new_mana: int):
	var old_mana = get_mana()
	if old_mana != new_mana:
		mana = int(clamp(new_mana, 0, max_mana))
		emit_signal("mana_changed", old_mana, get_mana())

func get_mana() -> int:
	return mana

func set_max_mana(new_max_mana: int):
	max_mana = new_max_mana
	set_mana(new_max_mana)

<<<<<<< HEAD
func get_current_cost() -> int:
	if summons[action_bar.current()] == null:
		return 0
	return summons[action_bar.current()].mana_cost
=======
func destroy_summons():
	for mob in summoned_mobs:
		if is_instance_valid(mob):
			mob.queue_free()
>>>>>>> main
