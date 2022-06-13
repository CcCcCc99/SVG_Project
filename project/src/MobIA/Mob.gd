extends Character
class_name Mob

enum {IDLE, WALK, ATTACK}

var ia_state = WALK
export(bool) var flip = false
export(int) var contact_damage = 1

func _ready():
	if flip:
		scale.x = -1


func _reset_animations():
	._reset_animations()
	if flip:
		scale.x = -1

func _on_collision_environment():
	pass

func _on_BodyChecker_body_entered(body):
	if body.is_in_group("Environment"):
		_on_collision_environment()
	elif body.is_in_group("Player"):
		body.take_damage(contact_damage)
