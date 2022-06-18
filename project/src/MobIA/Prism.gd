extends Mob

var direction = Vector2.LEFT

export(PackedScene) var jolt

func get_direction():
	match ia_state:
		WALK:
			_walk()
			return direction
		ATTACK:
			$Sprite.hide()
			_laser_attack()
			return Vector2.ZERO

func _on_collision_environment():
	direction.x *= -1
	scale.x *= -1
	ia_state = ATTACK

func _walk():
	i += 0.08
	$Sprite.position.y += sin(i)

func _laser_attack():
	$AttackMode/RayCast2D.play_laser()
	$AttackMode.rotation += 0.07
	if $AttackMode.rotation >= 2*PI:
		ia_state = WALK
		$AttackMode.rotation = 0
		$AttackMode.hide()

"""
func _on_TriggerAttack(body):
	if ia_state != ATTACK:
		ia_state = ATTACK
		$Cooldown.start()
		var j = jolt.instance()
		if flip:
			j.set_direction(Vector2(1,0))
		else:
			j.set_direction(Vector2(-1,0))
		j.position = $TriggerAttack.global_position - Vector2(30,15)
		get_parent().call_deferred("add_child",j)
"""

func _on_Cooldown_timeout():
	ia_state = WALK
