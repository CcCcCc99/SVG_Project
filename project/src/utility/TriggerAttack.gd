extends Area2D

var enemy = "Player"

signal enemy_spotted(body)

func _on_TriggerAttack_body_entered(body):
	if (body.is_in_group("Character")):
		emit_signal("enemy_spotted", body)
