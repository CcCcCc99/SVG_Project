extends Mob

var direction = Vector2(-1,-1)

func _ready():
	ia_state = IDLE

func get_direction():
	match ia_state:
		ATTACK:
			$AnimatedSprite.animation = "attack"
			return direction
		IDLE:
			$AnimatedSprite.animation = "idle"
			return Vector2.ZERO

func _on_collision_environment():
	direction.x *= -1

func _on_Cooldown_timeout():
	ia_state = IDLE
