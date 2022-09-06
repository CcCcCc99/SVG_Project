extends Area2D

func _on_crepa_body_entered(body):
	if body.is_in_group("Character"):
		if not body.can_fly:
			$CollisionPolygon2D.disabled = false
		else:
			$CollisionPolygon2D.disabled = true
