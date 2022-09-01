extends Area2D

export var to_level = 0

export var active: bool = true
export var go_back: bool = false
export var active_color: Color
export var inactive_color: Color

func _ready():
	if not active:
		deactivate_portal()
	get_parent().get_parent().connect("completed", self, "_on_room_clear")

func activate_portal():
	active = true
	modulate = active_color

func deactivate_portal():
	active = false
	modulate = inactive_color

func _on_room_clear():
	show()

func _on_Portal_body_entered(body):
	if active and body.is_in_group("Player"):
		get_tree().root.get_node("Main")._switch_to_level(to_level)
