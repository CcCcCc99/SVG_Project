extends VBoxContainer

var selected_menu = 0
var pointer

onready var config = get_node("/root/DefaultLoad")

func change_menu_color():
	_on_Res1024x546_mouse_exited()
	_on_Res1280x720_mouse_exited()
	_on_Res1600x900_mouse_exited()
	_on_Res1920x1080_mouse_exited()
	_on_Back_mouse_exited()
	
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
	$Menu/Res1024x546.modulate = "ffffff"
	$Menu/Res1024x546.add_child(pointer)
	selected_menu = 0

func _on_Res1024x546_mouse_exited():
	$Menu/Res1024x546.modulate = "969696"
	if $Menu/Res1024x546.has_node(pointer.name):
		$Menu/Res1024x546.remove_child(pointer)

func _on_Res1280x720_pressed():
	config.set_resolution(Vector2(1280, 720))

func _on_Res1280x720_mouse_entered():
	$Menu/Res1280x720.modulate = "ffffff"
	$Menu/Res1280x720.add_child(pointer)
	selected_menu = 1

func _on_Res1280x720_mouse_exited():
	$Menu/Res1280x720.modulate = "969696"
	if $Menu/Res1280x720.has_node(pointer.name):
		$Menu/Res1280x720.remove_child(pointer)

func _on_Res1600x900_pressed():
	config.set_resolution(Vector2(1600, 900))

func _on_Res1600x900_mouse_entered():
	$Menu/Res1600x900.modulate = "ffffff"
	$Menu/Res1600x900.add_child(pointer)
	selected_menu = 2

func _on_Res1600x900_mouse_exited():
	$Menu/Res1600x900.modulate = "969696"
	if $Menu/Res1600x900.has_node(pointer.name):
		$Menu/Res1600x900.remove_child(pointer)

func _on_Res1920x1080_pressed():
	config.set_resolution(Vector2(1920, 1080))

func _on_Res1920x1080_mouse_entered():
	$Menu/Res1920x1080.modulate = "ffffff"
	$Menu/Res1920x1080.add_child(pointer)
	selected_menu = 3

func _on_Res1920x1080_mouse_exited():
	$Menu/Res1920x1080.modulate = "969696"
	if $Menu/Res1920x1080.has_node(pointer.name):
		$Menu/Res1920x1080.remove_child(pointer)

func _on_Back_pressed():
	var parent = get_parent()
	parent.remove_child(self)
	queue_free()
	
	parent.add_child(load("res://scenes/menu/OptionScreen.tscn").instance())

func _on_Back_mouse_entered():
	$Back.modulate = "ffffff"
	$Back.add_child(pointer)
	selected_menu = 4

func _on_Back_mouse_exited():
	$Back.modulate = "969696"
	if $Back.has_node(pointer.name):
		$Back.remove_child(pointer)
