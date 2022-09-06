extends CenterContainer
class_name Menu

var selected_menu = 0
var pointer

var is_enabled = true
var stacked_menu: Node

var menu_buttons: Array # da inizializzare nel ready delle classi figlie

var is_just_reactivated = false

func enable():
	is_enabled = true
	is_just_reactivated = true
	$Menu.show()
	if is_instance_valid(stacked_menu):
		stacked_menu.queue_free()

func disable():
	is_enabled = false
	$Menu.hide()

func _ready():
	pointer = $Pointer
	remove_child(pointer)

func _remove_pointer():
	for child in menu_buttons:
		if child.has_node(pointer.name):
			child.modulate = "969696"
			child.remove_child(pointer)
			break

func _on_enter_button_number(num: int):
	var button = menu_buttons[num]
	_remove_pointer()
	button.modulate = "ffffff"
	button.add_child(pointer)
	selected_menu = num

func _on_exited_button_number(num: int):
	var button = menu_buttons[num]
	button.modulate = "969696"
	if button.has_node(pointer.name):
		button.remove_child(pointer)

func change_menu_color():
	_remove_pointer()
	_on_enter_button_number(selected_menu)

func _input(event):
	if is_just_reactivated:
		is_just_reactivated = false
		return
	if not is_enabled:
		return
	if Input.is_action_just_pressed("ui_down"):
		selected_menu = (selected_menu + 1) % menu_buttons.size()
		change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu == 0:
			selected_menu = menu_buttons.size() - 1
		else:
			selected_menu = (selected_menu - 1) % menu_buttons.size()
		change_menu_color()
	elif Input.is_action_just_pressed("ui_accept"):
		_press_button_number(selected_menu)

func _press_button_number(num: int):
	var button = menu_buttons[num]
