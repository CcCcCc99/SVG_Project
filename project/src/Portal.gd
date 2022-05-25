extends Area2D
class_name Portal2D

const POOF: PackedScene = preload("res://scenes/Poof.tscn")
var effect

export(Array, Color) var colors
var destination = null
var is_reciving = false

func _ready():
	effect = POOF.instance()
	effect.connect("animation_finished", self, "_end_effect")

#func _process(delta):
#	var areas = get_overlapping_areas()
#	for a in areas:
#		if a is Portal2D:
#			a._spawn_death_effect()
#	var bodies = get_overlapping_bodies()
#	for b in bodies:
#		var velocity = Vector2( 
#			move_toward(b.position.x, self.position.x, delta), 
#			move_toward(b.position.y, self.position.y, delta) )
#		b.move_and_slide(velocity)

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
