extends Area2D

var velocity
var tempbody

func _on_Web_body_entered(body):
	$Timer.start()
	tempbody = body
	velocity = body.velocity
	body.velocity = 0

func _on_Timer_timeout():
	tempbody.velocity = velocity
