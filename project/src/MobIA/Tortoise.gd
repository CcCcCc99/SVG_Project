extends Mob

export var shot_direction: Vector2

var direction = Vector2.UP
var is_returned: bool = true

func get_direction():
	match ia_state:
		WALK:
			$AnimatedSprite.animation = "walk"
			return direction
		IDLE:
			$AnimatedSprite.animation = "idle"
			if is_returned:
				ia_state = WALK
				$LittleFriend.ia_state = IDLE
			return Vector2.ZERO

func _on_collision_environment():
	direction.y *= -1

func _on_TriggerAttack(body):
	if ia_state != IDLE:
		ia_state = IDLE
		$Cooldown.start()
		$LittleFirend.set_direction(shot_direction)
		is_returned = false

func _on_Cooldown_timeout():
	$LittleFriend.is_returning = true
