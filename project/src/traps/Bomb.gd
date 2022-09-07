extends "res://src/Shot.gd"

export(PackedScene) var POOF

var effect

func _ready():
	effect = POOF.instance()
	effect.connect("animation_finished", self, "_end_effect")
	effect.set_position(Vector2(0, -85))

func _spawn_death_effect():
	if effect.get_parent() != self:
		add_child(effect)
		effect.scale = Vector2(0.8, 0.8)
		effect.set_speed_scale(0.5)
		effect.play()

func _end_effect():
	effect.queue_free()
	self.queue_free()

func _on_Bomb_body_entered(body):
	._on_hit(body)
	if body.is_in_group("Character"):
		_spawn_death_effect()
		get_node("/root/AudioManager").add_effect("res://assets/audio/43132597_cartoon-bomb-explosion-03.mp3", 0.0, 1.0, false)
