extends Sprite
export(PackedScene) var bat
export var flipx: bool
export var flipy: bool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


func _on_Timer_timeout():
	var b = bat.instance()
	if flipx && flipy:
		#b.set_direction(Vector2(1,0))
		b.set_direction(Vector2(0,1))
	elif flipx && !flipy:
		b.set_direction(Vector2(-1,0))
	elif !flipx && flipy:
		b.set_direction(Vector2(1,0))
	else:
		b.set_direction(Vector2(0,-1))
	b.get_node("AnimatedSprite").flip_v = false
	b.position = global_position
	get_parent().add_child(b)
