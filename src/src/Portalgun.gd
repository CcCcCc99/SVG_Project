extends Node2D

export var distance = 50
export(PackedScene) var portal

var last_portal = null
var previous_portal = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	# pointer rotation
	look_at(get_global_mouse_position())
	var angle = transform.get_rotation()
	if angle < 0:
		z_index = -1
	else:
		z_index = 0
	
	# spawn pointer
	var direction = Vector2(cos(angle), sin(angle))
	if Input.is_action_just_pressed("portal"):
		_spawn_portal(direction)

func _spawn_portal(direction):
	if previous_portal != null:
		previous_portal.queue_free()
	previous_portal = last_portal
	var p = portal.instance()
	p.position = direction*distance + global_position
	get_parent().get_parent().add_child(p)
	last_portal = p
