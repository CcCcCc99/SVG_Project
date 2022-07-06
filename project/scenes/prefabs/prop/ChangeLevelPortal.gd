extends Area2D

export var to_level = 0

func _on_Portal_body_entered(body):
	get_tree().root.get_node("Main")._switch_to_level(to_level)
