extends Node2D

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
	$Head.flip_h = false
	$Head.animation = "front"
	$Body.animation = "front"
	$Legs.animation = "idle"

func _set_horizontal(direction):
	$Head.animation = "side"
	$Body.animation = "back"
	if direction < 0:
		$Head.flip_h = true
		$Legs.animation = "left"
	else:
		$Head.flip_h = false
		$Legs.animation = "right"

func _set_vertical(direction):
	$Head.flip_h = false
	if direction < 0:
		$Head.animation = "back"
		$Body.animation = "back"
	else:
		$Head.animation = "front"
		$Body.animation = "front"
	$Legs.animation = "vertical"
