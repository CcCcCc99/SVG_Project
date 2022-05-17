extends KinematicBody2D

export var speed = 20000
export var distance = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertcal = Input.get_action_strength("down") - Input.get_action_strength("up")
	var velocity = Vector2(horizontal,vertcal).normalized()*speed
	$Arrow.look_at(get_global_mouse_position())
	var angle = $Arrow.transform.get_rotation()
	if angle < 0:
		$Arrow.z_index = -1
	else:
		$Arrow.z_index = 0
	var direction = Vector2(cos(angle), sin(angle))
	print(direction*distance)
# warning-ignore:return_value_discarded
	move_and_slide(velocity * delta)
