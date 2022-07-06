extends Node2D

export var distance = 50
export(PackedScene) var portal
export(Array, Color) var colors

var last_portal = null
var previous_portal = null
var portal_number = 0

func _ready():
	_update_bracelet()

func _update_bracelet():
	$bracelet.modulate = colors[portal_number]

# warning-ignore:unused_argument
func _process(delta):
	if not get_parent().is_normal():
		return
	# pointer rotation
	look_at(get_global_mouse_position())
	var angle = transform.get_rotation()
	if angle < 0:
		z_index = -1
	else:
		z_index = 0
	
	# spawn portal
	var direction = Vector2(cos(angle), sin(angle))
	if Input.is_action_just_pressed("portal"):
		_spawn_portal(direction)

func _spawn_portal(direction: Vector2):
	var p = portal.instance()
	p.set_color(colors[portal_number])
	p.position = direction*distance + global_position
	get_parent().get_parent().add_child(p)
	
	if is_instance_valid(previous_portal):
		previous_portal.queue_free()
	previous_portal = last_portal

	portal_number = (portal_number+1) % 2
	p.set_destination(previous_portal)
	if is_instance_valid(previous_portal):
		previous_portal.set_destination(p)
	last_portal = p

	_update_bracelet()

func destroy_all():
	if is_instance_valid(previous_portal):
		previous_portal.queue_free()
	if is_instance_valid(last_portal):
		last_portal.queue_free()
