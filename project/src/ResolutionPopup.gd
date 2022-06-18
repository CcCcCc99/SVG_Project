extends Node2D

var selected_menu = 0

func change_menu_color():
	$Res1024x546.modulate = "969696"
	$Res1280x720.modulate = "969696"
	$Res1600x900.modulate = "969696"
	$Res1920x1080.modulate = "969696"
	$Back.modulate = "969696"
	
	match selected_menu:
		0:
			$Res1024x546.modulate = "ffffff"
			$Pointer.position = Vector2(400,140)
		1:
			$Res1280x720.modulate = "ffffff"
			$Pointer.position = Vector2(690,140)
		2:
			$Res1600x900.modulate = "ffffff"
			$Pointer.position = Vector2(400,340)
		3:
			$Res1920x1080.modulate = "ffffff"
			$Pointer.position = Vector2(690,340)
		4:
			$Back.modulate = "ffffff"
			$Pointer.position = Vector2(500,500)

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
				OS.set_window_size(Vector2(1024,546))
			1:
				OS.set_window_size(Vector2(1280,720))
			2:
				OS.set_window_size(Vector2(1600,900))
			3:
				OS.set_window_size(Vector2(1920,1080))
			4:
				get_tree().change_scene("res://scenes/menu/OptionScreen.tscn")
