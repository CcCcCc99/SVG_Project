extends Area2D
class_name Lever

export var is_on: bool = false

signal used
signal staus_changed(status)

func _ready():
	update_grafic()

func update_grafic():
	if is_on:
		$AnimatedSprite.animation = "on"
	else:
		$AnimatedSprite.animation = "off"

func _on_Lever_body_entered(body):
	is_on = not is_on
	update_grafic()
	get_node("/root/AudioManager").add_effect("res://assets/audio/41278707_toaster-lever-popping-up-01.mp3", 0.0, 1.0, false)
	if is_on:
		_activate()
	else:
		_deactivate()
	emit_signal("used")
	emit_signal("staus_changed", is_on)

func _activate():
	pass

func _deactivate():
	pass
