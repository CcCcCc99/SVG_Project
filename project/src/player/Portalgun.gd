extends Node2D

export var distance = 50
export(PackedScene) var portal
export(Array, Color) var colors

var last_portal = null
var previous_portal = null
var portal_number = 0

func _ready():
	$ForewardRay.add_exception(get_parent())
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
	if $ForewardRay.is_colliding():
		var coll = $ForewardRay.get_collider()
		if coll.is_in_group("PortalBracker"):
			return
	
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
	
	if is_instance_valid(previous_portal):
		for area in previous_portal.get_overlapping_areas():
			if area.is_in_group("Shot") or area.is_in_group("Assistant"):
				previous_portal._on_Portal_body_entered(area)
		for body in previous_portal.get_overlapping_bodies():
			previous_portal._on_Portal_body_entered(body)
	
	_update_bracelet()

func destroy_all():
	if is_instance_valid(previous_portal):
		previous_portal.queue_free()
	if is_instance_valid(last_portal):
		last_portal.queue_free()
