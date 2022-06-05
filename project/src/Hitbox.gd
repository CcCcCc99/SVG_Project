extends Area2D

func take_damage(damage: int):
	get_parent().take_damage(damage)

func incapacitate():
	get_parent().incapacitate()

func back_to_normal():
	get_parent().back_to_normal()

func get_character():
	return get_parent()
