extends Area2D

var is_setted: bool = false
var checkpoint_room: int

func is_checkpoint_setted() -> bool:
	return is_setted

func set_checkpoint(r: int) -> void:
	checkpoint_room = r
	is_setted = !is_setted

func _on_Checkpoint_body_entered(body):
	if body.is_in_group("Player"):
		body.set_checkpoint(self.position, checkpoint_room)
