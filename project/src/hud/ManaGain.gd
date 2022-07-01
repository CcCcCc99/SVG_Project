extends StaticBody2D

var assistant

func _on_Area2DGain_body_entered(body):
	if body.is_in_group("Player"):
		var mana = assistant.get_mana()
		assistant.set_mana(mana + 1)
		if(mana != assistant.get_mana()):
			self.queue_free()

func set_assistant(assistant):
	self.assistant = assistant
