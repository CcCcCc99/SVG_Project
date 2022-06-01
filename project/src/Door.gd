extends StaticBody2D

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
onready var collision_area: CollisionShape2D = get_node("Area2D/CollisionShape2D")

export var is_vertical: bool = false
export var is_enabled: bool = false

func _ready() -> void:
	if not is_enabled:
		animated_sprite.hide()

func enable() -> void:
	animated_sprite.show()
	is_enabled = true

func open() -> void:
	if is_enabled:
		animated_sprite.play("open")
		collision_shape.disabled = true

func close() -> void:
	animated_sprite.play("close")
	collision_shape.disabled = false

func _on_Area2D_body_entered(_body: KinematicBody2D) -> void:
	if is_instance_valid(_body):
		if is_vertical == false:
			if scale.x > 0:
				_body.position.x -= ((collision_area.shape.extents.x * 2) + (collision_shape.shape.extents.x * 2) + 20)
			else:
				_body.position.x += ((collision_area.shape.extents.x * 2) + (collision_shape.shape.extents.x * 2) + 20)
		else:
			if scale.y > 0:
				_body.position.y -= ((collision_area.shape.extents.y * 2) + (collision_shape.shape.extents.y * 2) + 20)
			else:
				_body.position.y += ((collision_area.shape.extents.y * 2) + (collision_shape.shape.extents.y * 2) + 20)
