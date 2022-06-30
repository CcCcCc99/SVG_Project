extends StaticBody2D

var assistant

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		assistant.set_mana(assistant.get_mana() + 1)
		self.queue_free()

func set_assistant(assistant):
	self.assistant = assistant
