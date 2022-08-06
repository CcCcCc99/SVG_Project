extends Shot

var is_damage_enabled: bool = false

func _on_hit(body):
	if is_damage_enabled:
		._on_hit(body)

func _on_FireSpit_area_exited(area):
	is_damage_enabled = true

func set_pos_dir(pos: Vector2, dir: int, num: int):
	position = pos
	var y
	match num:
		0: y = -1
		1: y = 0
		2: y = 1
	.set_direction(Vector2(dir*2, y))
