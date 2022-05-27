extends StaticBody2D

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
onready var collision_area: CollisionShape2D = get_node("Area2D/CollisionShape2D")

var is_V: bool

func _ready() -> void:
	if name.ends_with("V"):
		is_V = true
	else:
		is_V = false

func open() -> void:
	animated_sprite.play("open")
	collision_shape.disabled = true

func close() -> void:
	animated_sprite.play("close")
	collision_shape.disabled = false

func _on_Area2D_body_entered(_body: KinematicBody2D) -> void:
	if is_instance_valid(_body):
		if is_V == false:
			if scale.x > 0:
				_body.position.x -= ((collision_area.shape.extents.x * 2) + (collision_shape.shape.extents.x * 2) + 20)
			else:
				_body.position.x += ((collision_area.shape.extents.x * 2) + (collision_shape.shape.extents.x * 2) + 20)
		else:
			if scale.y > 0:
				_body.position.y -= ((collision_area.shape.extents.y * 2) + (collision_shape.shape.extents.y * 2) + 20)
			else:
				_body.position.y += ((collision_area.shape.extents.y * 2) + (collision_shape.shape.extents.y * 2) + 20)
