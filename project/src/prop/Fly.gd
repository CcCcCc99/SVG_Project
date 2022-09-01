extends Shot

var rng = RandomNumberGenerator.new()
var follow_mode: bool = false

func _init():
	rng.randomize()

func set_direction(dir: Vector2):
	var deviation = rng.randf_range(-0.5, 0.5)
	var multiplier = rng.randf_range(1, 2.5)
	dir.y += deviation
	dir *= multiplier
	direction = dir
	scale.x = 1 if dir.x > 0 else -1
	scale.y = -1 if dir.y > 0 else 1

func _physics_process(delta):
	if follow_mode:
		direction = Vector2.ZERO
	._physics_process(delta)

func _on_Timer_timeout():
	follow_mode = true
