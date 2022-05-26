extends Area2D
class_name Portal2D

const POOF: PackedScene = preload("res://scenes/Poof.tscn")
var effect

export(Array, Color) var colors
var destination: Portal2D = null
var is_reciving: bool = false

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
	if is_reciving:
		is_reciving = false
		body.start_scaling_up()
	elif destination != null:
		destination.is_reciving = true
		body.teleport_to(destination)


func _spawn_death_effect():
	add_child(effect)
	effect.play()

func _end_effect():
	effect.queue_free()
	self.queue_free()
