extends Area2D

func take_damage(damage: int):
	get_parent().take_damage(damage)
