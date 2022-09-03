extends Area2D

export var enemy = "Player"

signal enemy_spotted(body)

func _on_TriggerAttack_body_entered(body):
	if (body.is_in_group(enemy)):
		emit_signal("enemy_spotted", body)
