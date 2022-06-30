extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		var hp = body.get_hp()
		body.set_hp(body.get_hp() + 1)
		if (hp != body.get_hp()):
			self.queue_free()
