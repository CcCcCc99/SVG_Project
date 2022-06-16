extends Shot

export var bounces: int = 4
var cont: int = 0

func _on_hit(body):
	if body.is_in_group("Environment"):
		_bouce()
	else:
		._on_hit(body)

func _bouce():
	if cont < bounces:
		direction.y *= -1
		cont += 1
	else:
		_stop()

func _stop():
	print("stop")
	pass
