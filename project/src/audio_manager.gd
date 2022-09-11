extends Node

var effect = preload("res://scenes/Effect.tscn")

var musics
var actual_audio = null
var actual_volume: float = 0.0
var actual_pitch: float = 0.0

var previous_volume: float = 0.0
var previous_pos: float = 0.0

func _ready() -> void:
	var m = Node.new()
	m.name = "Musics"
	add_child(m)
	musics = m
	musics.set_pause_mode(2)
	var music = AudioStreamPlayer.new()
	music.set_bus("Music")
	musics.add_child(music)

func add_effect(audio: String, volume: float, pitch: float, loop: bool) -> Node:
	var new_effect = effect.instance()
	add_child(new_effect)
	new_effect.set_effect(audio, volume, pitch, loop)
	return new_effect

func set_volume_music(volume: float) -> void:
	var actual_music = musics.get_child(0)
	previous_volume = actual_music.get_volume_db()
	previous_pos = actual_music.get_playback_position()
	actual_music.set_volume_db(volume)
	actual_music.play(previous_pos)

func change_music(audio: String, volume: float, pitch: float) -> void:
	var actual_music = musics.get_child(0)
	if actual_audio != null:
		if actual_audio == audio:
			if actual_volume == volume:
				if actual_pitch == pitch:
					return
				else:
					actual_pitch = pitch
			else:
				actual_volume = volume
				actual_pitch = pitch
		else:
			actual_audio = audio
			actual_volume = volume
			actual_pitch = pitch
	else:
		actual_audio = audio
		actual_volume = volume
		actual_pitch = pitch
	

	actual_music.stop()
	actual_music.set_stream(load(audio))
	actual_music.set_volume_db(volume)
	actual_music.set_pitch_scale(pitch)
	actual_music.play()


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
