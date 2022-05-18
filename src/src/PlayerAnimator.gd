extends Node2D

onready var head = $Head
onready var body = $Body
onready var legs = $Legs

func animate(velocity):
	if velocity == Vector2.ZERO:
		_set_idle()
		pass
	elif velocity.x != 0:
		_set_horizontal(velocity.x)
		pass
	else:
		_set_vertical(velocity.y)
		pass

func _set_idle():
	head.flip_h = false
	head.animation = "front"
	body.animation = "front"
	legs.animation = "idle"

func _set_horizontal(direction):
	head.animation = "side"
	body.animation = "back"
	if direction < 0:
		head.flip_h = true
		legs.animation = "left"
	else:
		head.flip_h = false
		legs.animation = "right"

func _set_vertical(direction):
	head.flip_h = false
	if direction < 0:
		head.animation = "back"
		body.animation = "back"
	else:
		head.animation = "front"
		body.animation = "front"
	legs.animation = "vertical"
