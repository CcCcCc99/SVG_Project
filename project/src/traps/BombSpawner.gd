extends AnimatedSprite

export(PackedScene) var bomb
#export var flipx: bool
#export var flipy: bool

func _ready():
	"""
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
	"""
	$Timer.start()

func _on_Timer_timeout():
	var b = bomb.instance()
	"""
	if flipx && flipy:
		# b.set_direction(Vector2(1, 0))
		b.set_direction(Vector2(0, 1))
	elif flipx && !flipy:
		b.set_direction(Vector2(-1, 0))
	elif !flipx && flipy:
		b.set_direction(Vector2(1, 0))
	else:
		b.set_direction(Vector2(0, -1))
	"""
	b.position.x = global_position.x - 40
	b.position.y = global_position.y + 60
	get_parent().add_child(b)
