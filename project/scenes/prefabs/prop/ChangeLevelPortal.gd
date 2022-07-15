extends Area2D

export var to_level = 0

func _ready():
	$CollisionShape2D.disabled = true
	get_parent().get_parent().connect("completed", self, "_on_room_clear")

func _on_room_clear():
	$CollisionShape2D.disabled = false
	show()

func _on_Portal_body_entered(body):
	get_tree().root.get_node("Main")._switch_to_level(to_level)
