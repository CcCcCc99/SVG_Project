extends Node2D

var pink: bool = false
var green: bool = false

var water: Node
var empty: Node

func _on_Lever_used():
	pink = get_parent().get_node("LeverPink").is_on
	green = get_parent().get_node("LeverGreen").is_on
	if pink:
		if green:
			$AnimatedSprite.animation = "mix"
			$Smoke.show()
			if not is_instance_valid(water):
				water = get_node("/root/AudioManager").add_effect("res://assets/audio/41302686_bathroom-sink-filling-with-water-01.mp3", 0.0, 1.0, true)
		else:
			$AnimatedSprite.animation = "pink"
			$Smoke.hide()
			if is_instance_valid(empty):
				empty.end_effect()
			if not is_instance_valid(water):
				water = get_node("/root/AudioManager").add_effect("res://assets/audio/41302686_bathroom-sink-filling-with-water-01.mp3", 0.0, 1.0, true)
	else:
		if green:
			$AnimatedSprite.animation = "green"
			$Smoke.hide()
			if is_instance_valid(empty):
				empty.end_effect()
			if not is_instance_valid(water):
				water = get_node("/root/AudioManager").add_effect("res://assets/audio/41302686_bathroom-sink-filling-with-water-01.mp3", 0.0, 1.0, true)
		else:
			$AnimatedSprite.animation = "empty"
			$Smoke.hide()
			water.end_effect()
			empty = get_node("/root/AudioManager").add_effect("res://assets/audio/43011276_water-sink-drain-emptying-01.mp3", -3.0, 1.5, false)

func _on_Area2D_body_entered(body):
	if body.is_in_group("Character"):
		if pink and green:
			body.take_damage(1)
