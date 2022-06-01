extends Area2D

export var speed = 10000
export var damage = 3

var direction = -1

var is_in_portal: bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.s
func _process(delta):
	position.x += direction * speed * delta

func set_direction(dir):
	direction = dir
	if dir > 0:
		$AnimatedSprite.flip_h = true

func _on_hit(body):
	if body.is_in_group("Environment"):
		#print("Env: ",body)
		speed = 0
		queue_free()
		
	elif body.is_in_group("Player"):
		#print("Player: ", body)
		body.take_damage(damage)
		
	elif body.is_in_group("Portal"):
		body._on_Portal_body_entered(self)
