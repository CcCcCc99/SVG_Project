extends Shot

var rng = RandomNumberGenerator.new()
var follow_mode: bool = false
var target = null

signal is_dead

func _init():
	rng.randomize()

func set_direction(dir: Vector2):
	var deviation = rng.randf_range(-0.5, 0.5)
	var multiplier = rng.randf_range(1, 2)
	dir.y += deviation
	dir = dir.normalized()
	dir *= multiplier
	direction = dir
	scale.x = 1 if dir.x > 0 else -1
	scale.y = -1 if dir.y > 0 else 1

func _physics_process(delta):
	if follow_mode:
		if is_instance_valid(target):
			direction = position.direction_to(target.position)
		else:
			direction = Vector2.ZERO
	._physics_process(delta)

func _on_Timer_timeout():
	follow_mode = true
	$EndTimer.start()

func _on_hit(body):
	if body.is_in_group("Boss"):
		return
	if body.is_in_group("Environment"):
		emit_signal("is_dead")
	._on_hit(body)
	if not body.is_in_group("Shot") and not body.is_in_group("Environment"):
		queue_free()
		emit_signal("is_dead")

func _on_EndTimer_timeout():
	queue_free()
	emit_signal("is_dead")
