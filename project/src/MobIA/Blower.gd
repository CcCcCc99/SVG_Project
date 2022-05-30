extends Mob

enum {IDLE, WALK, ATTACK}

var ia_state = WALK
export(PackedScene) var blow


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_direction():
	match ia_state:
		WALK:
			$AnimatedSprite.animation = "walk"
			return Vector2.UP
		ATTACK:
			$AnimatedSprite.animation = "attack"
			return Vector2.ZERO	


func _on_TriggerAttack(body):
	if ia_state != ATTACK:
		ia_state = ATTACK
		var b = blow.instance()
		b.set_direction(-1)
		b.position = $TriggerAttack.global_position - Vector2(30,15)
		get_parent().add_child(b)
