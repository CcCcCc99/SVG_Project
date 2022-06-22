extends Area2D
class_name Shot

export(bool) var is_shot

enum {NORMAL, SCALEUP, SCALEDOWN}
var state = NORMAL

export var speed = 10000
export var damage = 1

var direction = Vector2.ZERO

var is_in_portal: bool = true

var is_summoned: bool = false
var enemy: String


signal scaled_down
signal scaled_up

func _ready():
	self.connect("scaled_down", self, "_teleport")
	if is_summoned:
		enemy = "Mob"
	else:
		enemy = "Player"

func _physics_process(delta):
	if state == SCALEDOWN:
		_scale_down()
	elif state == SCALEUP:
		_scale_up()
	else:
		position += direction * speed * delta

func set_direction(dir: Vector2):
	direction = dir.normalized()
	if dir.x > 0:
		$AnimatedSprite.flip_h = true
	if dir.y > 0:
		$AnimatedSprite.flip_v = true

func _on_hit(body):
	if body.is_in_group("Environment"):
		if is_shot:
			queue_free()
		speed = 0
		
	elif body.is_in_group(enemy):
		body.take_damage(damage)
		
	elif body.is_in_group("Portal"):
		body._on_Portal_body_entered(self)


var destination = null

func _reset_animations():
	scale = Vector2(1,1)
	visible = true
	rotation = 0

func teleport_to(dest: Portal2D):
	if is_instance_valid(dest):
		destination = dest.position
		start_scaling_down()

func _teleport():
	position = destination
	start_scaling_up()

func _scale_up():
	if scale < Vector2(1,1):
		scale *= 1.1
	else:
		emit_signal("scaled_up")
		_reset_animations()
		state = NORMAL

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
