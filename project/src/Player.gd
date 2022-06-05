extends Character

onready var anim = $Animator

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	._process(delta)
	if Input.is_action_just_pressed("summon"):
		print("summon ", get_viewport().get_mouse_position())
	# TODO sistemare questo scempio
	anim.animate(get_direction() * speed * delta)

func get_direction() -> Vector2:
	# movement
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertcal = Input.get_action_strength("down") - Input.get_action_strength("up")
	return Vector2(horizontal,vertcal).normalized()
