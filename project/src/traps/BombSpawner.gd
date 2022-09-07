extends AnimatedSprite

export(PackedScene) var bomb

var actual_bomb: Node

func _ready():
	$Timer.start()
	get_node("/root/AudioManager").add_effect("res://assets/audio/41254196_sewing-machine-slow-speed-01.mp3", -10.0, 0.5, true)

func _on_Timer_timeout():
	if not is_instance_valid(actual_bomb):
		var b = bomb.instance()
		b.position = $Position2D.global_position
		get_parent().add_child(b)
		actual_bomb = b
