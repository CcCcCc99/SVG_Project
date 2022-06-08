extends Mob

var direction = Vector2(-1,-1)
var is_returning: bool = false

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
				if (position.x > -10 and position.x < 10 and position.y > -10 and position.y < 10):
					is_returning = false
					get_parent().is_returned = true
			return direction
		IDLE:
			$AnimatedSprite.animation = "idle"
			return Vector2.ZERO

func _on_collision_environment():
	direction *= -1

func _on_Cooldown_timeout():
	ia_state = IDLE
