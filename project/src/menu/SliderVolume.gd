extends HSlider


export var audio_bus_name := "Master"

#onready var _bus := AudioServer.get_bus_index(audio_bus_name)


func _ready() -> void:
	#value = db2linear(AudioServer.get_bus_volume_db(_bus))
	match audio_bus_name:
		"Master":
			value = get_tree().root.get_child(0).master_volume
		"SFX":
			value = get_tree().root.get_child(0).sfx_volume
		"Music":
			value = get_tree().root.get_child(0).music_volume
