extends Mob

export(PackedScene) var blow

var direction = Vector2.UP

func get_direction():
	match ia_state:
		WALK:
			$AnimatedSprite.animation = "walk"
			return direction
		ATTACK:
			$AnimatedSprite.animation = "attack"
			return Vector2.ZERO

func _on_collision_environment():
	direction.y *= -1

func _on_TriggerAttack(body):
	if ia_state != ATTACK:
		ia_state = ATTACK
		$Cooldown.start()
		var b = blow.instance()
		if flip:
			b.set_direction(Vector2(1,0))
		else:
			b.set_direction(Vector2(-1,0))
		b.position = $TriggerAttack.global_position - Vector2(30,15)
		get_parent().call_deferred("add_child",b)

func _on_Cooldown_timeout():
	ia_state = WALK
