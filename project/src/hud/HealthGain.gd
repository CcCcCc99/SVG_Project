extends RigidBody2D
class_name pickupable

export var decelleration = 0.7#Vector2(0.5,0.5)
export var limit = 30
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	if linear_velocity.length() > 0:
		linear_velocity *= decelleration
		if linear_velocity.length() <= limit:
			linear_velocity = Vector2.ZERO

func _on_Area2DGain_body_entered(body):
	if body.is_in_group("Player"):
		var hp = body.get_hp()
		body.set_hp(body.get_hp() + 2)
		if (hp != body.get_hp()):
			self.queue_free()

