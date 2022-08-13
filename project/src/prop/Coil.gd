extends Node2D

export var on_color: Color
export var off_color: Color
export (Array, String) var line_num

func checkline(neighbors: Array):
	print(neighbors)
	for i in line_num.size():
		var line = "Line" + line_num[i]
		var coil = "Coil" + neighbors[i] + "/AnimatedSprite"
		print("Line: " + line + " Coil: " + coil + " Self: " + self.name)
		print("CoilState: " + get_parent().get_node(coil).animation + "SelfState: " + $AnimatedSprite.animation)
		if $AnimatedSprite.animation == "on" and get_parent().get_node(coil).animation == "on":
			get_parent().get_node(line).default_color = on_color
		else:
			get_parent().get_node(line).default_color = off_color
		print(get_parent().get_node(line).default_color)
