extends Area2D

export var speed = 10000
export var damage = 3

var direction = Vector2(-1,0)

var is_in_portal: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.s
func _process(delta):
	position += direction * speed * delta

func set_direction(dir):
	direction = dir
	if dir.x > 0:
		$AnimatedSprite.flip_h = true
	if dir.y > 0:
		$AnimatedSprite.flip_v = true

func _on_hit(body):
	if body.is_in_group("Environment"):
		queue_free()
		
	elif body.is_in_group("Player"):
		body.take_damage(damage)
		
	elif body.is_in_group("Portal"):
		body._on_Portal_body_entered(self)
