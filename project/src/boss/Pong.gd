extends Mob

export var jump_speed = 20000
export var landing_damage = 7
export var aoe_damage = 3

enum {normal = 0, jumping  = 1, out_of_screen = 2, landing  = 3}
var jumping_state = normal

var sprite_offset
var original_contact_damage
var player

func _ready():
	sprite_offset = $AnimatedSprite.position.y
	player = get_parent().get_node("Player")

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		$AnimatedSprite.animation = "jump_up"

func _physics_process(delta):
	._physics_process(delta)
	if jumping_state == jumping:
		jump(delta)
	elif jumping_state == landing:
		land(delta)

func get_direction() -> Vector2:
	if jumping_state == out_of_screen:
		return position.direction_to(player.position)
	return Vector2.ZERO

func take_damage(damage):
	if jumping_state == normal:
		.take_damage(damage)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "jump_up":
		jumping_state = jumping
	elif $AnimatedSprite.animation == "jump_down":
		jumping_state = normal
		contact_damage = original_contact_damage
		$CollisionShape2D.disabled = false

func _on_Cooldown_timeout():
	jumping_state = landing

func jump(delta):
	$CollisionShape2D.disabled = true
	$BodyChecker/CollisionShape2D.position.y -= jump_speed * delta
	$AnimatedSprite.position.y -= jump_speed * delta
	if $AnimatedSprite.position.y < -2000:
		jumping_state = out_of_screen
		$Cooldown.start()

func land(delta):
	contact_damage = landing_damage
	$BodyChecker/CollisionShape2D.position.y += jump_speed * delta
	$AnimatedSprite.position.y += jump_speed * delta
	if $AnimatedSprite.position.y > sprite_offset:
		$AnimatedSprite.position.y = sprite_offset
		$AnimatedSprite.animation = "jump_down"


