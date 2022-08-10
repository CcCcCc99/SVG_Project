extends "res://src/Shot.gd"

export(PackedScene) var POOF

var effect

func _ready():
	effect = POOF.instance()
	effect.connect("animation_finished", self, "_end_effect")

func _spawn_death_effect():
	if effect.get_parent() != self:
		add_child(effect)
		effect.scale = Vector2(0.4, 0.4)
		effect.play()

func _end_effect():
	effect.queue_free()
	self.queue_free()

func _on_Bomb_body_entered(body):
	_on_Bomb_area_entered(body)


func _on_Bomb_area_entered(area):
	if not area.is_in_group("Player"):
		._on_hit(area)
	if area.is_in_group("Character") and not area.is_in_group("Player"):
		_spawn_death_effect()
