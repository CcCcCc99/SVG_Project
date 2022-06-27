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
	if horizontal:
		direction.x *= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	else:
		direction.y *= -1
	if $CooldownTimer.is_stopped():
		if cont < bounces:
			cont += 1
		else:
			_stop()

func _stop():
	cont = 0
	$CooldownTimer.start()

func _on_CooldownTimer_timeout():
	$CooldownTimer.stop()
	.set_direction(Vector2.ZERO)
	is_stopped = true
