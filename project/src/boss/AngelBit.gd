extends Mob

var initial_body_pos: Vector2
export var fly: PackedScene
export var fly_number: int

var count: int = 0
var player

var last_flip: bool
var first_spot: bool = false
var in_rage: bool = false

func _ready():
	last_flip = flip
	ia_state = IDLE
	player = get_parent().get_parent().get_parent().player
	$WingsAnimator.play("Wings")
	initial_body_pos = $Body.position

func _process(delta):
	if Input.is_action_just_pressed("debug1"):
		j = 0
		ia_state = ATTACK
		$AttackTimer.start()
	if Input.is_action_just_pressed("debug2"):
		$Body.position = initial_body_pos
		ia_state = WALK

func _physics_process(delta):
	._physics_process(delta)

	flip = position.x < player.position.x
	if flip != last_flip:
		last_flip = flip
		scale.x *= -1

	$Node2D.look_at(player.global_position)

func get_direction():
	match ia_state:
		IDLE: 
			_walk()
			if $Node2D/RayCast2D.get_collider() == player:
				return position.direction_to(player.position)
			else:
				return Vector2.ZERO
		WALK:
			_walk()
			return -position.direction_to(player.position)
		ATTACK:
			_open_door()
			return Vector2.ZERO

func _walk():
	$Body/AnimatedSprite.animation = "idle"
	j += 0.038
	$Body.position.y += sin(j) * 1.5

func  _open_door():
	$Body/AnimatedSprite.animation = "attack"
	j += 0.02
	$Body.position.y += j

func _spawn_fly():
	var f = fly.instance()
	f.position = $Body/SpawnPoint.global_position
	if flip:
		f.set_direction(Vector2.RIGHT)
	else:
		f.set_direction(Vector2.LEFT)
	f.target = player
	get_parent().add_child(f)

func _on_AttackTimer_timeout():
	_spawn_fly()
	count += 1
	if count >= 5:
		$Body.position = initial_body_pos
		ia_state = WALK
		$Body.position = initial_body_pos
		count = 0
		$AttackTimer.stop()
		$Cooldown.start()


func _on_Cooldown_timeout():
	$Body.position = initial_body_pos
	ia_state = IDLE

func _on_TriggerAttack_enemy_spotted(body):
	if body == player and first_spot:
		j = 0
		ia_state = ATTACK
		$AttackTimer.start()
	else:
		first_spot = true

func rage():
	speed *= 2.5
	modulate = Color.red
	in_rage = true
