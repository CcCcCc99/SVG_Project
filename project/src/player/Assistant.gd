extends Area2D

var summons: Array = [null, null, null, null, null, null]
var summoned_mobs: Array
export var summons_number: int = 1

export(int) var max_mana: int
var mana: int = 0 setget set_mana, get_mana

signal mana_changed(old_mana, new_mana)

var slot_number: int setget set_slot_number, get_slot_number
var action_bar setget set_actionbar

var is_inspecting: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _input(event):
	var can_summon: bool = event.is_action_pressed("summon")
	can_summon = can_summon and is_instance_valid(summons[action_bar.current()])
	can_summon = can_summon and mana >= summons[action_bar.current()].mana_cost
	can_summon = can_summon and not is_inspecting
	if  can_summon:
		var spawned = summons[action_bar.current()].spawn(
			get_parent(),
			get_global_mouse_position())
		if spawned:
			summons[action_bar.current()].connect("reset", self, "update_grafics")
			summoned_mobs.append(summons[action_bar.current()])
			set_mana(mana - summons[action_bar.current()].mana_cost)
		update_grafics()

# warning-ignore:unused_argument
func _physics_process(delta):
	if state == SCALEDOWN:
		_scale_down()
	elif state == SCALEUP:
		_scale_up()

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
	summons_number += 1
	set_slot_number(summons_number)
	update_grafics()

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
	slot_number = num
	action_bar.set_num(slot_number)

func get_slot_number():
	return action_bar.slot_number

############################################

# Manage teleport

enum {NORMAL, SCALEUP, SCALEDOWN}
var state = NORMAL
var original_scale
var destination = null
var i = 0

func _reset_animations():
	scale = original_scale
	visible = true
	rotation = 0

func teleport_to(dest: Portal2D):
	if original_scale != null:
		if original_scale != scale:
			return
	if is_instance_valid(dest):
		original_scale = scale
		destination = dest.position
		start_scaling_down()

func _teleport():
	position = destination
	start_scaling_up()

func _scale_up():
	if scale < Vector2(1,1):
		scale *= 1.3
		rotation = sin(i)
		i += 0.5
	else:
		#emit_signal("scaled_up")
		_reset_animations()
		state = NORMAL

func _scale_down():
	if scale > Vector2(0.1,0.1):
		scale *= 0.7
		rotation = sin(i)
		i += 0.5
	else:
		_teleport()

func start_scaling_down():
	state = SCALEDOWN

func start_scaling_up():
	state = SCALEUP

func back_to_normal():
	state = NORMAL


func _on_Assistant_area_entered(area):
	if area.is_in_group("Portal"):
		area._on_Portal_body_entered(self)
