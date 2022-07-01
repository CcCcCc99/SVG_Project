extends RigidBody2D

export var decelleration = Vector2(0.5, 0.5)
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	print(linear_velocity)
	if linear_velocity > Vector2.ZERO:
		linear_velocity -= decelleration
		if linear_velocity <= Vector2.ZERO:
			linear_velocity = Vector2.ZERO

func _on_Area2DGain_body_entered(body):
	if body.is_in_group("Player"):
		var hp = body.get_hp()
		body.set_hp(body.get_hp() + 2)
		if (hp != body.get_hp()):
			self.queue_free()

