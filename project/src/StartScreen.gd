extends CenterContainer

var selected_menu = 0
var pointer

func change_menu_color():
	_remove_pointer()
	
	match selected_menu:
		0:
			_on_NewGameButton_mouse_entered()
		1:
			_on_LoadGameButton_mouse_entered()
		2:
			_on_OptionsButton_mouse_entered()
		3:
			_on_QuitButton_mouse_entered()

func _remove_pointer():
	for child in $Menu.get_children():
		if child.has_node(pointer.name):
			child.modulate = "969696"
			child.remove_child(pointer)
			break

func _ready():
	pointer = $Pointer
	remove_child(pointer)

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
				_on_NewGameButton_pressed()
			1:
				# Load game
				_on_LoadGameButton_pressed()
			2:
				# Options
				_on_OptionsButton_pressed()
			3:
				# Quit game
				_on_QuitButton_pressed()

func _on_NewGameButton_pressed():
	var parent = get_parent()
	parent.remove_child(self)
	queue_free()
	
	parent.add_child(load("res://Main.tscn").instance())

func _on_NewGameButton_mouse_entered():
	_remove_pointer()
	$Menu/NewGameButton.modulate = "ffffff"
	$Menu/NewGameButton.add_child(pointer)
	selected_menu = 0

func _on_NewGameButton_mouse_exited():
	$Menu/NewGameButton.modulate = "969696"
	if $Menu/NewGameButton.has_node(pointer.name):
		$Menu/NewGameButton.remove_child(pointer)

func _on_LoadGameButton_pressed():
	var parent = get_parent()
	parent.remove_child(self)
	queue_free()
	
	# load game

func _on_LoadGameButton_mouse_entered():
	_remove_pointer()
	$Menu/LoadGameButton.modulate = "ffffff"
	$Menu/LoadGameButton.add_child(pointer)
	selected_menu = 1

func _on_LoadGameButton_mouse_exited():
	$Menu/LoadGameButton.modulate = "969696"
	if $Menu/LoadGameButton.has_node(pointer.name):
		$Menu/LoadGameButton.remove_child(pointer)

func _on_OptionsButton_pressed():
	var parent = get_parent()
	parent.remove_child(self)
	queue_free()
	
	var options = load("res://scenes/menu/OptionScreen.tscn").instance()
	options.set_back(true)
	parent.add_child(options)

func _on_OptionsButton_mouse_entered():
	_remove_pointer()
	$Menu/OptionsButton.modulate = "ffffff"
	$Menu/OptionsButton.add_child(pointer)
	selected_menu = 2

func _on_OptionsButton_mouse_exited():
	$Menu/OptionsButton.modulate = "969696"
	if $Menu/OptionsButton.has_node(pointer.name):
		$Menu/OptionsButton.remove_child(pointer)

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_QuitButton_mouse_entered():
	_remove_pointer()
	$Menu/QuitButton.modulate = "ffffff"
	$Menu/QuitButton.add_child(pointer)
	selected_menu = 3

func _on_QuitButton_mouse_exited():
	$Menu/QuitButton.modulate = "969696"
	if $Menu/QuitButton.has_node(pointer.name):
		$Menu/QuitButton.remove_child(pointer)
