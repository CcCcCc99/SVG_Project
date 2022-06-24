extends Node

var music_volume: float
var sfx_volume: float
var master_volume: float

var resolution: Vector2
var fullscreen: bool

func _ready() -> void:
	_load_config()
	_set_config()

func _save_config() -> void:
	var file = File.new()
	file.open("config.ini", File.WRITE)
	
	file.store_var(music_volume)
	file.store_var(sfx_volume)
	file.store_var(master_volume)
	
	file.store_var(resolution)
	file.store_var(fullscreen)
	
	file.close()

func _load_config() -> void:
	var file = File.new()
	file.open("config.ini", File.READ)
	
	music_volume = file.get_var()
	sfx_volume = file.get_var()
	master_volume = file.get_var()
	
	resolution = file.get_var()
	fullscreen = file.get_var()
	
	file.close()

func _set_config() -> void:
	# volumi da settare #
	OS.set_window_size(resolution)
	OS.set_window_fullscreen(fullscreen)
