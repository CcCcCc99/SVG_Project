extends Node

var music_volume: float
var sfx_volume: float
var master_volume: float

var resolution: Vector2
var fullscreen: bool

func _ready() -> void:
	_load_config()
	_set_config()

func set_resolution(res: Vector2) -> void:
	if resolution != res:
		resolution = res
		
		if resolution < OS.get_screen_size():
			OS.set_window_maximized(false)
			OS.set_window_size(resolution)
		else:
			if !OS.is_window_maximized():
				OS.set_window_size(OS.get_screen_size())
				OS.set_window_maximized(true)
		OS.center_window()
		
		_save_config()

func set_fullscreen(fs: bool) -> void:
	if fullscreen != fs:
		fullscreen = fs
		
		OS.set_window_full_screen(fullscreen)
		
		_save_config()

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
	OS.set_window_resizable(false)
	if resolution < OS.get_screen_size():
		OS.set_window_maximized(false)
		OS.set_window_size(resolution)
	else:
		OS.set_window_size(OS.get_screen_size())
		OS.set_window_maximized(true)
	OS.center_window()
	OS.set_window_fullscreen(fullscreen)
