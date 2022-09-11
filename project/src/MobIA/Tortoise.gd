extends Mob

export var shot_direction: Vector2

var direction = Vector2.UP
var is_returned: bool = true
var previous_direction: Vector2 = Vector2.ZERO

var lf

func _ready():
	lf = $LittleFriend

func _process(delta):
	if position.distance_to(lf.position) > 2000:
		lf.position = Vector2(0, 0)

func get_direction():
	match ia_state:
		WALK:
			if not is_returned:
				if (lf.position.x < position.x and lf.position.y < position.y):
					direction = Vector2(-1, -1)
				elif (lf.position.x > position.x and lf.position.y < position.y):
					direction = Vector2(1, -1)
				elif (lf.position.x < position.x and lf.position.y > position.y):
					direction = Vector2(-1, 1)
				elif (lf.position.x > position.x and lf.position.y > position.y):
					direction = Vector2(1, 1)
				if lf.position.distance_to(position) < 130:
					_return()
			$AnimatedSprite.animation = "walk"
			if direction.x != previous_direction.x and previous_direction.x != 0:
				scale.x *= -1
				if original_scale != null:
					original_scale.y *= -1
				flip = not flip
				shot_direction.x *= -1
			previous_direction = direction
			return direction
		IDLE:
			$AnimatedSprite.animation = "idle"
			if lf.is_stopped:
				ia_state = WALK
			previous_direction = Vector2.ZERO
			return Vector2.ZERO

func _return():
	get_parent().remove_child(lf)
	add_child(lf)
	is_returned = true
	lf.position = Vector2(10, -185)
	speed = 1000
	direction.x = 0
	direction.y = -direction.y

func _on_collision_environment():
	if is_returned:
		direction.y *= -1

func _on_TriggerAttack(body):
	if ia_state != IDLE and is_returned:
		ia_state = IDLE
		lf.position = $launch_point.global_position
		lf.set_direction(shot_direction)
		lf.scale = Vector2(1,1)
		remove_child(lf)
		get_parent().add_child(lf)
		lf.is_stopped = false
		is_returned = false
		speed = 10000

func _end_effect():
	get_parent().remove_child(lf)
	add_child(lf)
	._end_effect()
