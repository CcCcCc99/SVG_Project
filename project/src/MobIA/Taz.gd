extends Mob

export var direction: Vector2
export var knock_back: float = 5
var last_env: Node
var prev_dir: Vector2
var target: Character = null

var walk_speed: float
var walk_dmg: int
export var attack_dmg: int
export var attack_speed: float

var is_spinning: bool = false
var spin_effect: Node

func _ready():
	walk_speed = speed
	walk_dmg = contact_damage
	_get_up()
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
		if ia_state == ATTACK:
			is_spinning = false
			if is_instance_valid(spin_effect):
				spin_effect.end_effect()
			body.take_damage(attack_dmg)
		_fall()
		get_node("/root/AudioManager").add_effect("res://assets/audio/43133285_cartoon-impact-bang-04.mp3", -5.0, 1.0, false)
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

func _walk():
	j += 0.08
	$AnimatedSprite.position.y += sin(j)

func _fall():
	ia_state = IDLE
	contact_damage = 0
	$AnimatedSprite.hide()
	$Shadow.hide()
	$FallenMode.show()
	$FallenShadow.show()
	$Fall_AnimationPlayer.play("FallBack")
	$Cooldown.start()
	$TriggerAttack/Raycast.disabled = true
	target = null

func _get_up():
	ia_state = WALK
	speed = walk_speed
	contact_damage = walk_dmg
	$AnimatedSprite.animation = "idle"
	$AnimatedSprite.show()
	$Shadow.show()
	$FallenMode.hide()
	$FallenShadow.hide()
	$TriggerAttack/Raycast.disabled = false

func _follow_player() -> Vector2:
	return position.direction_to(target.position)

func _on_TriggerAttack_enemy_spotted(body):
	if ia_state == IDLE:
		return
	ia_state = ATTACK
	if not is_spinning:
		is_spinning = true
		spin_effect = get_node("/root/AudioManager").add_effect("res://assets/audio/43133577_cartoon-spin-01.mp3", -5.0, 1.0, false)
	speed = attack_speed
	contact_damage = 0
	$AnimatedSprite.animation = "spin"
	if body.is_in_group("Hitbox"):
		target = body.get_character()
	else:
		target = body

func _on_Cooldown_timeout():
	_get_up()
