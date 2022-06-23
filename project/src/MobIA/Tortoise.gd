extends Mob

export var shot_direction: Vector2

var direction = Vector2.UP
var is_returned: bool = true
var previous_position: Vector2

func get_direction():
	match ia_state:
		WALK:
			if not is_returned:
				if ($LittleFriend.position.x < 0 and $LittleFriend.position.y < 0):
					direction = Vector2(-1, -1)
					$LittleFriend.global_position = previous_position
				elif ($LittleFriend.position.x > 0 and $LittleFriend.position.y < 0):
					direction = Vector2(1, -1)
					$LittleFriend.global_position = previous_position
				elif ($LittleFriend.position.x < 0 and $LittleFriend.position.y > 0):
					direction = Vector2(-1, 1)
					$LittleFriend.global_position = previous_position
				elif ($LittleFriend.position.x > 0 and $LittleFriend.position.y > 0):
					direction = Vector2(1, 1)
					$LittleFriend.global_position = previous_position
				if ($LittleFriend.position.x > -130 and $LittleFriend.position.x < 130 and $LittleFriend.position.y > -130 and $LittleFriend.position.y < 90):
					is_returned = true
					$LittleFriend.position = Vector2(10, -185)
					speed = 1000
					direction.x = 0
					direction.y = -direction.y
			$AnimatedSprite.animation = "walk"
			return direction
		IDLE:
			$AnimatedSprite.animation = "idle"
			if $LittleFriend.is_stopped:
				ia_state = WALK
				previous_position = $LittleFriend.global_position
			return Vector2.ZERO

func _on_collision_environment():
	if is_returned:
		direction.y *= -1

func _on_TriggerAttack(body):
	if ia_state != IDLE and is_returned:
		ia_state = IDLE
		$LittleFriend.set_direction(shot_direction)
		$LittleFriend.is_stopped = false
		is_returned = false
		speed = 10000
