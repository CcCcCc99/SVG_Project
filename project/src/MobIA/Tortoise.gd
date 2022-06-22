extends Mob

export var shot_direction: Vector2

var direction = Vector2.UP
var is_returned: bool = true

func get_direction():
	match ia_state:
		WALK:
			if not is_returned:
				if ($LittleFriend.position.x < 0 and $LittleFriend.position.y < 0):
					direction = Vector2(-1, -1)
				elif ($LittleFriend.position.x > 0 and $LittleFriend.position.y < 0):
					direction = Vector2(1, -1)
				elif ($LittleFriend.position.x < 0 and $LittleFriend.position.y > 0):
					direction = Vector2(-1, 1)
				elif ($LittleFriend.position.x > 0 and $LittleFriend.position.y > 0):
					direction = Vector2(1, 1)
				if ($LittleFriend.position.x > -20 and $LittleFriend.position.x < 20 and $LittleFriend.position.y > -90 and $LittleFriend.position.y < 90):
					is_returned = true
					$LittleFriend.position = Vector2.ZERO
					direction = Vector2.UP
			$AnimatedSprite.animation = "walk"
			return direction
		IDLE:
			$AnimatedSprite.animation = "idle"
			if $LittleFriend.is_stopped:
				ia_state = WALK
			return Vector2.ZERO

func _on_collision_environment():
	direction.y *= -1

func _on_TriggerAttack(body):
	if ia_state != IDLE and is_returned:
		ia_state = IDLE
		$Cooldown.start()
		$LittleFriend.set_direction(shot_direction)
		is_returned = false
