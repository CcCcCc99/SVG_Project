extends Node2D

export (String) var leverpinkname
export (String) var levergreenname

var water: Node
var empty: Node

func _on_Lever_used():
	var pink = get_parent().get_node("Lever" + leverpinkname).is_on
	var green = get_parent().get_node("Lever" + levergreenname).is_on
	if pink:
		if green:
			$AnimatedSprite.animation = "mix"
			if not is_instance_valid(water):
				water = get_node("/root/AudioManager").add_effect("res://assets/audio/41302686_bathroom-sink-filling-with-water-01.mp3", 0.0, 1.0, true)
		else:
			$AnimatedSprite.animation = "pink"
			if is_instance_valid(empty):
				empty.end_effect()
			if not is_instance_valid(water):
				water = get_node("/root/AudioManager").add_effect("res://assets/audio/41302686_bathroom-sink-filling-with-water-01.mp3", 0.0, 1.0, true)
	else:
		if green:
			$AnimatedSprite.animation = "green"
			if is_instance_valid(empty):
				empty.end_effect()
			if not is_instance_valid(water):
				water = get_node("/root/AudioManager").add_effect("res://assets/audio/41302686_bathroom-sink-filling-with-water-01.mp3", 0.0, 1.0, true)
		else:
			$AnimatedSprite.animation = "empty"
			water.end_effect()
			empty = get_node("/root/AudioManager").add_effect("res://assets/audio/43011276_water-sink-drain-emptying-01.mp3", -3.0, 1.5, false)
