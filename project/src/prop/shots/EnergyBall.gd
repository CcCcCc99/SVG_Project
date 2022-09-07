extends Shot

func _on_hit(body):
	if not body.is_in_group("Boss"):
		._on_hit(body)
