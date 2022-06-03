extends Shot

func _on_hit(body):
	._on_hit(body)
	# push player
	if body.is_in_group("Character"):
		print("Spingi")
