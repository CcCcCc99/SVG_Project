extends Mob

var initial_body_pos: Vector2
export var energy_ball: PackedScene
export var fly: PackedScene
export var fly_number: int
var fly_array: Array

var count: int = 0
var energy_array: Array
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
			if ($Node2D/RayCast2D.get_collider() == player and not in_rage) or in_rage:
				return position.direction_to(player.position)
			else:
				return Vector2.ZERO
		WALK:
			_walk()
			return -position.direction_to(player.position)
		ATTACK:
			if not in_rage:
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
	if in_rage:
		_shoot(count)
	else:
		_spawn_fly()
		var effect_fly = get_node("/root/AudioManager").add_effect("res://assets/audio/Laser 1.mp3", -17.5, 1.5, true)
		fly_array.append(effect_fly)
	count += 1
	
	if count >= 8 and in_rage:
		count = 0
		ia_state = IDLE
		$AttackTimer.stop()
	elif count >= 5 and not in_rage:
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
	if ia_state == ATTACK:
		return
	if body == player and first_spot:
		j = 0
		ia_state = ATTACK
		$AttackTimer.start()
		if in_rage:
			$AttackTimer.wait_time = 0.6
			_spawn_energy()
	else:
		first_spot = true

func rage():
	speed *= 2.3
	modulate = Color.red
	in_rage = true

func _spawn_energy():
	var points = $SpawnPoints.get_children()
	energy_array.clear()
	for p in points:
		var eb = energy_ball.instance()
		eb.position = p.global_position
		energy_array.append(eb)
		get_parent().add_child(eb)

func _shoot(i: int):
	if is_instance_valid(energy_array[i]):
		var dir = energy_array[i].position.direction_to(player.position)
		energy_array[i].set_direction(dir)
		energy_array[i].speed = 1000

func _end_effect():
	for eb in energy_array:
		if is_instance_valid(eb):
			eb.queue_free()
	._end_effect()
