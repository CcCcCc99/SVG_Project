extends Area2D

export var damage = 3

var objects_detected: Array

func _on_detect(object):
	if $Timer.time_left == 0:
		if object.is_in_group("Character"):
			get_node("/root/AudioManager").add_effect("res://assets/audio/wolf_monster.mp3", 0.0, 1.5, false)
			if $AnimatedSprite.animation == "idle":
				$AnimatedSprite.animation = "eat"
				
			if not objects_detected.has(object):
				objects_detected.append(object)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "eat":
		$Timer.start()
		$AnimatedSprite.animation = "back"
		
		for object in objects_detected:
			if is_instance_valid(object):
				var found1 = false
				for area in  get_overlapping_areas():
					if object == area:
						found1 = true
						break
				var found2 = false
				
				for body in  get_overlapping_bodies():
					if object == body:
						found2 = true
						break
				
				if found1 or found2:
					if object.is_in_group("Character"):
						object.take_damage(damage)
					elif object.is_in_group("Portal"):
						# mangia il portale
						object._spawn_death_effect()
		
		objects_detected.clear()
	elif $AnimatedSprite.animation == "back":
		$AnimatedSprite.animation = "idle"

func _on_Timer_timeout():
	var areas = get_overlapping_areas()
	var bodies = get_overlapping_bodies()
	areas.append_array(bodies)
	
	if areas.size() != 0:
		for object in areas:
			if object.is_in_group("Character") or object.is_in_group("Portal"):
				_on_detect(object)
