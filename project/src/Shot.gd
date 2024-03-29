extends Area2D
class_name Shot

export(bool) var is_shot

enum {NORMAL, SCALEUP, SCALEDOWN}
var state = NORMAL

export var speed = 10000
export var damage = 1

var direction: Vector2 = Vector2.ZERO

var is_summoned: bool = false

signal scaled_down
signal scaled_up

func _ready():
	self.connect("scaled_down", self, "_teleport")

func _physics_process(delta):
	if state == SCALEDOWN:
		_scale_down()
	elif state == SCALEUP:
		_scale_up()
	else:
		position += direction * speed * delta

func set_direction(dir: Vector2):
	direction = dir.normalized()
	_update_grafic()

func _update_grafic():
	scale.x = -1 if direction.x > 0 else 1
	scale.y = -1 if direction.y > 0 else 1

func _on_hit(body: Node):
	if body.is_in_group("Environment"):
		if is_shot:
			queue_free()
	
	elif body.is_in_group("Character"):
		body.take_damage(damage)
		
	elif body.is_in_group("Portal"):
		body._on_Portal_body_entered(self)


var destination = null

func _reset_animations():
	scale.x = 1 if scale.x > 0 else -1
	scale.y = 1 if scale.y > 0 else -1
	visible = true
	rotation = 0
	_update_grafic()

func teleport_to(dest: Portal2D):
	if is_instance_valid(dest):
		destination = dest.position
		start_scaling_down()

func _teleport():
	position = destination
	start_scaling_up()

func _scale_up():
	if _abs_scale() < Vector2(1,1):
		scale *= 1.1
	else:
		emit_signal("scaled_up")
		_reset_animations()
		state = NORMAL

func _abs_scale():
	return Vector2(abs(scale.x), abs(scale.y))

func _scale_down():
	if scale > Vector2(0.1,0.1):
		scale *= 0.9
	else:
		emit_signal("scaled_down")

func start_scaling_down():
	state = SCALEDOWN

func start_scaling_up():
	state = SCALEUP

func back_to_normal():
	state = NORMAL
