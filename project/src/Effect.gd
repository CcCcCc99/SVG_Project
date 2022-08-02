extends AudioStreamPlayer

onready var timer = get_node("Timer")

func set_effect(audio: String, volume: float, pitch: float) -> void:
	set_stream(load(audio))
	set_volume_db(volume)
	set_pitch_scale(pitch)
	play()
	
	timer.set_wait_time(get_stream().get_length() / get_pitch_scale())
	timer.start()

func _on_Timer_timeout() -> void:
	queue_free()
