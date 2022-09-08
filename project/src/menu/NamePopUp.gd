extends Menu

func _ready():
	menu_buttons.append($Control/OkButton)

func _press_button_number(num: int):
	match selected_menu:
		0:
			_on_ok_pressed()

func _on_ok_pressed():
	var name = $Control/TextEdit.text
	if name != "":
		get_parent().get_parent().save_name(name)
		queue_free()
		get_node("/root/DefaultLoad").is_blocked = false
