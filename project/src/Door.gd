extends StaticBody2D

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var collision_shape: CollisionShape2D = get_node("CollisionShape2D")
onready var collision_area: CollisionShape2D = get_node("Area2D/CollisionShape2D")

export var is_vertical: bool = false
export var is_enabled: bool = false
export var offset: float = 150

var next: int
signal entered(next_room)

func _ready() -> void:
	if not is_enabled:
		animated_sprite.hide()

func enable(n: int) -> void:
	animated_sprite.show()
	is_enabled = true
	next = n

func open() -> void:
	if is_enabled:
		animated_sprite.play("open")
		collision_shape.disabled = true

func close() -> void:
	animated_sprite.play("close")
	collision_shape.disabled = false


func set_player_position(player: Character, assistant: Node):
	player.position = $PlayerSpawnPoint.global_position
	assistant.position = $AssistantSpawnPoint.global_position

func _on_Area2D_body_entered(_body: KinematicBody2D) -> void:
	if is_instance_valid(_body):
		emit_signal("entered", next)
