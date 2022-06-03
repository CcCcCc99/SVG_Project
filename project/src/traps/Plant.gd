extends Area2D

export var damage = 3

func _on_Plant_area_entered(area):
	$AnimatedSprite.play("", false)
	_on_hit(area)

func _on_Plant_body_entered(body):
	_on_Plant_area_entered(body)

func _on_hit(body):
	if body.is_in_group("Player"):
		body.take_damage(damage)
		
	elif body.is_in_group("Portal"):
		#mangia il portale
		body._spawn_death_effect()
		pass

func _on_AnimatedSprite_animation_finished():
	$Timer.start()

func _on_Timer_timeout():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.stop()
