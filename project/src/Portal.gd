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
		_recive(body)
	elif destination != null:
		body.start_scaling_down()
		body.connect("scaled_down", self, "_send", [body])

func _send(body):
	destination.is_reciving = true
	body.position = destination.position

func _recive(body):
	is_reciving = false
	body.start_scaling_up()
