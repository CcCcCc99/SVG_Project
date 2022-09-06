extends Node

var effect = preload("res://scenes/Effect.tscn")

var musics

func _ready() -> void:
	var m = Node.new()
	m.name = "Musics"
	add_child(m)
	musics = m

func add_effect(audio: String, volume: float, pitch: float, loop: bool) -> Node:
	var new_effect = effect.instance()
	add_child(new_effect)
	new_effect.set_effect(audio, volume, pitch, loop)
	return new_effect

func add_music(audio: String, volume: float, pitch: float) -> void:
	if musics.get_child_count() != 0:
		musics.get_child(0).set_stream_paused(true)
	var music = AudioStreamPlayer.new()
	music.set_stream(load(audio))
	music.set_volume_db(volume)
	music.set_pitch_scale(pitch)
	music.set_bus("Music")
	musics.add_child(music)
	music.play()

func change_music(audio: String, volume: float, pitch: float) -> void:
	if musics.get_child_count() != 0:
		musics.get_child(0).queue_free()
	add_music(audio, volume, pitch)

func resume_music() -> void:
	musics.get_child(1).queue_free()
	musics.get_child(0).set_stream_paused(false)

func end_effects() -> void:
	if get_child_count() != 1:
		var i = 1
		var number_of_children = get_child_count()
		while i < number_of_children:
			get_child(i).queue_free()
			i += 1

func deactivate_effects() -> void:
	if get_child_count() != 1:
		var i = 1
		var number_of_children = get_child_count()
		while i < number_of_children:
			if get_child(i).get_room() == null:
				get_child(i).queue_free()
			else:
				get_child(i).deactivate()
			i += 1

func reactivate_effects(room: int) -> void:
	if get_child_count() != 1:
		var i = 1
		var number_of_children = get_child_count()
		while i < number_of_children:
			if get_child(i).get_room() == room:
				get_child(i).reactivate()
			i += 1
