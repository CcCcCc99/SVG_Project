extends Node2D

func _on_Lever_used():
	var pink = get_parent().get_node("LeverPink").is_on
	var green = get_parent().get_node("LeverGreen").is_on
	print("pink: ", pink, " green: ", green)
	if (pink and green):
		$AnimatedSprite.animation = "mix"
	elif (pink and (not green)):
		$AnimatedSprite.animation = "pink"
	elif ((not pink) and green):
		$AnimatedSprite.animation = "green"
	else:
		$AnimatedSprite.animation = "empty"
