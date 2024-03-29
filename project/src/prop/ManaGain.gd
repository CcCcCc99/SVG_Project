extends Pickupable

var assistant

func _ready():
	assistant = get_parent().get_parent().get_node("Assistant")

func _effect(player: Character):
	var mana = assistant.get_mana()
	assistant.set_mana(mana + 1)
	if(mana != assistant.get_mana()):
		self.queue_free()
		get_node("/root/AudioManager").add_effect("res://assets/audio/heal.wav", 0.0, 1.0, false)
