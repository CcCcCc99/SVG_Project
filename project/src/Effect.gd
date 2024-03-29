extends AudioStreamPlayer

onready var timer = get_node("Timer")

var room = null

func set_effect(audio: String, volume: float, pitch: float, loop: bool) -> void:
	set_stream(load(audio))
	set_volume_db(volume)
	set_pitch_scale(pitch)
	play()
	
	if not loop:
		timer.set_wait_time(get_stream().get_length() / get_pitch_scale())
		timer.start()
	else:
		room = get_parent().get_parent().get_node("Main").current_room

func get_room():
	return room

func end_effect() -> void:
	queue_free()

func deactivate() -> void:
	stop()

func reactivate() -> void:
	play()
