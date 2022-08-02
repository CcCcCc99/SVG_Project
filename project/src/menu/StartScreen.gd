extends Menu

func _ready():
	menu_buttons = $Menu.get_children()
	get_node("/root/AudioManager").change_music("res://assets/audio/fato_shadow_-_in_my_dreams.ogg", -5.0, 1.0)

func _press_button_number(num: int):
	match num:
		0:
			_on_NewGameButton_pressed()
		1:
			_on_LoadGameButton_pressed()
		2:
			_on_OptionsButton_pressed()
		3:
			_on_QuitButton_pressed()

func _on_NewGameButton_pressed():
	get_node("/root/DefaultLoad").load_mode = false
	get_tree().change_scene("res://Main.tscn")

func _on_LoadGameButton_pressed():
	get_node("/root/DefaultLoad").load_mode = true
	get_tree().change_scene("res://Main.tscn")

func _on_OptionsButton_pressed():
	disable()
	stacked_menu = load("res://scenes/menu/OptionScreen.tscn").instance()
	add_child(stacked_menu)

func _on_QuitButton_pressed():
	get_tree().quit()
