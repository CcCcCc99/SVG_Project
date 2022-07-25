extends Menu

func _ready():
	if get_parent().get_parent().name == "PauseScreen":
		$Background.show()
	menu_buttons.append($Menu/Back)

func _press_button_number(num: int):
	match num:
		0:
			_on_Back_pressed()

func _on_Back_pressed():
	get_parent().enable()


func _on_Master_value_changed(value):
	get_tree().root.get_child(0).set_volume("Master", value)


func _on_SoundEffects_value_changed(value):
	get_tree().root.get_child(0).set_volume("SFX", value)


func _on_BackgroundSound_value_changed(value):
	get_tree().root.get_child(0).set_volume("Music", value)
