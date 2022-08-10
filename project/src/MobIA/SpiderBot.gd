extends Mob

export(PackedScene) var web

var direction = Vector2.LEFT

func get_direction():
	match ia_state:
		WALK:
			$AnimatedSprite.animation = "walk"
			return _change_direction()
		ATTACK:
			$AnimatedSprite.animation = "attack"
			return Vector2.ZERO

func _change_direction() -> Vector2:
	if direction == Vector2.LEFT and $AnimatedSprite.position.x < -100:
		direction == Vector2.RIGHT
	elif direction == Vector2.RIGHT and $AnimatedSprite.position.x > 100:
		direction == Vector2.LEFT
	return direction

func _on_TriggerAttack_enemy_spotted(body):
	print("Trigger attack")
	if ((is_summoned and body.is_in_group("Mob")) or (not is_summoned and body.is_in_group("Player"))):
		if ia_state != ATTACK:
			ia_state = ATTACK
			$Cooldown.start()
			var w = web.instance()
			if is_summoned:
				w.is_summoned = true
			w.position = $TriggerAttack.global_position + Vector2(30,15)
			get_parent().call_deferred("add_child",w)

func _on_Cooldown_timeout():
	ia_state = WALK
