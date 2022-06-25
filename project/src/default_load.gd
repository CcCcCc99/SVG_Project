extends Node

var master_volume: float = 0
var sfx_volume: float = 0
var music_volume: float = 0

var resolution: Vector2
var fullscreen: bool

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), master_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), sfx_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_volume)
