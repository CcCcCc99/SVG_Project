extends KinematicBody2D
class_name Character

const POOF: PackedScene = preload("res://scenes/Poof.tscn")
var effect
enum {NORMAL, SCALEUP, SCALEDOWN}

export(int) var max_hp
var hp = 2 setget set_hp

export(int) var speed
var velocity = Vector2.ZERO

var is_dead: bool = false
var state = NORMAL

signal scaled_down
signal scaled_up

func _ready():
	effect = POOF.instance()
	effect.connect("animation_finished", self, "_end_effect")
	self.connect("scaled_down", self, "_teleport")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = get_direction() * speed
	# warning-ignore:return_value_discarded
	if state == NORMAL:
		move_and_slide(velocity*delta)

# warning-ignore:unused_argument
func _physics_process(delta):
	if state == SCALEDOWN:
		_scale_down()
	elif state == SCALEUP:
		_scale_up()

func get_direction() -> Vector2:
	return Vector2.ZERO

func set_hp(new_hp: int):
	hp = clamp(new_hp, 0, max_hp)

func is_normal() -> bool:
	return state == NORMAL

func take_damage():
	pass

func _spawn_death_effect():
	add_child(effect)
	effect.play()

func _end_effect():
	effect.queue_free()


############################################

# Manage teleport

var i = 0
var destination = null

func teleport_to(dest: Portal2D):
	if dest != null:
		destination = dest.position
		start_scaling_down()

func _teleport():
	position = destination

func _scale_up():
	if scale < Vector2(1,1):
		scale *= 1.1
		rotation = sin(i)
		i += 0.5
	else:
		emit_signal("scaled_up")
		scale = Vector2(1,1)
		rotation = 0
		state = NORMAL

func _scale_down():
	if scale > Vector2(0.1,0.1):
		scale *= 0.9
		rotation = sin(i)
		i += 0.5
	else:
		emit_signal("scaled_down")

func start_scaling_down():
	state = SCALEDOWN

func start_scaling_up():
	state = SCALEUP
