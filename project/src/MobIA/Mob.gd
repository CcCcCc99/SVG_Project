extends Character
class_name Mob

enum {IDLE, WALK, ATTACK}

var ia_state = WALK
export(bool) var flip = false

func _ready():
	if flip:
		scale.x = -1

func _physics_process(delta):
	._physics_process(delta)
	_check_collision()

func _check_collision():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Environment"):
			_on_collision_environment()

func _reset_animations():
	._reset_animations()
	if flip:
		scale.x = -1

func _on_collision_environment():
	pass
