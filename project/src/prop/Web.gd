extends Area2D

var target: Character = null

func _on_Web_body_entered(body):
	$Timer.start()
	if body.is_in_group("Character"):
		body.incapacitate()
	target = body

func _on_Timer_timeout():
	if target.is_in_group("Character"):
		target.back_to_normal()
	target = null
