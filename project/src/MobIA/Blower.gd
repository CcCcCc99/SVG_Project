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
		ATTACK:
			$AnimatedSprite.animation = "attack"
	return Vector2.UP


func _on_TriggerAttack(body):
	print("Visto")
	var b = blow.instance()
	b.position = $TriggerAttack.global_position
	get_parent().add_child(b)
