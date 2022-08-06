extends Shot

export var push_distance = 8000

var pushed_objs: Dictionary = {}

func _on_hit(body):
	._on_hit(body)
	# push player
	if body.is_in_group("Character"):
		if body.is_in_group("Hitbox"):
			body = body.get_character()
		_push_character(body)

func _push_character(c: Character):
	if not pushed_objs.has(c):
		pushed_objs[c] = 0
		c.incapacitate()

func _release_character(c: Character):
	pushed_objs.erase(c)
	c.back_to_normal()
	c.alt_velocity = Vector2.ZERO

func _process(delta):
	if not pushed_objs.empty():
		var push_speed = speed + 1000
		var characters = pushed_objs.keys()
		for c in characters:
			if is_instance_valid(c):
				c.alt_velocity = direction * push_speed * 20
				pushed_objs[c] += direction.x * push_speed * 20 * delta
				if abs(pushed_objs[c]) >= push_distance*1000:
					_release_character(c)
	
