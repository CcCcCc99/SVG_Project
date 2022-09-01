extends Node

var load_mode: bool = false

var music_volume: float = 10
var sfx_volume: float = 10
var master_volume: float = 10

var resolution: Vector2 = Vector2(1920,1080)
var fullscreen: bool = false

const config_path = "saves/config"
const saving_path = "saves/game"

func _ready() -> void:
	_load_config()
	_set_config()

func _input(event):
	if event.is_action_pressed("fullscreen"):
		set_fullscreen(not fullscreen)

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
		
		OS.window_fullscreen = fullscreen
		
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

func save_game_state(state: GameState):
	var file = File.new()
	file.open(saving_path, File.WRITE)

	file.store_var(state.hp)
	file.store_var(state.max_hp)
	file.store_var(state.mp)
	file.store_var(state.max_mp)
	file.store_var(state.slot_num)
	
	for i in 6:
		var sum: summon = state.action_bar[i]
		if sum == null:
			sum = summon.new("",-1)
		file.store_var(sum.scene)
		file.store_var(sum.mana_cost)
	
	file.store_var(state.check_point.room)
	file.store_var(state.check_point.level)
	file.store_var(state.check_point.position)
	
	file.store_var(state.events)

	file.close()

func load_game_state() -> GameState:
	var file = File.new()
	file.open(saving_path, File.READ)
	
	var state: GameState = GameState.new()
	state.hp = file.get_var()
	state.max_hp = file.get_var()
	state.mp = file.get_var()
	state.max_mp = file.get_var()
	state.slot_num = file.get_var()
	
	var summons: Array
	for i in 6:
		var scene = file.get_var()
		var mana_cost = file.get_var()
		var sum: summon = summon.new(scene, mana_cost)
		if sum.mana_cost == -1:
			sum = null
		summons.append(sum)
	state.action_bar = summons
	
	state.check_point.room = file.get_var()
	state.check_point.level = file.get_var()
	state.check_point.position = file.get_var()
	
	state.events = file.get_var()
	
	file.close()
	return state

func _set_config() -> void:
	# volumi da settare
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), _volume_to_db(master_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), _volume_to_db(sfx_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), _volume_to_db(music_volume))
	
	# risoluzione da settare
	OS.set_window_size(resolution)
	OS.center_window()
	OS.set_window_fullscreen(fullscreen)

