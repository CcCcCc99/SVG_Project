extends Mob

export var direction: Vector2
export var knock_back: float = 5
var last_env: Node
var prev_dir: Vector2
var target: Character = null

func _ready():
	prev_dir = direction
	if direction.x > 0:
		scale.x *= -1

func get_direction() -> Vector2:
	var dir
	match ia_state:
		IDLE:
			dir = Vector2.ZERO
		WALK:
			_walk()
			dir = direction
		ATTACK:
			dir = _follow_player()
	if (prev_dir.x > 0 and dir.x < 0) or (prev_dir.x < 0 and dir.x > 0):
		scale.x *= -1
		prev_dir = dir
	return dir

func _on_BodyChecker_body_entered(body):
	last_env = body
	if body.is_in_group("Character") and not body.is_in_group("Hitbox") and body != self:
		ia_state = IDLE
		_fall()
	._on_BodyChecker_body_entered(body)

func _on_collision_environment():
	if last_env.is_in_group("VerticalEnvironment"):
		_bounce(false)
	elif last_env.is_in_group("HorizontalEnvironment"):
		_bounce(true)

func _bounce(horizontal):
	if horizontal:
		direction.x *= -1
	else:
		direction.y *= -1

func _fall():
	$AnimatedSprite.hide()
	$Shadow.hide()
	$FallenMode.show()
	$FallenShadow.show()
	$Fall_AnimationPlayer.play("FallBack")

func _walk():
	$AnimatedSprite.show()
	$Shadow.show()
	$FallenMode.hide()
	$FallenShadow.hide()
	i += 0.08
	$AnimatedSprite.position.y += sin(i)

func _follow_player() -> Vector2:
	return position.direction_to(target.position)

func _on_TriggerAttack_enemy_spotted(body):
	ia_state = ATTACK
	$AnimatedSprite.animation = "spin"
	if body.is_in_group("Hitbox"):
		target = body.get_character()
	else:
		target = body
