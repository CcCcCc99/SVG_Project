extends Area2D

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Player"):
		body.checkpoint_position = self.position
		body.checkpoint_room = get_parent().get_parent().get_parent().current_room
		get_parent().get_parent().get_parent().save()
