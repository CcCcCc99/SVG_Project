extends CenterContainer
class_name Menu

var selected_menu = 0
var pointer

var is_enabled = true
var stacked_menu: Node

func enable():
	is_enabled = true
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
	for child in $Menu.get_children():
		if child.has_node(pointer.name):
			child.modulate = "969696"
			child.remove_child(pointer)
			break
