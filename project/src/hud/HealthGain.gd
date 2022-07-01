extends StaticBody2D

var speed = 0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta

func _on_Area2DGain_body_entered(body):
	if body.is_in_group("Player"):
		var hp = body.get_hp()
		body.set_hp(body.get_hp() + 1)
		if (hp != body.get_hp()):
			self.queue_free()


func _on_Area2DPush_body_entered(body):
	if body.is_in_group("Player"):
		speed = 1000
		direction.x = -body.get_direction().x
		direction.y = -body.get_direction().y
	elif body.is_in_group("HorizontalEnvironment"):
		speed -= 100
		direction.x *= -1
	elif body.is_in_group("VerticalEnvironment"):
		speed -= 100
		direction.y *= -1
