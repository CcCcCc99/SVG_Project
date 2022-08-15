extends AnimatedSprite

export(PackedScene) var bomb

var actual_bomb: Node

func _ready():
	$Timer.start()
	get_node("/root/AudioManager").add_effect("res://assets/audio/41254196_sewing-machine-slow-speed-01.mp3", 0.0, 0.5, true)

func _on_Timer_timeout():
	if not is_instance_valid(actual_bomb):
		var b = bomb.instance()
		b.position.x = global_position.x - 40
		b.position.y = global_position.y + 60
		get_parent().add_child(b)
		actual_bomb = b
