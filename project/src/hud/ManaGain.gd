extends StaticBody2D

var assistant
var speed = 0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta

func _on_Area2DGain_body_entered(body):
	if body.is_in_group("Player"):
		var mana = assistant.get_mana()
		assistant.set_mana(mana + 1)
		if(mana != assistant.get_mana()):
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

func set_assistant(assistant):
	self.assistant = assistant
