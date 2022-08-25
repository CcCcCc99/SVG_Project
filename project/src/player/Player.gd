extends Character

var checkpoint_position: Vector2 = Vector2(0, 0)
var checkpoint_room: int = 0

signal hp_changed(old_hp, new_hp)
signal is_dead(room)

func _process(delta):
	# TODO sistemare questo scempio
	var animation
	var dir = get_direction()
	if dir.x > 0:
		animation = "walk_right"
	elif dir.x < 0:
		animation = "walk_left"
	elif dir.y != 0:
		if dir.y > 0:
			animation = "walk_down"
		else:
			animation = "walk_up"
	else: 
		animation = "idle"
	$AnimatedSprite.animation = animation

func set_hp(new_hp: int):
	var old_hp = get_hp()
	if old_hp != new_hp:
		.set_hp(new_hp)
		emit_signal("hp_changed", old_hp, get_hp())

func set_max_hp(new_max_hp: int):
	max_hp = new_max_hp
	set_hp(new_max_hp)

func _end_effect():
	effect.queue_free()
	_spawn_corpse()
	effect = POOF.instance()
	effect.connect("animation_finished", self, "_end_effect")
	destroy_portals()
	emit_signal("is_dead", checkpoint_room)

func get_direction() -> Vector2:
	# movement
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertcal = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(horizontal,vertcal).normalized()

func destroy_portals():
	$Portalgun.destroy_all()
