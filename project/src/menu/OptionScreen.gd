extends Menu

func _ready():
	menu_buttons = $Menu.get_children()

func _press_button_number(num: int):
	match selected_menu:
		0:
			_on_Resolution_pressed()
		1:
			_on_Volume_pressed()
		2:
			_on_Back_pressed()

func _on_Resolution_pressed():
	disable()
	stacked_menu = load("res://scenes/menu/ResolutionPopup.tscn").instance()
	add_child(stacked_menu)

func _on_Volume_pressed():
	disable()
	stacked_menu = load("res://scenes/menu/VolumeScreen.tscn").instance()
	add_child(stacked_menu)

func _on_Back_pressed():
	get_parent().enable()
