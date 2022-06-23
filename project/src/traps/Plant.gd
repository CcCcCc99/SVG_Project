extends Area2D

export var damage = 3

func _on_Plant_area_entered(area):
	_on_hit(area)

func _on_Plant_body_entered(body):
	_on_Plant_area_entered(body)

func _on_hit(body):
	$AnimatedSprite.animation = "eat"
	$AnimatedSprite.frame = 0
	if body.is_in_group("Character"):
		body.take_damage(damage)
		
	elif body.is_in_group("Portal"):
		#mangia il portale
		body._spawn_death_effect()
		pass

func _on_AnimatedSprite_animation_finished():
	print($AnimatedSprite.animation)
	if $AnimatedSprite.animation == "eat":
		$Timer.start()
		$AnimatedSprite.animation = "back"
	elif $AnimatedSprite.animation == "back":
		$AnimatedSprite.animation = "idle"

func _on_Timer_timeout():
	$AnimatedSprite.stop()
