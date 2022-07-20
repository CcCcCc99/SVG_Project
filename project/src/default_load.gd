extends Node

var music_volume: float = 10
var sfx_volume: float = 10
var master_volume: float = 10

var resolution: Vector2 = Vector2(1920,1080)
var fullscreen: bool = false

const config_path = "config"

func _ready() -> void:
	_load_config()
	_set_config()

func _volume_to_db(volume: float) -> float:
	return log(volume / 10) * 20

func set_resolution(res: Vector2) -> void:
	if resolution != res:
		resolution = res
		
		OS.set_window_size(resolution)
		OS.center_window()
		
		_save_config()

func set_fullscreen(fs: bool) -> void:
	if fullscreen != fs:
		fullscreen = fs
		
		OS.set_window_full_screen(fullscreen)
		
		_save_config()

func set_volume(bus: String, value: int):
	match bus:
		"Master":
			master_volume = value
		"SFX":
			sfx_volume = value
		"Music":
			music_volume = value
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), _volume_to_db(value))
	_save_config()

func _save_config() -> void:
	var file = File.new()
	file.open(config_path, File.WRITE)
	
	file.store_var(music_volume)
	file.store_var(sfx_volume)
	file.store_var(master_volume)
	
	file.store_var(resolution)
	file.store_var(fullscreen)
	
	file.close()

func _load_config() -> void:
	var file = File.new()
	file.open(config_path, File.READ)
	
	music_volume = file.get_var()
	sfx_volume = file.get_var()
	master_volume = file.get_var()
	
	resolution = file.get_var()
	fullscreen = file.get_var()
	
	file.close()

func _set_config() -> void:
	# volumi da settare
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), _volume_to_db(master_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), _volume_to_db(sfx_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), _volume_to_db(music_volume))
	
	# risoluzione da settare
	OS.set_window_size(resolution)
	OS.center_window()
	OS.set_window_fullscreen(fullscreen)

