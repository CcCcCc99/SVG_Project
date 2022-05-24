extends Area2D
class_name Protal2D

export(Array, Color) var colors
var destination = null
var is_reciving = false

func set_color(i: int):
	modulate = colors[i]

func set_destination(portal: Protal2D):
	destination = portal

func _on_Portal_body_entered(body: Node):
	if is_reciving:
		is_reciving = false
		body.start_scaling_up()
	elif destination != null:
		destination.is_reciving = true
		body.teleport_to(destination)
