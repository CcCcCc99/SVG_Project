extends CenterContainer

var selected_menu = 0
var pointer

func change_menu_color():
	_on_ResumeButton_mouse_exited()
	_on_OptionsButton_mouse_exited()
	_on_BackToTitleButton_mouse_exited()
	
	match selected_menu:
		0:
			_on_ResumeButton_mouse_entered()
		1:
			_on_OptionsButton_mouse_entered()
		2:
			_on_BackToTitleButton_mouse_entered()

func _ready():
	pointer = $Pointer
	remove_child(pointer)

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % 3;
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
				# Resume game
				_on_ResumeButton_pressed()
			1:
				# Options
				_on_OptionsButton_pressed()
			2:
				# Back to title
				_on_BackToTitleButton_pressed()

func _on_ResumeButton_pressed():
	var parent = get_parent()
	parent.remove_child(self)
	queue_free()

func _on_ResumeButton_mouse_entered():
	$Menu/ResumeButton.modulate = "ffffff"
	$Menu/ResumeButton.add_child(pointer)
	selected_menu = 0

func _on_ResumeButton_mouse_exited():
	$Menu/ResumeButton.modulate = "969696"
	if $Menu/ResumeButton.has_node(pointer.name):
		$Menu/ResumeButton.remove_child(pointer)

func _on_OptionsButton_pressed():
	var parent = get_parent()
	parent.remove_child(self)
	queue_free()
	
	var options = load("res://scenes/menu/OptionScreen.tscn").instance()
	options.set_back(false)
	parent.add_child(options)

func _on_OptionsButton_mouse_entered():
	$Menu/OptionsButton.modulate = "ffffff"
	$Menu/OptionsButton.add_child(pointer)
	selected_menu = 1

func _on_OptionsButton_mouse_exited():
	$Menu/OptionsButton.modulate = "969696"
	if $Menu/OptionsButton.has_node(pointer.name):
		$Menu/OptionsButton.remove_child(pointer)

func _on_BackToTitleButton_pressed():
	var parent = get_parent()
	parent.remove_child(self)
	queue_free()
	
	parent.add_child(load("res://scenes/menu/StartScreen.tscn").instance())

func _on_BackToTitleButton_mouse_entered():
	$Menu/BackToTitleButton.modulate = "ffffff"
	$Menu/BackToTitleButton.add_child(pointer)
	selected_menu = 2

func _on_BackToTitleButton_mouse_exited():
	$Menu/BackToTitleButton.modulate = "969696"
	if $Menu/BackToTitleButton.has_node(pointer.name):
		$Menu/BackToTitleButton.remove_child(pointer)
