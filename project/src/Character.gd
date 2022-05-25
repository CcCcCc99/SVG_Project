extends KinematicBody2D
class_name Character

const POOF: PackedScene = preload("res://scenes/Poof.tscn")
var effect

export(int) var max_hp
var hp = 2 setget set_hp

export(int) var speed
var velocity = Vector2.ZERO

var is_dead: bool = false


func _ready():
	effect = POOF.instance()
	effect.connect("animation_finished", self, "_end_effect")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = get_direction() * speed
	# warning-ignore:return_value_discarded
	move_and_slide(velocity*delta)

func get_direction() -> Vector2:
	return Vector2.ZERO

func set_hp(new_hp: int):
	hp = clamp(new_hp, 0, max_hp)

func take_damage():
	pass

func _spawn_death_effect():
	add_child(effect)
	effect.play()

func _end_effect():
	effect.queue_free()
