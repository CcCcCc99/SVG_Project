extends Node2D

var selected_menu = 0

func change_menu_color():
	$NewGame.modulate = "969696"
	$LoadGame.modulate = "969696"
	$Options.modulate = "969696"
	$Quit.modulate = "969696"
	
	match selected_menu:
		0:
			$NewGame.modulate = "ffffff"
			$Pointer.position.y = 180
		1:
			$LoadGame.modulate = "ffffff"
			$Pointer.position.y = 260
		2:
			$Options.modulate = "ffffff"
			$Pointer.position.y = 340
		3:
			$Quit.modulate = "ffffff"
			$Pointer.position.y = 420

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
			selected_menu = 3
		change_menu_color()
	elif Input.is_action_just_pressed("ui_accept"):
		match selected_menu:
			0:
				# New game
				get_tree().change_scene("res://Main.tscn")
			1:
				# Load game
				"""
				var next_level_resource = load("res://Scenes/Main.tscn");
				var next_level = next_level_resource.instance()
				next_level.load_saved_game = true
				get_tree().root.call_deferred("add_child", next_level)
				queue_free()
				"""
				pass
			2:
				# Options
				get_tree().change_scene("res://scenes/menu/OptionScreen.tscn")
			3:
				# Quit game
				get_tree().quit()
