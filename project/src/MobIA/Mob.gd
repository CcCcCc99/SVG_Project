extends Character
class_name Mob

enum {IDLE, WALK, ATTACK}
var j: float = 0

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
		add_to_group("PlayerAlly")
		max_hp *= 2
		set_hp(max_hp)
		get_node("/root/AudioManager").add_effect("res://assets/audio/43133969_cartoon-whoosh-zap-sweep-01.mp3", -5.0, 1.75, false)
		if has_node("TriggerAttack"):
			$TriggerAttack.enemy = "Mob"
	else:
		enemy = "PlayerAlly"

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
		scale.y = 1

func _on_collision_environment():
	pass

func _on_BodyChecker_body_entered(body):
	if body.is_in_group("Environment") and body.name != "PoralBracker":
		_on_collision_environment()
	elif body.is_in_group(enemy) and not body.is_in_group("Hitbox"):
		if body != self:
			body.take_damage(contact_damage)
