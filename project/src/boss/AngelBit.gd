extends Mob

var initial_body_pos: Vector2
export var fly: PackedScene
export var fly_number: int
var count: int = 0

func _ready():
	$WingsAnimator.play("Wings")
	initial_body_pos = $Body.position

func _process(delta):
	if Input.is_action_just_pressed("debug1"):
		j = 0
		ia_state = ATTACK
		$Cooldown.start()
	if Input.is_action_just_pressed("debug2"):
		$Body.position = initial_body_pos
		ia_state = WALK

func get_direction():
	match ia_state:
		WALK:
			_walk()
			return Vector2.ZERO
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
	f.position = $Body/Position2D.global_position
	if scale.x == -1:
		f.set_direction(Vector2.RIGHT)
	else:
		f.set_direction(Vector2.LEFT)
	get_parent().add_child(f)

func _on_Cooldown_timeout():
	_spawn_fly()
	count += 1
	if count >= 5:
		ia_state = WALK
		$Body.position = initial_body_pos
		count = 0
		$Cooldown.stop()
