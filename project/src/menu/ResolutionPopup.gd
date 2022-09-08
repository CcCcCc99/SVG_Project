extends Menu

onready var config = get_node("/root/DefaultLoad")

var last_pressed: bool

func _ready():
	if get_parent().get_parent().name == "PauseScreen":
		$Background.show()
	menu_buttons = $VBox/Menu.get_children()
	
	if config.fullscreen:
		$VBox/Fullscreen.pressed = true
	last_pressed = $VBox/Fullscreen.pressed
	menu_buttons.append($VBox/Fullscreen)
	
	menu_buttons.append($VBox/Back)

func _press_button_number(num: int):
	match selected_menu:
		0:
			_on_Res1024x546_pressed()
		1:
			_on_Res1280x720_pressed()
		2:
			_on_Res1600x900_pressed()
		3:
			_on_Res1920x1080_pressed()
		4:
			_on_Fullscreen_pressed()
		5:
			_on_Back_pressed()

func _on_Res1024x546_pressed():
	config.set_resolution(Vector2(1024, 546))

func _on_Res1280x720_pressed():
	config.set_resolution(Vector2(1280, 720))

func _on_Res1600x900_pressed():
	config.set_resolution(Vector2(1600, 900))

func _on_Res1920x1080_pressed():
	config.set_resolution(Vector2(1920, 1080))

func _on_Fullscreen_pressed():
	config.set_fullscreen(not config.fullscreen)
	if last_pressed == $VBox/Fullscreen.pressed:
		$VBox/Fullscreen.pressed = not $VBox/Fullscreen.pressed
	last_pressed = not last_pressed

func _on_Back_pressed():
	get_parent().enable()
