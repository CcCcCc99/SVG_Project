extends Lever

export var on_color: Color
export var off_color: Color
export var line_name: String


func _activate():
	var line = line_name + "Line"
	get_parent().get_node(line).default_color = on_color
	var container = "FluidContainer" + line_name + "/AnimatedSprite"
	get_parent().get_node(container).speed_scale = 4

func _deactivate():
	var line = line_name + "Line"
	get_parent().get_node(line).default_color = off_color
	var container = "FluidContainer" + line_name + "/AnimatedSprite"
	get_parent().get_node(container).speed_scale = 1
