extends Area2D
#class_name MyPortal

export(Array, Color) var colors
var destination = null

func set_color(i: int):
	modulate = colors[i]

#func set_destination(portal: MyPortal):
#	destination = portal

#func _on_Portal_body_entered(body:Node):
#	body.position = destination.position
#	pass # Replace with function body.
