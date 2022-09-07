extends Shot

func _on_hit(body):
	._on_hit(body)
	if body.is_in_group("Character"):
		if body.is_in_group("Hitbox"):
			body = body.get_character()
