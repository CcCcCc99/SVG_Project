extends Lever

export (Array, String) var coil_num

func _activate():
	for x in coil_num:
		var coil = "Coil" + x + "/AnimatedSprite"
		var line = "Coil" + x
		checkcoil(coil, line)

func _deactivate():
	for x in coil_num:
		var coil = "Coil" + x + "/AnimatedSprite"
		var line = "Coil" + x
		checkcoil(coil, line)

func checkcoil(coil: String, line: String):
	if get_parent().get_node(coil).animation == "on":
		get_parent().get_node(coil).animation = "off"
	else:
		get_parent().get_node(coil).animation = "on"
	get_parent().get_node(line).checkline(coil_num)
