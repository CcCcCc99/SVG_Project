extends Shot

export var correction: float

func _ready():
	direction = Vector2(-10,-1).normalized()

func _physics_process(delta):
	if state == SCALEDOWN:
		_scale_down()
	elif state == SCALEUP:
		_scale_up()
	else:
		position += direction * speed * delta
		direction.y -= correction
		
		print(direction)
