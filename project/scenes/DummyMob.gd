extends Mob

func _on_Cooldown_timeout():
	emit_signal("killed")
	queue_free()
