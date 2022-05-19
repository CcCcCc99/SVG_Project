extends KinematicBody2D

export var speed = 20000

onready var anim = $Animator

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# movement
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertcal = Input.get_action_strength("down") - Input.get_action_strength("up")
	var velocity = Vector2(horizontal,vertcal).normalized()*speed
	# warning-ignore:return_value_discarded
	move_and_slide(velocity * delta)
	if Input.is_action_just_pressed("summon"):
		print("summon ", get_viewport().get_mouse_position())
	anim.animate(velocity)
