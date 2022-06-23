extends Shot

export var bounces: int = 5
var cont: int = 0
var is_stopped = true

func _on_hit(body):
	if not is_stopped:
		if body.is_in_group("VerticalEnvironment"):
			_bounce(false)
		elif body.is_in_group("HorizontalEnvironment"):
			_bounce(true)
		else:
			._on_hit(body)

func _bounce(horizontal):
	if cont < bounces:
		if horizontal:
			direction.x *= -1
		else:
			direction.y *= -1
		cont += 1
	else:
		_stop()

func _stop():
	cont = 0
	.set_direction(Vector2.ZERO)
	is_stopped = true
