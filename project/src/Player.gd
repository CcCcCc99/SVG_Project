extends Character

onready var anim = $Animator

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	._process(delta)
	# TODO sistemare questo scempio
	anim.animate(get_direction() * speed * delta)

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
