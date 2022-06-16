extends Mob

var direction = Vector2(-1,-1)
var is_returning: bool = false
var last_position: Vector2 = position

func _ready():
	ia_state = IDLE

func get_direction():
	match ia_state:
		ATTACK:
			$AnimatedSprite.animation = "attack"
			if is_returning:
				if (position.x < 0 and position.y < 0):
					direction = Vector2(1, 1)
				elif (position.x > 0 and position.y < 0):
					direction = Vector2(-1, 1)
				elif (position.x < 0 and position.y > 0):
					direction = Vector2(1, -1)
				elif (position.x > 0 and position.y > 0):
					direction = Vector2(-1, -1)
				if (position.x > -20 and position.x < 20 and position.y > -90 and position.y < 90):
					is_returning = false
					get_parent().is_returned = true
					position = Vector2.ZERO
					direction = Vector2(-1, -1)
					return Vector2.ZERO
			return direction
		IDLE:
			$AnimatedSprite.animation = "idle"
			return Vector2.ZERO

func _on_collision_environment():
	if (get_parent().is_returned):
		get_parent().direction.y *= -1
	else:
		if (position.x > last_position.x - 10 and position.x < last_position.x + 10):
			direction.x *= -1
		last_position = position
		direction.y *= -1

func _on_Cooldown_timeout():
	ia_state = IDLE
