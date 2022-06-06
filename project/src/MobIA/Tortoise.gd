extends Mob

var direction = Vector2.UP

func get_direction():
	match ia_state:
		WALK:
			$AnimatedSprite.animation = "walk"
			return direction
		IDLE:
			$AnimatedSprite.animation = "idle"
			return Vector2.ZERO

func _on_collision_environment():
	direction.y *= -1

func _on_TriggerAttack(body):
	if ia_state != IDLE:
		ia_state = IDLE
		$Cooldown.start()
		$LittleFriend.ia_state = ATTACK

func _on_Cooldown_timeout():
	ia_state = WALK
