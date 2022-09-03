extends Node2D

func take_damage(damage: int):
	get_character().take_damage(damage)

func incapacitate():
	get_character().incapacitate()

func back_to_normal():
	get_character().back_to_normal()

func get_character():
	if get_parent().is_in_group("Hitbox"):
		return get_parent().get_character()
	return get_parent()
