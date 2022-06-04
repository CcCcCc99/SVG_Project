extends "res://src/Shot.gd"
export(PackedScene) var POOF
var effect

func _on_Bat_area_entered(area):
	._on_hit(area)
	_spawn_death_effect()

func _on_Bat_body_entered(body):
	_on_Bat_area_entered(body)

func _spawn_death_effect():
	effect.scale = Vector2(0.4,0.4)
	add_child(effect)
	effect.play()

func _end_effect():
	effect.queue_free()
	self.queue_free()

func _ready():
	effect = POOF.instance()
	effect.connect("animation_finished", self, "_end_effect")
