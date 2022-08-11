extends Area2D
class_name Lever

export var is_on: bool = false

signal used

func _ready():
	_update_grafic()

func _update_grafic():
	if is_on:
		$AnimatedSprite.animation = "on"
	else:
		$AnimatedSprite.animation = "off"

func _on_Lever_body_entered(body):
	is_on = not is_on
	_update_grafic()
	if is_on:
		_activate()
	else:
		_deactivate()
	emit_signal("used")

func _activate():
	pass

func _deactivate():
	pass
