extends Mob

export var jump_speed = 20000
export var landing_damage = 7
export var spit: PackedScene
export var earthquake: PackedScene

enum {normal, jumping, out_of_screen, landing, shooting_left, shooting_right}
var jumping_state = normal

var sprite_offset
var original_contact_damage
var player

func _ready():
	original_contact_damage = contact_damage
	sprite_offset = $AnimatedSprite.position.y
	player = get_parent().get_parent().get_parent().player
	$Cooldown.start()

func _physics_process(delta):
	._physics_process(delta)
	match jumping_state:
		jumping:
			jump(delta)
		landing:
			land(delta)

func get_direction() -> Vector2:
	if jumping_state == out_of_screen:
		return position.direction_to(player.position)
	return Vector2.ZERO

func take_damage(damage):
	if jumping_state != out_of_screen:
		.take_damage(damage)

var spit_dir = -1
func _spit():
	if jumping_state == shooting_right:
		spit_dir *= -1
		scale.x *= -1
	$AnimatedSprite.animation = "spit"
	var spits: Array
	for i in 3:
		var sp = spit.instance()
		sp.set_pos_dir($Position2D.global_position, spit_dir, i)
		get_parent().call_deferred("add_child", sp)
		spits.append(sp)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "jump_up":
		jumping_state = jumping
	elif $AnimatedSprite.animation == "jump_down":
		start_earthquake()
		jumping_state = shooting_left
		$Cooldown.start()
		contact_damage = original_contact_damage
		$HitBox/Body.disabled = false
		$CollisionShape2D.disabled = false
		get_parent().crack_floor(position)

func _on_Cooldown_timeout():
	match jumping_state:
		normal:
			$Cooldown.wait_time = 3
			$AnimatedSprite.animation = "jump_up"
		out_of_screen:
			jumping_state = landing
		shooting_left:
			$Cooldown.wait_time = 1
			end_earthquake()
			_spit()
			jumping_state = shooting_right
			$Cooldown.start()
		shooting_right:
			_spit()
			jumping_state = normal
			$AnimatedSprite.animation = "idle"
			$Cooldown.wait_time = 5
			$Cooldown.start()

func jump(delta):
	$HitBox/Body.disabled = true
	$CollisionShape2D.disabled = true
	var displacement = jump_speed * delta
	$BodyChecker.position.y -= displacement
	$AnimatedSprite.position.y -= displacement
	if $AnimatedSprite.position.y < -2000:
		jumping_state = out_of_screen
		$Cooldown.start()

func land(delta):
	contact_damage = landing_damage
	var displacement = jump_speed * delta
	$BodyChecker.position.y += displacement
	$AnimatedSprite.position.y += displacement
	if $AnimatedSprite.position.y > sprite_offset:
		$AnimatedSprite.position.y = sprite_offset
		$AnimatedSprite.animation = "jump_down"
		$BodyChecker.position.y = 0

var current_shock: Node

func start_earthquake():
	current_shock = earthquake.instance()
	current_shock.position = global_position
	get_parent().add_child(current_shock)

func end_earthquake():
	current_shock.queue_free()
