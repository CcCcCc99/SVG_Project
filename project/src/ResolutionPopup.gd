extends CenterContainer

var selected_menu = 0
var pointer

var back_to: bool

onready var config = get_node("/root/DefaultLoad")

func change_menu_color():
	_remove_pointer()
	
	match selected_menu:
		0:
			_on_Res1024x546_mouse_entered()
		1:
			_on_Res1280x720_mouse_entered()
		2:
			_on_Res1600x900_mouse_entered()
		3:
			_on_Res1920x1080_mouse_entered()
		4:
			_on_Back_mouse_entered()

func _remove_pointer():
	for child in $VBox/Menu.get_children():
		if child.has_node(pointer.name):
			child.modulate = "969696"
			child.remove_child(pointer)
			break
	if $VBox/Back.has_node(pointer.name):
		$VBox/Back.modulate = "969696"
		$VBox/Back.remove_child(pointer.name)

func set_back(b: bool):
	back_to = b

func _ready():
	pointer = $Pointer
	remove_child(pointer)
	change_menu_color()

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 5;
		change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu = (selected_menu - 1) % 5;
		else:
			selected_menu = 4
		change_menu_color()
	elif Input.is_mouse_button_pressed(1):
		pass
	elif Input.is_action_just_pressed("ui_accept"):
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
				_on_Back_pressed()

func _on_Res1024x546_pressed():
	config.set_resolution(Vector2(1024, 546))

func _on_Res1024x546_mouse_entered():
	_remove_pointer()
	$VBox/Menu/Res1024x546.modulate = "ffffff"
	$VBox/Menu/Res1024x546.add_child(pointer)
	selected_menu = 0

func _on_Res1024x546_mouse_exited():
	$VBox/Menu/Res1024x546.modulate = "969696"
	if $VBox/Menu/Res1024x546.has_node(pointer.name):
		$VBox/Menu/Res1024x546.remove_child(pointer)

func _on_Res1280x720_pressed():
	config.set_resolution(Vector2(1280, 720))

func _on_Res1280x720_mouse_entered():
	_remove_pointer()
	$VBox/Menu/Res1280x720.modulate = "ffffff"
	$VBox/Menu/Res1280x720.add_child(pointer)
	selected_menu = 1

func _on_Res1280x720_mouse_exited():
	$VBox/Menu/Res1280x720.modulate = "969696"
	if $VBox/Menu/Res1280x720.has_node(pointer.name):
		$VBox/Menu/Res1280x720.remove_child(pointer)

func _on_Res1600x900_pressed():
	config.set_resolution(Vector2(1600, 900))

func _on_Res1600x900_mouse_entered():
	_remove_pointer()
	$VBox/Menu/Res1600x900.modulate = "ffffff"
	$VBox/Menu/Res1600x900.add_child(pointer)
	selected_menu = 2

func _on_Res1600x900_mouse_exited():
	$VBox/Menu/Res1600x900.modulate = "969696"
	if $VBox/Menu/Res1600x900.has_node(pointer.name):
		$VBox/Menu/Res1600x900.remove_child(pointer)

func _on_Res1920x1080_pressed():
	config.set_resolution(Vector2(1920, 1080))

func _on_Res1920x1080_mouse_entered():
	_remove_pointer()
	$VBox/Menu/Res1920x1080.modulate = "ffffff"
	$VBox/Menu/Res1920x1080.add_child(pointer)
	selected_menu = 3

func _on_Res1920x1080_mouse_exited():
	$VBox/Menu/Res1920x1080.modulate = "969696"
	if $VBox/Menu/Res1920x1080.has_node(pointer.name):
		$VBox/Menu/Res1920x1080.remove_child(pointer)

func _on_Back_pressed():
	var parent = get_parent()
	var b = back_to
	parent.remove_child(self)
	queue_free()
	
	var options = load("res://scenes/menu/OptionScreen.tscn").instance()
	options.set_back(b)
	parent.add_child(options)

func _on_Back_mouse_entered():
	_remove_pointer()
	$VBox/Back.modulate = "ffffff"
	$VBox/Back.add_child(pointer)
	selected_menu = 4

func _on_Back_mouse_exited():
	$VBox/Back.modulate = "969696"
	if $VBox/Back.has_node(pointer.name):
		$VBox/Back.remove_child(pointer)
