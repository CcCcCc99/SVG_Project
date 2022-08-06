extends Mob

export var direction: Vector2
var last_env: Node
var prev_dir: Vector2

func _ready():
	prev_dir = direction
	if direction.x > 0:
		scale.x *= -1

func get_direction() -> Vector2:
	var dir
	match ia_state:
		WALK:
			_walk()
			dir = direction
		ATTACK:
			_tornado_attack()
			dir = _follow_player()
	if prev_dir.x != dir.x:
		scale.x *= -1
		prev_dir = dir
	return dir

func _on_BodyChecker_body_entered(body):
	._on_BodyChecker_body_entered(body)
	last_env = body

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

func _walk():
	$AnimatedSprite.show()
	$Shadow.show()
	$FallenMode.hide()
	$FallenShadow.hide()
	i += 0.08
	$AnimatedSprite.position.y += sin(i)

func _tornado_attack():
	$AnimatedSprite.hide()
	$Shadow.hide()
	$FallenMode.show()
	$FallenShadow.show()

func _follow_player() -> Vector2:
	return Vector2.ZERO
