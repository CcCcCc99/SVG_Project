extends AnimatedSprite

export(PackedScene) var bomb

onready var max_children: int = get_parent().get_child_count() + 1

func _ready():
	$Timer.start()
	get_node("/root/AudioManager").add_effect("res://assets/audio/41254196_sewing-machine-slow-speed-01.mp3", -10.0, 0.5, true)

func _on_Timer_timeout():
	if get_parent().get_child_count() < max_children:
		var b = bomb.instance()
		b.position.x = global_position.x - 40
		b.position.y = global_position.y + 60
		get_parent().add_child(b)
