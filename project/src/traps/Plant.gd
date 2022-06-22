extends Area2D

export var damage = 3

var body

func _on_Plant_area_entered(area):
	if $Timer.time_left == 0:
		_on_hit(area)

func _on_hit(area):
	if not area.is_in_group("Environment"):
		if $AnimatedSprite.animation == "idle":
			$AnimatedSprite.animation = "eat"
			$AnimatedSprite.frame = 0
			
			body = area

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "eat":
		$Timer.start()
		$AnimatedSprite.animation = "back"
		
		if is_instance_valid(body):
			if body.is_in_group("Character"):
				body.take_damage(damage)
			elif body.is_in_group("Portal"):
				#mangia il portale
				body._spawn_death_effect()
	elif $AnimatedSprite.animation == "back":
		$AnimatedSprite.animation = "idle"

func _on_Timer_timeout():
	pass
	#var min_pos_x = $CollisionShape2D.global_position.x - $CollisionShape2D.shape.extents.x
	#var max_pos_x = $CollisionShape2D.global_position.x + $CollisionShape2D.shape.extents.x
	#var min_pos_y = $CollisionShape2D.global_position.y - $CollisionShape2D.shape.extents.y
	#var max_pos_y = $CollisionShape2D.global_position.y + $CollisionShape2D.shape.extents.y
	#
	#if is_instance_valid(body):
		#if (body.global_position.x >= min_pos_x) and (body.global_position.x <= max_pos_x) and (body.global_position.y >= min_pos_y) and (body.global_position.y <= max_pos_y):
			#_on_Plant_area_entered(body)
		#else:
			#body = null
