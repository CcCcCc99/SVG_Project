extends Node2D

export (Array, String) var laser_num
export (Array, String) var neighbors

func checkline():
	for i in laser_num.size():
		var laser = "Laser" + laser_num[i]
		var coil = "Coil" + neighbors[i] + "/AnimatedSprite"
		if $AnimatedSprite.animation == "on" and get_parent().get_node(coil).animation == "on":
			get_parent().get_node(laser).turn_on()
		else:
			get_parent().get_node(laser).turn_off()
