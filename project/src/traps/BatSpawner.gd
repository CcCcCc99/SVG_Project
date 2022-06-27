extends Sprite

export(PackedScene) var bat
export var flipx: bool
export var flipy: bool

func _ready():
	if flipx && flipy:
		self.offset.y = -350
	elif flipx && !flipy:
		self.flip_h = true
		self.offset.x = 350
	elif !flipx && flipy:
		self.flip_v = true
		self.offset.x = -350
	else:
		self.flip_h = true
		self.flip_v = true
		self.offset.y = 350
	
	$Timer.start()

func _on_Timer_timeout():
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
	b.position = global_position
	get_parent().add_child(b)
