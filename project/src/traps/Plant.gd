extends Area2D

export var damage = 3

var objects_array: Array

func _on_hit(object):
	if $Timer.time_left == 0:
		if not object.is_in_group("Environment"):
			get_node("/root/AudioManager").add_effect("res://assets/audio/wolf_monster.mp3", 0.0, 1.5, false)
			if $AnimatedSprite.animation == "idle":
				$AnimatedSprite.animation = "eat"
				$AnimatedSprite.frame = 0
				
			if not objects_array.has(object):
				objects_array.append(object)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "eat":
		$Timer.start()
		$AnimatedSprite.animation = "back"
		
		for object in objects_array:
			if is_instance_valid(object):
				if object.is_in_group("Character"):
					object.take_damage(damage)
				elif object.is_in_group("Portal"):
					# mangia il portale
					object._spawn_death_effect()
		
		objects_array.clear()
	elif $AnimatedSprite.animation == "back":
		$AnimatedSprite.animation = "idle"

func _on_Timer_timeout():
	var areas = get_overlapping_areas()
	var bodies = get_overlapping_bodies()
	areas.append_array(bodies)
	
	if areas.size() != 0:
		for object in areas:
			if object.is_in_group("Character") or object.is_in_group("Portal"):
				_on_hit(object)
