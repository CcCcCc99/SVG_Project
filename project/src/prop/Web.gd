extends Area2D

var target: Character = null

func _on_Web_body_entered(body):
	$Timer.start()
	if body.is_in_group("Character") and not body.can_fly:
		body.incapacitate()
	target = body

func _on_Timer_timeout():
	if is_instance_valid(target):
		if target.is_in_group("Character"):
			target.back_to_normal()
	target = null
