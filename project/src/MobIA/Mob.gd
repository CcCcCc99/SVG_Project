extends Character
class_name Mob

enum {IDLE, WALK, ATTACK}

var ia_state = WALK
export(bool) var flip = false
export(int) var contact_damage = 1
export(Texture) var icon
export var is_summoned: bool = false
var enemy: String

signal killed

func _ready():
	if flip:
		scale.x = -1
	if is_summoned:
		enemy = "Mob"
	else:
		enemy = "Player"

func _end_effect():
	emit_signal("killed")
	._end_effect()

func _spawn_corpse():
	if not is_summoned:
		._spawn_corpse()

func _reset_animations():
	._reset_animations()
	if flip:
		scale.x = -1

func _on_collision_environment():
	pass

func _on_BodyChecker_body_entered(body):
	if body.is_in_group("Environment"):
		_on_collision_environment()
	elif body.is_in_group(enemy):
		if body != self:
			body.take_damage(contact_damage)
