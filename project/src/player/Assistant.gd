extends Node2D

class summon:
	var mob: Mob
	var summoned: bool

	func _init(m):
		mob = m
		summoned = false

	func spawn(parent: Node, pos: Vector2):
		if not summoned:
			summoned = true
			mob.is_summoned = true
			mob.position = pos
			mob.modulate = Color.darkblue
			parent.add_child(mob)

var summons: Array = [null, null, null, null, null, null]
export var summons_number = 1

var action_bar setget set_actionbar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("summon") and is_instance_valid(summons[action_bar.current()]):
		summons[action_bar.current()].spawn(
			get_parent().get_node("Room").get_node("Objects"),
			get_global_mouse_position())

func set_actionbar(bar):
	action_bar = bar

func add_summon(sum):
	summons[action_bar.current()] = summon.new(sum)
	var t = sum.icon
	action_bar.set_slot(t)

func add_slot():
	pass
