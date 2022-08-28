extends Area2D

export var object: PackedScene

var has_object: bool = true
signal object_collected

func start():
	pass

func _on_ObjectStand_body_entered(body):
	if body.is_in_group("Player") and has_object:
		remove_object()
		emit_signal("object_collected")

func remove_object():
	has_object = false
	$Object.hide()
	$AnimationPlayer.stop()
