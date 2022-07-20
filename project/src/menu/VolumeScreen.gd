extends Menu

func _ready():
	menu_buttons.append($Menu/Back)

func _press_button_number(num: int):
	match num:
		0:
			_on_Back_pressed()

func _on_Back_pressed():
	get_parent().enable()
