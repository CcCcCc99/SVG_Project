extends Area2D

export var damage = 3

var areas_array: Array

func _on_Plant_area_entered(area):
	if $Timer.time_left == 0:
		_on_hit(area)

func _on_hit(area):
	if not area.is_in_group("Environment"):
		if $AnimatedSprite.animation == "idle":
			$AnimatedSprite.animation = "eat"
			$AnimatedSprite.frame = 0
			
		if not areas_array.has(area):
			areas_array.append(area)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "eat":
		$Timer.start()
		$AnimatedSprite.animation = "back"
		
		for body in areas_array:
			if is_instance_valid(body):
				if body.is_in_group("Character"):
					body.take_damage(damage)
				elif body.is_in_group("Portal"):
					#mangia il portale
					body._spawn_death_effect()
		
		areas_array.clear()
	elif $AnimatedSprite.animation == "back":
		$AnimatedSprite.animation = "idle"

func _on_Timer_timeout():
	var areas = get_overlapping_areas()
	if areas.size() != 0:
		for area in areas:
			if area.is_in_group("Hitbox") or area.is_in_group("Portal"):
				_on_hit(area)
