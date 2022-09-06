extends Area2D

export var cooldown: int = 5

func _ready():
	$Timer.wait_time = cooldown
	_on_AnimatedSprite_animation_finished()

func _on_Timer_timeout():
	$AnimatedSprite.play("starfall")

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	$Timer.start()
