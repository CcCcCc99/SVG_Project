extends Area2D



func _on_crepa_body_entered(body):
	if body.can_fly:
		$CollisionPolygon2D.disabled = true
	else:
		$CollisionPolygon2D.disabled = false
