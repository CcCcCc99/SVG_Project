extends Area2D

func _on_crepa_body_entered(body):
	if not body.can_fly:
		$CollisionPolygon2D.disabled = false
	else:
		$CollisionPolygon2D.disabled = true
