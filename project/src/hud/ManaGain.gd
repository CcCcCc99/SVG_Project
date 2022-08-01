extends RigidBody2D

var assistant
export var decelleration = Vector2(0.5, 0.5)
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	if linear_velocity > Vector2.ZERO:
		linear_velocity -= decelleration
		if linear_velocity <= Vector2.ZERO:
			linear_velocity = Vector2.ZERO

func _on_Area2DGain_body_entered(body):
	if body.is_in_group("Player"):
		var mana = assistant.get_mana()
		assistant.set_mana(mana + 1)
		if(mana != assistant.get_mana()):
			self.queue_free()

func set_assistant(assistant):
	self.assistant = assistant
