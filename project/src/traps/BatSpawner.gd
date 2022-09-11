extends Node2D

export(PackedScene) var bat
export var flipx: bool
export var flipy: bool

export var active: bool

func _ready():
	if flipx and flipy:
		scale *= -1
	elif flipx and not flipy:
		rotate(-PI/2)
	elif not flipx and flipy:
		rotate(PI/2)

func set_status(status):
	active = status

func _on_Timer_timeout():
	if not active:
		return
	var b = bat.instance()
	if flipx && flipy:
		# b.set_direction(Vector2(1, 0))
		b.set_direction(Vector2(0, 1))
	elif flipx && !flipy:
		b.set_direction(Vector2(-1, 0))
	elif !flipx && flipy:
		b.set_direction(Vector2(1, 0))
	else:
		b.set_direction(Vector2(0, -1))
	
	b.get_node("AnimatedSprite").flip_v = false
	b.position = $Position2D.global_position
	get_parent().add_child(b)
