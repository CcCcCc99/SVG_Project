extends KinematicBody2D

export var speed = 20000
export var distance = 50

export(PackedScene) var portal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# movement
	var horizontal = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertcal = Input.get_action_strength("down") - Input.get_action_strength("up")
	var velocity = Vector2(horizontal,vertcal).normalized()*speed
	# warning-ignore:return_value_discarded
	move_and_slide(velocity * delta)

	# pointer rotation
	$Arrow.look_at(get_global_mouse_position())
	var angle = $Arrow.transform.get_rotation()
	if angle < 0:
		$Arrow.z_index = -1
	else:
		$Arrow.z_index = 0
	
	# spawn pointer
	var direction = Vector2(cos(angle), sin(angle))
	if Input.is_action_just_pressed("portal"):
		_spawn_portal(direction)
		

var last_portal = null
var previous_portal = null
func _spawn_portal(direction):
	if previous_portal != null:
		previous_portal.queue_free()
	previous_portal = last_portal
	var p = portal.instance()
	p.position = direction*distance + position
	get_parent().add_child(p)
	last_portal = p
