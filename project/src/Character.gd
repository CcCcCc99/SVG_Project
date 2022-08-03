extends KinematicBody2D
class_name Character

export(PackedScene) var POOF
export(PackedScene) var CORPSE

var effect
var corpse
enum {NORMAL, INCAPACITATED, SCALEUP, SCALEDOWN}

export(int) var max_hp: int
var hp: int setget set_hp, get_hp

export(int) var speed
var alt_velocity = Vector2.ZERO

var i = 0 # for animations

var is_dead: bool = false
var is_taking_damage = false
var state = NORMAL

signal scaled_down
signal scaled_up

export var automated_hp: bool = true

func _ready():
	if automated_hp:
		set_hp(max_hp)
	effect = POOF.instance()
	corpse = CORPSE.instance()
	effect.connect("animation_finished", self, "_end_effect")
	self.connect("scaled_down", self, "_teleport")
	$InvincibilityTimer.connect("timeout", self, "_on_invincibility_timeout")

# warning-ignore:unused_argument
func _physics_process(delta):
	var velocity
	# warning-ignore:return_value_discarded
	if state == NORMAL:
		velocity = get_direction() * speed
	else:
		velocity = alt_velocity
	move_and_slide(velocity*delta)
	if state == SCALEDOWN:
		_scale_down()
	elif state == SCALEUP:
		_scale_up()
	if is_taking_damage:
		_animate_damage()

func get_direction() -> Vector2:
	return Vector2.ZERO

func set_hp(new_hp: int):
	hp = clamp(new_hp, 0, max_hp)

func get_hp() -> int:
	return hp

func is_normal() -> bool:
	return state == NORMAL

func _reset_animations():
	scale.x = 1 if scale.x > 0 else -1
	scale.y = 1 if scale.y > 0 else -1
	visible = true
	rotation = 0


############################################

# Manage damage

func take_damage(damage: int):
	if $InvincibilityTimer.is_stopped():
		$InvincibilityTimer.start()
		is_taking_damage = true
		set_hp(hp - damage)
		if hp <= 0:
			 _spawn_death_effect()

func _animate_damage():
	scale = Vector2(clamp(abs(sin(i)), 0.5, 1), clamp(abs(cos(i)), 0.5, 1))
	visible = int(i+100) % 2 == 0
	i+=0.1

func _on_invincibility_timeout():
	is_taking_damage = false
	_reset_animations()
	$InvincibilityTimer.stop()

func _spawn_death_effect():
	add_child(effect)
	effect.play()

func _end_effect():
	effect.queue_free()
	_spawn_corpse()
	self.queue_free()
	
func _spawn_corpse():
	corpse.position = position
	get_parent().add_child(corpse)

############################################

# Manage teleport

var destination = null

func teleport_to(dest: Portal2D):
	if is_instance_valid(dest):
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
		emit_signal("scaled_up")
		_reset_animations()
		state = NORMAL

func _scale_down():
	if scale > Vector2(0.1,0.1):
		scale *= 0.7
		rotation = sin(i)
		i += 0.5
	else:
		emit_signal("scaled_down")

func start_scaling_down():
	state = SCALEDOWN

func start_scaling_up():
	state = SCALEUP

func incapacitate():
	state = INCAPACITATED

func back_to_normal():
	state = NORMAL
