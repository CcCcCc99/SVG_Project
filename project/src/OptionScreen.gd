extends Node2D

var selected_menu = 0

func change_menu_color():
	$Resolution.modulate = "969696"
	$Volume.modulate = "969696"
	$Back.modulate = "969696"
	
	match selected_menu:
		0:
			#$NewGame.color = Color.greenyellow
			$Resolution.modulate = "ffffff"
			$Pointer.position.y = 230
		1:
			$Volume.modulate = "ffffff"
			$Pointer.position.y = 310
		2:
			$Back.modulate = "ffffff"
			$Pointer.position.y = 390

func _ready():
	change_menu_color()

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 4;
		change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu = selected_menu - 1
		else:
			selected_menu = 2
		change_menu_color()
	elif Input.is_action_just_pressed("ui_accept"):
		match selected_menu:
			0:
				get_tree().change_scene("res://scenes/menu/ResolutionPopup.tscn")
			1:
				# Volume
				"""
				var next_level_resource = load("res://Scenes/Main.tscn");
				var next_level = next_level_resource.instance()
				next_level.load_saved_game = true
				get_tree().root.call_deferred("add_child", next_level)
				queue_free()
				"""
				pass
			2:
				# Back
				get_tree().change_scene("res://scenes/menu/StartScreen.tscn")
