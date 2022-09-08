extends Area2D

export var object: PackedScene

var has_object: bool = true
signal object_collected

func start():
	pass

func _on_ObjectStand_body_entered(body):
	if body.is_in_group("Player") and has_object:
		remove_object()
		if is_instance_valid(object) and not body.has_node("FlyingDiamond"):
			body.add_child(object.instance())
			body.get_node("FlyingDiamond").active = true
		emit_signal("object_collected")
		get_node("/root/AudioManager").add_effect("res://assets/audio/win sound 1-2.wav", 0.0, 1.0, false)

func remove_object():
	has_object = false
	$Object.hide()
	$AnimationPlayer.stop()
