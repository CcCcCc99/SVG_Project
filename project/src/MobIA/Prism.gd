extends Mob

var direction = Vector2.LEFT
export var laser_dmg = 2

export(PackedScene) var raycast

func _ready():
	$AttackMode/Icon.material = $AnimatedSprite.material

func get_direction():
	match ia_state:
		WALK:
			_walk()
			return direction
		ATTACK:
			_laser_attack()
			return Vector2.ZERO

func _on_collision_environment():
	direction.x *= -1
	scale.x *= -1
	ia_state = ATTACK
	get_node("/root/AudioManager").add_effect("res://assets/audio/39725687_laser-scan-01.mp3", 12.5, 2.5, false)

func _walk():
	$AnimatedSprite.show()
	$AttackMode.hide()
	j += 0.08
	$AnimatedSprite.position.y += sin(j)

func _laser_attack():
	$AttackMode.show()
	$AnimatedSprite.hide()
	$AttackMode/RayCast2D.play_laser()
	$AttackMode.rotation += 0.05
	if $AttackMode.rotation >= 2*PI:
		ia_state = WALK
		$AttackMode.rotation = 0

func _on_hit(body):
	if body.is_in_group("Hitbox"):
		body = body.get_character()
	if body.is_in_group("Character") and body != self:
		body.take_damage(laser_dmg)
