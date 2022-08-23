extends "res://src/prop/Levers/LeverCoil.gd"

var event: Event

func _ready():
	event = get_parent().get_parent().get_node("Events/LeverEvent")
	check_lever_status()

func check_lever_status():
	if is_on:
		_activate()
	else:
		_deactivate()

func _activate():
	._activate()
	event.activated = true

func _deactivate():
	._deactivate()
	event.is_ever_used = true
	event.activated = false
