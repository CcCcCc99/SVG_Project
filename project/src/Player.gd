extends Character

onready var anim = $Animator

signal hp_changed(old_hp, new_hp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	._process(delta)
	if Input.is_action_just_pressed("summon"):
		print("summon ", get_viewport().get_mouse_position())
	# TODO sistemare questo scempio
	anim.animate(get_direction() * speed * delta)

func set_hp(new_hp: int):
	var old_hp = get_hp()
	if old_hp != new_hp:
		.set_hp(new_hp)
		emit_signal("hp_changed", old_hp, get_hp())

func set_max_hp(new_max_hp: int):
	max_hp = new_max_hp
	set_hp(new_max_hp)

func get_direction() -> Vector2:
	# movement
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertcal = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(horizontal,vertcal).normalized()


func _on_Bat_area_entered(area):
	pass # Replace with function body.


func _on_Bat_body_entered(body):
	pass # Replace with function body.


func _on_Bat_ready():
	pass # Replace with function body.
