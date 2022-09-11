extends Mob

export(PackedScene) var web

var direction = Vector2.LEFT
var target: Vector2

var web_array: Array
var number_of_webs: int = 0

func _ready():
	ia_state = WALK

func get_direction():
	match ia_state:
		WALK:
			$AnimatedSprite.animation = "walk"
			return _change_direction()
		ATTACK:
			$AnimatedSprite.animation = "attack"
			return Vector2.ZERO

func _change_direction() -> Vector2:
	if direction == Vector2.LEFT and position.x < -730:
		scale.x *= -1
		direction = Vector2.RIGHT
	elif direction == Vector2.RIGHT and position.x > 730:
		scale.x *= -1
		direction = Vector2.LEFT
	return direction

func _spit_web(pos: Vector2):
	var w = web.instance()
	if number_of_webs == 7:
		var first_web = web_array[0]
		web_array.pop_front()
		web_array.push_back(w)
		first_web.queue_free()
	else:
		web_array.push_back(w)
		number_of_webs += 1
	if is_summoned:
		w.is_summoned = true
	w.position = pos
	get_parent().call_deferred("add_child",w)

func _on_TriggerAttack_enemy_spotted(body):
	if ((is_summoned and body.is_in_group("Mob")) or (not is_summoned and body.is_in_group("Player"))):
		if ia_state != ATTACK:
			ia_state = ATTACK
			$Cooldown.start()
			target = body.global_position
			$DummyWeb.show()
			$Tween.interpolate_property($DummyWeb, "scale", Vector2(0.1,0.1), Vector2(1,1), 1, Tween.TRANS_LINEAR)
			$Tween.interpolate_property($DummyWeb, "global_position", global_position, target, 1, Tween.TRANS_LINEAR)
			$Tween.start()

func _on_Cooldown_timeout():
	$DummyWeb.hide()
	_spit_web(target)
	get_node("/root/AudioManager").add_effect("res://assets/audio/43133811_cartoon-whip-light-crack-whoosh-01.mp3", 0.0, 1.5, false)
	ia_state = WALK
