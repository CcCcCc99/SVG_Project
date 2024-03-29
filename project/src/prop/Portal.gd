extends Area2D
class_name Portal2D

export(PackedScene) var POOF
var effect

export(Array, Color) var colors
var destination: Portal2D = null
var is_receiving: bool = false
var is_sending: bool = false

func _ready():
	effect = POOF.instance()
	effect.connect("animation_finished", self, "_end_effect")

func _physics_process(delta):
	var areas = get_overlapping_areas()
	if areas.has(destination):
		destination = null
		_spawn_death_effect()

func set_color(c: Color):
	modulate = c

func set_destination(portal: Portal2D):
	destination = portal

func _on_Portal_body_entered(body: Node):
	if body.is_in_group("IgnorePortal"):
		return
	elif body.is_in_group("Environment"):
		self._spawn_death_effect()
		if is_instance_valid(destination):
			destination._spawn_death_effect()
	elif is_instance_valid(destination):
		if is_receiving:
			destination.is_sending = false
			is_receiving = false
		else:
			is_sending = true
			destination.is_receiving = true
			body.teleport_to(destination)

func _spawn_death_effect():
	add_child(effect)
	effect.play()

func _end_effect():
	effect.queue_free()
	self.queue_free()
