extends AnimatedSprite

func _ready():
	get_node("/root/AudioManager").add_effect("res://assets/audio/pop3.ogg", 8.565, 1.0, false)
