extends Lever

export var on_color: Color
export var off_color: Color
export var line_name: String

var bubbles: Node

func _activate():
	var line = line_name + "Line"
	get_parent().get_node(line).default_color = on_color
	var container = "FluidContainer" + line_name + "/AnimatedSprite"
	get_parent().get_node(container).speed_scale = 4
	bubbles = get_node("/root/AudioManager").add_effect("res://assets/audio/43132658_cartoon-bubbles-bubbling-water-01.mp3", 0.0, 1.0, true)

func _deactivate():
	var line = line_name + "Line"
	get_parent().get_node(line).default_color = off_color
	var container = "FluidContainer" + line_name + "/AnimatedSprite"
	get_parent().get_node(container).speed_scale = 1
	bubbles.end_effect()
