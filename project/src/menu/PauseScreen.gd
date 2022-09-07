extends Menu

func _ready():
	menu_buttons = $Menu.get_children()

func _press_button_number(num: int):
	match selected_menu:
		0:
			_on_ResumeButton_pressed()
		1:
			_on_OptionsButton_pressed()
		2:
			_on_BackToTitleButton_pressed()

func _on_ResumeButton_pressed():
	get_parent().get_parent().resume()
	get_node("/root/AudioManager").resume_music()

func _on_OptionsButton_pressed():
	disable()
	stacked_menu = load("res://scenes/menu/OptionScreen.tscn").instance()
	add_child(stacked_menu)

func _on_BackToTitleButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/menu/StartScreen.tscn")
	get_node("/root/AudioManager").resume_music()
	get_node("/root/AudioManager").end_effects()
